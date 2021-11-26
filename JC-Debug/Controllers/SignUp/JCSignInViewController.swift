//
//  SignInViewController.swift
//  JennyCraig
//
//  Created by Mobileprogrammingllc on 6/21/18.
//  Copyright © 2018 JennyCraig. All rights reserved.
//

import UIKit
import AWSCognitoIdentityProvider

class JCSignInViewController: UIViewController, UITextFieldDelegate {

    // MARK: Outlets
    @IBOutlet weak var emailTextField: CustomTextField!
    @IBOutlet weak var passwordTextField: CustomTextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var forgotButton: UIButton!
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var imgLogoTop: NSLayoutConstraint!
    @IBOutlet weak var touchIDView: UIView!
    @IBOutlet weak var validationTextLabel: UILabel!
    @IBOutlet weak var backBtn: UIButton!
     @IBOutlet weak var toggleBtn: UIButton!
     @IBOutlet weak var rememberBtn: UIButton!
    private let viewModel = LoginViewModel()
    weak var containerDelegate: UpdateContainerViewDelegate?

    var passwordAuthenticationCompletion: AWSTaskCompletionSource<AWSCognitoIdentityPasswordAuthenticationDetails>?
    // AWS
    var pool: AWSCognitoIdentityUserPool?
    var responseWebuser: AWSCognitoIdentityUserGetDetailsResponse?
    var userWebuser: AWSCognitoIdentityUser?
    var signInViewModel = SignInViewModel()

    // MARK: - View Life Cycle
    override func viewDidLoad() {

        super.viewDidLoad()

        UserDefaults.standard.set(true, forKey: "rememberme")
        isChecked = true

      //  loginButton.addShadowView()
        self.hideKeyboard()
        self.validateTextFields()

        if boolLogout == true {
            self.checkExistingUser()
            boolLogout = false
        }

        if let user = AuthController.getUserName() {
            emailTextField.text = user
        }
        emailTextField.text = UserDefaults.standard.string(forKey: "userName")
        self.setUpHandler()
        setUpUserSigninHandler()
        AWSHandler.sharedInstance.logOut()

        if !isDeviceOfNotchType() {
            imgLogoTop.constant = 60
            self.view.layoutIfNeeded()
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIViewController.removeSpinner()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - IBAction
    @IBAction func togglePasswordAction(_ sender: UIButton) {

        togglePassword(textField: passwordTextField, sender: sender)
    }

    @IBAction func backButtonAction(_ sender: UIButton) {
      //  self.navigationController?.popToRootViewController(animated: true)
        self.navigationController?.popViewController(animated: true)
    }

     // MARK: - Functions
    @objc func checkUserLoggedIn() {
        if let user = AuthController.getUserName() {
            emailTextField.text = user
            passwordTextField.text = ""
        } else {
            emailTextField.text = ""
            passwordTextField.text = ""
        }

        if isFollowingRegistrationProcess == true {
            isFollowingRegistrationProcess = false
            //get the encypted password
            self.emailTextField.text = AuthController.getUserName()
            self.passwordTextField.text = passwordLocalSignup
            //check credintial with JC server
            passwordLocalSignup = ""
            self.validationSuccessful()
        }
    }

    // MARK: Private Methods

    private func checkExistingUser() {

        if AuthController.isSignedIn {

            if let user = AuthController.getUserName() {

                emailTextField.text = user
                if self.biometricType() == BiometricType.touch {
                    //show touch ID view
                    UIView.transition(with: self.view, duration: 0.5, options: .transitionCrossDissolve, animations: {
                        self.touchIDView.isHidden = false
                    })
                }
                //if self.biometricType() == BiometricType.touch || self.biometricType() == BiometricType.face {
                if self.biometricType() == BiometricType.touch {
                    self.authenticateTouchID(userName: user)
                }
            }
        }
    }

    private func authenticateTouchID(userName: String) {

        self.authenticationWithTouchID { (success, _) in

            if success {

                DispatchQueue.main.async {
                    //get the encypted password
           //         self.passwordTextField.text = AuthController.getPassword(username: userName)
                    //get the encrypted username
             //       self.emailTextField.text = AuthController.getUserName()
                    //check credintial with JC server

                    self.passwordTextField.text = passwordLocalSignup
                    self.validationSuccessful()
                }

            } else {
                //handler the touch id not
            }
        }
    }

    //Validated register textfield
    private func validateTextFields() {

        viewModel.validator.styleTransformers(success: { (validationRule) -> Void in
            // clear error label
            validationRule.errorLabel?.isHidden = true
            validationRule.errorLabel?.text = ""

        }, error: { (validationError) -> Void in
            //if any error occur
            validationError.errorLabel?.isHidden = false
            validationError.errorLabel?.text = validationError.errorMessage
        })

        //register all the textfield with rules
        viewModel.validator.registerField(emailTextField, errorLabel: self.validationTextLabel, rules: [RequiredRule(), EmailValidationRule()])
        viewModel.validator.registerField(passwordTextField, errorLabel: self.validationTextLabel, rules: [RequiredRule(), MinLengthRule(length: 6)])
    }

    // MARK: IBActions Methods
    @IBAction func unWindToSignInViewController(_ sender: UIStoryboardSegue) { }

    //sign in button action method
    @IBAction func signInButtonClicked(_ sender: Any) {
        if  isChecked == true {
             UserDefaults.standard.set(emailTextField.text, forKey: "userName")
        }

        boolLogout = false

        if !Reachability.isConnectedToNetwork() {
            /*self.popupAlert(title: "", message: Identifiers.Message.NoInternetConnectivity, actionTitles: ["Ok"], actions: [ {action1 in
                }, nil])*/
            return
        }

        self.view.endEditing(true)
        viewModel.validator.validateField(emailTextField) { error in
            if error != nil {
                jcPrint("Email is not valid")
                self.popupAlert(title: "", message: error?.errorMessage, actionTitles: ["Ok"], actions: [ {action1 in
                    }, nil])
            } else {
                validationSuccessful()
            }
        }

        globalTimer?.invalidate()
        globalTimer = nil

    }
    @IBAction func rememberMeButtonAction(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            UserDefaults.standard.set(false, forKey: "rememberme")
            UserDefaults.standard.removeObject(forKey: "userName")
            isChecked = false

        } else {
            UserDefaults.standard.set(true, forKey: "rememberme")
            UserDefaults.standard.set(emailTextField.text, forKey: "userName")
            isChecked = true
        }

    }
    @IBAction func forgotPasswordACTION(_ sender: Any) {
        let forgotPassword = UIStoryboard.forgotPasswordVC()
        if #available(iOS 13.0, *) {
                 forgotPassword?.modalPresentationStyle = .fullScreen
             } else {
             }
        UserDefaults.standard.set(emailTextField.text, forKey: "userNameForget") //setObject
        self.present(forgotPassword!, animated: true, completion: nil)
    }

