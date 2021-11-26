//
//  JCForgotPasswordController.swift
//  JennyCraig
//
//  Created by Mobileprogrammingllc on 7/7/18.
//  Copyright © 2018 JennyCraig. All rights reserved.
//

import UIKit
import AWSCognitoIdentityProvider

class JCForgotPasswordController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var userNameTextField: CustomTextField!
    @IBOutlet weak var userNameTextLabel: UILabel!
    @IBOutlet weak var sendPasswordResetButton: UIButton!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var lblForgotTop: NSLayoutConstraint!
    
    private let viewModel = SignUpViewModel()
    private let validator = Validator()
    weak var containerDelegate: UpdateContainerViewDelegate?
    
    var pool: AWSCognitoIdentityUserPool?
    var user: AWSCognitoIdentityUser?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //  sendPasswordResetButton.addShadowView()
        
        //hide keyboard on touch on anywhere in view
        self.hideKeyboard()
        
        //validate text field input values
        self.validateTextFields()
        
        //setup handler
        self.setUpHandler()
        
        //add keyboard notification
        userNameTextField.text = UserDefaults.standard.string(forKey: "userNameForget")
        self.pool = AWSCognitoIdentityUserPool(forKey: Identifiers.AWSCognitoUserPoolsSignInProviderKey)
        
        if !isDeviceOfNotchType() {
            lblForgotTop.constant = 40
            self.view.layoutIfNeeded()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        //remove keyboard observer
        removeKeyboardNotifications()
        //resign selected textfield
        view.endEditing(true)
        //unregister validated text field
        validator.unregisterAllField()
    }
    
    @IBAction func backButtonAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Keyboard Notification
    
    private func registerKeyboardNotification() {
        
        //Add keyboard notification
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
    }
    
    private func removeKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    //---------------------------------
    // MARK: - Notification Center
    //---------------------------------
    
    @objc func keyboardWillHide(notification: Notification) {
        
        let duration = notification.userInfo![UIResponder.keyboardAnimationDurationUserInfoKey] as? Double
        self.view.frame.origin.y = 0
        UIView.animate(withDuration: duration!) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func keyboardWillShow(notification: Notification) {
        
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let duration = notification.userInfo![UIResponder.keyboardAnimationDurationUserInfoKey] as? Double
            // if using constraints
            //self.view.frame.origin.y -= keyboardSize.height/2
            if view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height/2
                UIView.animate(withDuration: duration!) {
                    self.view.layoutIfNeeded()
                }
            }
        }
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.destination is JCPasswordResetController {
            //send data
            
            if let controller = segue.destination as? JCPasswordResetController {
                controller.userNameString = userNameTextField.text
                controller.containerDelegate = containerDelegate
                if #available(iOS 13.0, *) {
                    controller.modalPresentationStyle = .fullScreen
                } else {
                }
                
            }
            
        }
    }
    
    @IBAction func submitButtonClicked(_ sender: UIButton) {
        validator.validate(self)
    }
    
    //---------------------------------
    // MARK: - UITextField Delegates
    //-
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        validator.validateField(textField) { _ in
            
        }
    }
}

extension JCForgotPasswordController: ValidationDelegate {

    //---------------------------------
    // MARK: - Register TextField for Validation
    //---------------------------------

    private func validateTextFields() {
        
      validator.styleTransformers(success: { (validationRule) -> Void in
            // clear error label
            validationRule.errorLabel?.isHidden = true
            validationRule.errorLabel?.text = ""

        }, error: { (validationError) -> Void in
            //if any error occur
            validationError.errorLabel?.isHidden = false
            validationError.errorLabel?.text = validationError.errorMessage
        })

        //register all the textfield with rules
        validator.registerField(userNameTextField, errorLabel: userNameTextLabel, rules: [RequiredRule(message: "This field is required"), EmailValidationRule()])

    }

    // MARK: ValidationDelegate Methods

    func validationSuccessful() {

        if !Reachability.isConnectedToNetwork() {
            /*self.popupAlert(title: "", message: Identifiers.Message.NoInternetConnectivity, actionTitles: ["Ok"], actions: [ {action1 in
                }, nil])*/
            return
        }

        UIViewController.displaySpinner()

        let email = userNameTextField.text?.trimmingTrailingSpaces.lowercased()
        jcPrint(email!)
        self.user = self.pool?.getUser(email!)

        self.user?.forgotPassword().continueWith {[weak self] (task: AWSTask) -> AnyObject? in
            guard let _ = self else {
                return nil

            }
            DispatchQueue.main.async(execute: {
                UIViewController.removeSpinner()

                if let error = task.error as NSError? {

                    if error.userInfo["__type"] as? String == ExceptionString.userNotFoundException.rawValue {
                        self!.popupAlert(title: "", message: Identifiers.Message.EmailNotAssociated, actionTitles: ["Ok"], actions: [ {action1 in
                            UIViewController.removeSpinner()

                            }, nil])
                    } else {

                        self?.popupAlert(title: "", message: error.userInfo["message"] as? String, actionTitles: ["Ok"], actions: [ {action1 in
                            UIViewController.removeSpinner()
                            }, nil])
                    }

                } else {
                        self?.performSegue(withIdentifier: Identifiers.SegueIdentifiers.JCResetPasswordSegueIdentifier, sender: self)
                    }
            })
            return nil
        }
    }

    func validationFailed(_ errors: [(Validatable, ValidationError)]) {
        jcPrint("Validation FAILED!")
    }

    //set up view model handler
    private func setUpHandler() {

        viewModel.successViewClosure = { [weak self] (response) in
            DispatchQueue.main.async {

                UIViewController.removeSpinner()

                guard (response.successful != 0) else {

                    //show alert
                    self?.popupAlert(title: "", message: response.message, actionTitles: ["Ok"], actions: [ {action1 in
                        }, nil])
                    return
                }

                self?.popupAlert(title: "", message: response.message, actionTitles: ["Ok"], actions: [ {action1 in
                    self?.performSegue(withIdentifier: Identifiers.SegueIdentifiers.JCResetPasswordSegueIdentifier, sender: self)
                    }, nil])

            }
        }

        viewModel.showAlertClosure = { [weak self] (message) in
            DispatchQueue.main.async {

                //show alert
                self?.popupAlert(title: "", message: message, actionTitles: ["Ok"], actions: [ {action1 in
                    }, nil])
            }
            } as ((String) -> Void)
    }

}
