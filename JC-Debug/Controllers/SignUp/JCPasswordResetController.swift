//
//  JCPasswordResetController.swift
//  JennyCraig
//
//  Created by Mobileprogrammingllc on 7/7/18.
//  Copyright © 2018 JennyCraig. All rights reserved.
//

import UIKit
 import AWSCognitoIdentityProvider

class JCPasswordResetController: UIViewController, UITextFieldDelegate {

    // MARK: Outlets
    @IBOutlet weak var userNameTextField: CustomTextField!
    @IBOutlet weak var passwordTextField: CustomTextField!
    @IBOutlet weak var verifyTokenTextField: CustomTextField!
    @IBOutlet weak var confirmTextField: CustomTextField!
    @IBOutlet weak var confirmPasswordFieldLabel: UILabel!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var sendNewRequestBtn: UIButton!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var toggleConfirmBtn: UIButton!
    @IBOutlet weak var toggleCreateBtn: UIButton!

    private var validator = Validator()
    private var animatorView: UIView?
    weak var containerDelegate: UpdateContainerViewDelegate?
    private let viewModel = SignUpViewModel()

    var userNameString: String?
    var user: AWSCognitoIdentityUser?
    var pool: AWSCognitoIdentityUserPool?

    // MARK: ViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
         DispatchQueue.main.async {
                       UIViewController.removeSpinner()
        }
        self.verifyTokenTextField.becomeFirstResponder()
        //check if user is avilable
        if let text = userNameString {

            userNameTextField.text = text
        }

        //hide keyboard on touch on anywhere in view
        self.hideKeyboard()

        //validate text field input values
        self.validateTextFields()

        //set completion handler from viewmodel object
        self.setUpHandler()

        self.pool = AWSCognitoIdentityUserPool(forKey: Identifiers.AWSCognitoUserPoolsSignInProviderKey)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.accessibility()
    }

    // Accessibility Support
    func accessibility() {

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        removeKeyboardObserver()
        view.endEditing(true)
        validator.unregisterAllField()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }

    @IBAction func toggleNewPasswordAction(_ sender: UIButton) {

        togglePassword(textField: passwordTextField, sender: sender)
    }

    @IBAction func toggleConfirmPasswordAction(_ sender: UIButton) {

        togglePassword(textField: confirmTextField, sender: sender)

    }

    @IBAction func backButtonAction(_ sender: UIButton) {
        if let _ = navigationController?.viewControllers {
            //if coming from JCEmailAlreadyExistVC PAGE
            self.navigationController?.popViewController(animated: true, completion: {
                UIViewController.removeSpinner()
            })
        } else {
            //if coming from JCForgotPasswordController PAGE
            self.dismiss(animated: true, completion: {
                if let container = UIApplication.topViewController() {
                    if container is JCForgotPasswordController {
                        UIViewController.removeSpinner()
                    }
                }
            })
        }
    }

    // MARK: - Notification Center

    @objc func keyboardWillShow(noti: Notification) {

        guard let userInfo = noti.userInfo else { return }
        guard var keyboardFrame: CGRect = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue else { return }
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)

    }

    func sendNewResetCode() {
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
                        UIViewController.removeSpinner()

                    }
                })
                return nil
            }
    }

    @IBAction func sendResetCodeButtonClicked(_ sender: UIButton) {
        sendNewResetCode()
    }

    @IBAction func submitButtonClicked(_ sender: UIButton) {

        if !Reachability.isConnectedToNetwork() {
            /*self.popupAlert(title: "", message: Identifiers.Message.NoInternetConnectivity, actionTitles: ["Ok"], actions: [ {action1 in
                }, nil])*/
            return
        }
        if passwordTextField.text == confirmTextField.text {
            if (passwordTextField.text?.isPasswordValid())! {
                UIViewController.displaySpinner()
                 self.callResetPassword()
            } else {
                self.popupAlert(title: "", message: Identifiers.Message.PasswordValidation, actionTitles: ["Ok"], actions: [ {action1 in
                    }, nil])
            }
        } else {
            self.popupAlert(title: "", message: Identifiers.Message.PasswordDoesNotMatch, actionTitles: ["Ok"], actions: [ {action1 in
                }, nil])
        }
    }
    //---------------------------------
    // MARK: - UITextField Delegates

       func textFieldShouldReturn(_ textField: UITextField) -> Bool {

           let nextTag = textField.tag + 1
           if let nextResponder = self.view.viewWithTag(nextTag) {
               nextResponder.becomeFirstResponder()
           } else {
               textField.resignFirstResponder()
           }
           return true
       }

    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {

        validator.validateField(textField) { _ in

        }
    }
}

extension JCPasswordResetController: ValidationDelegate {
    
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
        validator.registerField(userNameTextField, errorLabel: nil, rules: [RequiredRule(), EmailValidationRule()])
        
        validator.registerField(passwordTextField, errorLabel: nil, rules: [RequiredRule(), MinLengthRule(length: 6)])
        
        validator.registerField(verifyTokenTextField, errorLabel: nil, rules: [RequiredRule()])
        
    }
    
    // MARK: ValidationDelegate Methods
    
    func validationSuccessful() {
        guard passwordTextField.text == confirmTextField.text else {
            confirmPasswordFieldLabel.text = "Confirm password does not match with password field."
            return
        }
        
        if !Reachability.isConnectedToNetwork() {
            /*self.popupAlert(title: "", message: Identifiers.Message.NoInternetConnectivity, actionTitles: ["Ok"], actions: [ {action1 in
             }, nil])*/
            return
        }
        
        confirmPasswordFieldLabel.text = ""
        UIViewController.displaySpinner()
        self.callResetPassword()
    }
    
    func callResetPassword() {
        let email = userNameTextField.text?.trimmingTrailingSpaces
        jcPrint(email!)
        self.user = self.pool?.getUser(email!)
        self.user?.confirmForgotPassword(verifyTokenTextField.text!, password: passwordTextField.text!).continueWith {[weak self] (task: AWSTask) -> AnyObject? in
            guard let _ = self else {
                return nil
                
            }
            
            DispatchQueue.main.async {
                if task.isFaulted == false {
                    UIViewController.removeSpinner()
                    
                    self?.popupAlert(title: "", message: Identifiers.Message.passwordResetConfirmationMessage, actionTitles: ["Ok"], actions: [ {action1 in
                        
                        UIViewController.removeSpinner()
                        //  self?.navigationController?.popToRootViewController(animated: false)
                        self?.view.window?.rootViewController?.dismiss(animated: false, completion: nil)
                        
                        }, nil])
                } else {
                    self?.popupAlert(title: "", message: Identifiers.Message.ResetCodeDoesNotMatch, actionTitles: ["Ok"], actions: [ {action1 in
                        UIViewController.removeSpinner()
                        
                        }, nil])
                }
            }
            return nil
        }
    }
    
    func validationFailed(_ errors: [(Validatable, ValidationError)]) {
        jcPrint("Validation FAILED!")
        //show alert
    }
    
    //set up view model handler
    private func setUpHandler() {
        
        viewModel.successViewClosure = { [weak self] (response) in
            DispatchQueue.main.async {
                
                UIViewController.removeSpinner()
                
                if response.successful == 1 {
                    
                    self?.popupAlert(title: "", message: response.message, actionTitles: ["Ok"], actions: [ {action1 in
                        
                        self?.containerDelegate?.moveBackToMainContainer()
                        
                        }, nil])
                    
                } else {
                    
                    //show alert
                    self?.popupAlert(title: "", message: response.message, actionTitles: ["Ok"], actions: [ {action1 in
                        }, nil])
                    
                }
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