    @IBAction func actionSignup(_ sender: Any) {
        
        let createProfileVC = UIStoryboard.init(name: "LoginSignup", bundle: Bundle.main).instantiateViewController(withIdentifier: "JCCreateProfileController") as? JCCreateProfileController

        self.navigationController?.pushViewController(createProfileVC!, animated: true)

    }

    // MARK: Validate single field
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        viewModel.validator.validateField(textField) { error in
            if error == nil {

                // Field validation was successful
                if textField == emailTextField {
                    passwordTextField.becomeFirstResponder()
                }
            }
            textField.resignFirstResponder()
        }
        return true
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.destination is JCForgotPasswordController {

            if let controller = segue.destination as? JCForgotPasswordController {
                controller.containerDelegate = containerDelegate

            }
        } else  if segue.destination is JCConfirmEmailController {

            if let controller = segue.destination as? JCConfirmEmailController {
                controller.emailID = emailTextField.text!
                passwordLocalSignup = self.passwordTextField.text!

            }
        }

        passwordTextField.text = ""

    }

    private func setUpHandler() {
        // MARK: Login to send access token to server
        viewModel.successViewClosure = { [weak self] () in
            DispatchQueue.main.async {

                if self?.viewModel.isRegister == 1 {
                    self?.callUserSignIn()
                } else if  self?.viewModel.isRegister == 0 {

                    UIViewController.removeSpinner()

                    iswebUser = true
                    idForWebUser = AuthController.getUserName()!
                    let createProfileVC = UIStoryboard.profileCreator()
                    self?.navigationController?.pushViewController(createProfileVC!, animated: true)
                }
            }
        }

        viewModel.showAlertClosure = { [weak self] (message) in
            DispatchQueue.main.async {

                UIViewController.removeSpinner()
                self?.popupAlert(title: "", message: message, actionTitles: ["Ok"], actions: [ {action1 in
                    }, nil])
            }
            } as ((String) -> Void)
    }

    private func setUpUserSigninHandler() {

        signInViewModel.successViewClosure = { () in

            Identifiers.APPDELEGATE?.window?.rootViewController = UIStoryboard.dashboardStoryboard().instantiateInitialViewController()
        }

        signInViewModel.showAlertClosure = { [weak self] (message) in

            UIViewController.removeSpinner()
            self?.popupAlert(title: "", message: message, actionTitles: ["Ok"], actions: [ {action1 in
                }, nil])

            } as ((String) -> Void)
    }

    func callUserSignIn() {
         signInViewModel.userSignIn(firstName: firstNameWebUser, lastName: lastNameWebUser, timeStamp: Date().stringFromDate(with: Identifiers.yyyyMMddFormatter))
         //sonicAPICalled = true
     }

}

extension JCSignInViewController: ValidationDelegate {

    // MARK: ValidationDelegate Methods

    func validationSuccessful() {

        UIViewController.displaySpinner()
        signInUserInCognito()
    }

    func validationFailed(_ errors: [(Validatable, ValidationError)]) {
        jcPrint("Validation FAILED!")

        viewModel.validator.validateField(emailTextField) { error in
            if error != nil {
                jcPrint("Email is not valid")
                self.popupAlert(title: "", message: error?.errorMessage, actionTitles: ["Ok"], actions: [ {action1 in
                    }, nil])
            }
        }

    }
}

extension JCSignInViewController: AWSCognitoIdentityPasswordAuthentication {

    func signInUserInCognito() {
          let emailText = emailTextField.text?.trimmingTrailingSpaces
          let authDetails = AWSCognitoIdentityPasswordAuthenticationDetails(username: (emailText!.lowercased()), password: passwordTextField.text! )
          self.passwordAuthenticationCompletion?.set(result: authDetails)
      }

    public func getDetails(_ authenticationInput: AWSCognitoIdentityPasswordAuthenticationInput, passwordAuthenticationCompletionSource: AWSTaskCompletionSource<AWSCognitoIdentityPasswordAuthenticationDetails>) {
        self.passwordAuthenticationCompletion = passwordAuthenticationCompletionSource
        jcPrint("getDetailscalled")
    }

    public func didCompleteStepWithError(_ error: Error?) {

        jcPrint("didCompleteStepWithError")

        DispatchQueue.main.async {
            if let error = error as NSError? {

                UIViewController.removeSpinner()

                let errorTitle = error.userInfo["message"] as? String
                if errorTitle ==  "Incorrect username or password." {

                    self.popupAlert(title: "", message: Identifiers.Message.IncorrectEmailOrPassword, actionTitles: ["Retry"], actions: [ {action1 in
                        UIViewController.removeSpinner()
                        }, nil])

                } else  if errorTitle ==  "User is not confirmed." {

                    AWSHandler.sharedInstance.resendConfirmationCode(email: self.emailTextField.text!.trimmingTrailingSpaces, status: 0)
                    self.performSegue(withIdentifier: Identifiers.SegueIdentifiers.JCConfirmEmailSegueIdentifier, sender: self)

                } else {

                    self.popupAlert(title: "", message: error.userInfo["message"] as? String, actionTitles: ["Retry"], actions: [ {action1 in
                        UIViewController.removeSpinner()
                        }, nil])
                }

            } else {

                do {
                    let emailText = self.emailTextField.text?.trimmingTrailingSpaces
                    jcPrint(emailText!)
                    AuthController.setUsername(username: (emailText?.lowercased())!)
                    try AuthController.setPassword(username: (emailText?.lowercased())!, password: self.passwordTextField.text!)
                } catch {
                    jcPrint("Error signing in: \(error.localizedDescription)")
                }

                JCAnalyticsManager.shared.logEvent(eventName: "login")

                AWSHandler.sharedInstance.userDetailsCompletionBlock = { (error) -> Void in

                    if (error != nil) {

                        self.popupAlert(title: "", message: error?.userInfo["message"] as? String, actionTitles: ["Ok"], actions: [ {action1 in
                            AWSHandler.sharedInstance.logOut()
                            }, nil])
                    } else {
                        self.checkUserType()
                    }
                }

                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {

                    jcPrint("AWSHandler.sharedInstance.setUpAWS(called)")
                    AWSHandler.sharedInstance.setUpAWS()

                })
            }
        }
    }

    func checkUserType() {
        let servicePath = JCPostServicePath.checkregistered
        viewModel.checkRegisteredUserType(servicePath: servicePath)
    }

}
