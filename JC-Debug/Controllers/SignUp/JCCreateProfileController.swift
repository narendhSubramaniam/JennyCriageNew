//  JCCreateProfileController.swift
//  JennyCraig
//  Created by Mobileprogrammingllc on 6/25/18.
//  Copyright © 2018 JennyCraig. All rights reserved.

import UIKit
import AWSCognitoIdentityProvider

class JCCreateProfileController: UIViewController, UITextFieldDelegate, UITextViewDelegate, UIScrollViewDelegate, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var userNameTextField: CustomTextField!
    @IBOutlet weak var passwordTextField: CustomTextField!
    @IBOutlet weak var firstNameTextField: CustomTextField!
    @IBOutlet weak var lastNameTextField: CustomTextField!
    @IBOutlet weak var confirmPasswordTextField: CustomTextField!
    @IBOutlet weak var imgLogoTop: NSLayoutConstraint!
    @IBOutlet weak var viewTop: NSLayoutConstraint!
    @IBOutlet weak var userNameTextLabel: UILabel!
    @IBOutlet weak var passwordTextLabel: UILabel!
    @IBOutlet weak var firstNameNameTextLabel: UILabel!
    @IBOutlet weak var lastNameTextLabel: UILabel!
    @IBOutlet weak var confirmPasswordLabel: UILabel!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var agreedBtn: UIButton!
    @IBOutlet weak var privacyBtn: UIButton!
    @IBOutlet weak var logInBtn: UIButton!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var rememberBtn: UIButton!
    @IBOutlet weak var toggleCreateBtn: UIButton!
    @IBOutlet weak var toggleConfirmBtn: UIButton!
    
    var tapGesture = UITapGestureRecognizer()
    var viewModel: SignUpViewModel?
    weak var containerDelegate: UpdateContainerViewDelegate?
    private var validator = Validator()
    var selectedCountry = ""
    // AWS
    var passwordAuthenticationCompletion: AWSTaskCompletionSource<AWSCognitoIdentityPasswordAuthenticationDetails>?
    
    private let loginViewModel = LoginViewModel()
    var confirmEmailViewModel = ConfirmEmailIdViewModel()
    var signInViewModel = SignInViewModel()
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        continueButton.isEnabled = false
        setUpUserSigninHandler()
        setUploginApiHandler()
        
        self.continueButton.backgroundColor = UIColor(red: 152/255, green: 164/255, blue: 174/255, alpha: 1.0)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(noti:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(noti:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        // To disable Automatic Strong Password from Password textField
        if #available(iOS 10.0, *) {
            passwordTextField.textContentType = UITextContentType(rawValue: "")
            confirmPasswordTextField.textContentType = UITextContentType(rawValue: "")
        }
        
        self.hideKeyboard()
        
        self.validateTextFields()
        
        // setusername for webUser
        /*   if iswebUser == true {
         //self.viewModel = SignUpViewModel()
         self.viewModel?.userInfo.username = idForWebUser
         }
         
         if let model = viewModel?.userInfo {
         userNameTextField.text = model.username!
         UserDefaults.standard.set(userNameTextField.text, forKey: "EmailAddress")
         UserDefaults.standard.synchronize()
         } */
        //******* newlogic***********
        self.viewModel = SignUpViewModel()
        
        if iswebUser, let _ = viewModel?.userInfo {
            self.viewModel?.userInfo.username = idForWebUser
            userNameTextField.text = viewModel?.userInfo.username!
            let emailText = self.userNameTextField.text?.lowercased().removingWhitespaces()
            AuthController.setUsername(username: emailText!)
            UserDefaults.standard.synchronize()
            userNameTextField.isUserInteractionEnabled = false
        }
        //******* newlogic***********
        self.setUpHandler()
        
        if iswebUser == true {
            passwordTextField.text = AuthController.getPassword(username: userNameTextField.text!)
            passwordTextField.isUserInteractionEnabled = false
            confirmPasswordTextField.text = AuthController.getPassword(username: userNameTextField.text!)
            confirmPasswordTextField.isUserInteractionEnabled = false
            firstNameTextField.text =  firstNameWebUser
            firstNameTextField.isUserInteractionEnabled = false
            lastNameTextField.text = lastNameWebUser
            lastNameTextField.isUserInteractionEnabled = false
            self.navigationController?.setNavigationBarHidden(true, animated: false)
            
        } else {
            self.firstNameTextField.becomeFirstResponder()
        }
        if !isDeviceOfNotchType() {
            imgLogoTop.constant = 60
            self.view.layoutIfNeeded()
        }
        if !isDeviceOfNotchType() {
            viewTop.constant = 145
            self.view.layoutIfNeeded()
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.hideKeyboard()
        if iswebUser == false {
            self.firstNameTextField.becomeFirstResponder()
        }
        self.validateTextFields() // Initialise validation rules if user comes back from signup page
        UIViewController.removeSpinner()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        removeKeyboardObserver()
        view.endEditing(true)
        validator.unregisterAllField()
    }
    
    // MARK: - IBAction
    @IBAction func buttonBackAction(_ sender: Any) {
        
        AuthController.cleanUpStoredInfo()
        iswebUser = false
        self.navigationController?.popViewController(completion: {
            AWSHandler.sharedInstance.logOut()
            
        })
    }
    @IBAction func toggleCreatePasswordAction(_ sender: UIButton) {
        
        togglePassword(textField: passwordTextField, sender: sender)
    }
    
    @IBAction func toggleConfirmPasswordAction(_ sender: UIButton) {
        
        togglePassword(textField: confirmPasswordTextField, sender: sender)
    }
    @IBAction func rememberMeButtonAction(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            UserDefaults.standard.set(false, forKey: "rememberme")
            UserDefaults.standard.removeObject(forKey: "userName")
            isChecked = false
            
        } else {
            UserDefaults.standard.set(true, forKey: "rememberme")
            UserDefaults.standard.set(userNameTextField.text, forKey: "userName")
            isChecked = true
        }
        
    }
    @IBAction func privacyPolicyClicked(_ sender: Any) {
        
        let privacyVC = UIStoryboard.privacyPolicyViewController()
        if #available(iOS 13.0, *) {
            privacyVC?.modalPresentationStyle = .fullScreen
        } else {
        }
        self.present(privacyVC!, animated: true, completion: nil)
    }
    @IBAction func agreedBtnAction(_ sender: UIButton) {
        
        sender.isSelected = !sender.isSelected
        continueButton.isEnabled = sender.isSelected ? true : false
        self.continueButton.backgroundColor = continueButton.isEnabled ? .slateBlue : UIColor(red: 152/255, green: 164/255, blue: 174/255, alpha: 1.0)
    }
    // MARK: - Functions
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == tableView {
            if scrollView.contentOffset.y > 225 {
                scrollView.contentOffset = CGPoint.init(x: 0, y: 225)
            }
        }
    }
    @objc func passwordHintAlert(_ sender: UITapGestureRecognizer) {

        self.popupAlert(title: "", message: Identifiers.Message.atLeast6DigitMessage, actionTitles: ["Ok"], actions: [ {action1 in
            }, nil])
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func dismissKeyboard() {
        super.dismissKeyboard()
    }
    
    //---------------------------------
    // MARK: - Notification Center
    //---------------------------------
    
    @objc func keyboardWillHide(noti: Notification) {
        _ = UIEdgeInsets.zero
    }
    
    @objc func keyboardWillShow(noti: Notification) {
        guard let userInfo = noti.userInfo else { return }
        guard var keyboardFrame: CGRect = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue else { return }
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)
    }
    
    //---------------------------------
    // MARK: - Custom Actions
    //---------------------------------
    
    @IBAction func continueButtonPressed(_ sender: UIButton) {
        
        isChecked = true
        if !Reachability.isConnectedToNetwork() {
            /*self.popupAlert(title: "", message: Identifiers.Message.NoInternetConnectivity, actionTitles: ["Ok"], actions: [ {action1 in
             }, nil])*/
            return
        }
        
        if self.passwordTextField.text == self.confirmPasswordTextField.text {
            if (passwordTextField.text?.isPasswordValid())! {
            } else {
                self.popupAlert(title: "", message: Identifiers.Message.PasswordValidation, actionTitles: ["Ok"], actions: [ {action1 in
                    }, nil])
                return
            }
            view.endEditing(true)
            validator.validate(self)
        } else {
            self.popupAlert(title: "", message: Identifiers.Message.PasswordMatch, actionTitles: ["Ok"], actions: [ {action1 in
                self.passwordTextField.becomeFirstResponder()
                
                }, nil])
        }
        
    }
    @IBAction func actionLogIn(_ sender: Any) {
        let signInVC = UIStoryboard.signInViewController()
        self.navigationController?.pushViewController(signInVC!, animated: true)
    }
    
    //---------------------------------
    // MARK: - UITextField Delegates
    //-
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        var nextTag = textField.tag
        if textField.tag == 10 {
            nextTag = 100
        } else if textField.tag == 100 {
            nextTag = 12
        } else {
            nextTag = textField.tag + 1
        }
        
        if let nextResponder = self.view.viewWithTag(nextTag) {
            nextResponder.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        
        validator.validateField(textField) { error in
            jcPrint(error)
        }
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.destination is JCAccountInfoController {
            //send data
            if let controller = segue.destination as? JCAccountInfoController {
                JCAnalyticsManager.shared.logEvent(eventName: "sign_up", parameters: ["username": userNameTextField.text!])
                controller.viewModel = viewModel!
                controller.containerDelegate = containerDelegate
            }
            
        } else if segue.destination is JCConfirmEmailController {
            //send data
            if let controller = segue.destination as? JCConfirmEmailController {
                controller.viewModel = viewModel
                controller.emailID = userNameTextField.text!
            }
            
        }
    }
    // MARK: - SetUp Handler
    private func setUpHandler() {
        viewModel?.successViewClosure = { [weak self] (response) in
            DispatchQueue.main.async {
                if response.successful == 1 {
                    AWSHandler.sharedInstance.logOut()
                    
                } else {
                    //show error alert
                    self?.popupAlert(title: "", message: response.message, actionTitles: ["Ok"], actions: [ {action1 in
                        }, nil])
                }
            }
        }
        self.viewModel?.showAlertClosure = { [weak self] (message) in
            DispatchQueue.main.async {
                UIViewController.removeSpinner()
                self?.popupAlert(title: "", message: message, actionTitles: ["Ok"], actions: [ {action1 in
                    }, nil])
            }
            } as ((String) -> Void)
    }
    
    func confirmSignUp() {
        boolIsConfirmSignup = true
        let pathNew = JCPostServicePath.confirmSignup(firstName: "", lastName: "", jennyid: "", phone: "", startingWeight: "", goalWeight: "", deviceType: "", deviceToken: "", userType: "", startingWeightDate: "", country: "", purpose: "", purposeReminder: 0, motivation: "", motivationReminder: 0, newsLetter: 0, isConfirm: true, sonicLogic: 1)
        self.viewModel?.callRegisterUserWebServices(servicePath: pathNew, withUserName: self.userNameTextField.text!.lowercased().removingWhitespaces())
    }
}
extension JCCreateProfileController: ValidationDelegate {
    
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
        
        validator.registerField(firstNameTextField, errorLabel: nil, rules: [RequiredRule()])
        validator.registerField(lastNameTextField, errorLabel: nil, rules: [RequiredRule()])
        validator.registerField(userNameTextField, errorLabel: nil, rules: [RequiredRule(), EmailValidationRule()])
        
    }
    
    // MARK: ValidationDelegate Methods
    
    func validationSuccessful() {
        
        let emailText = self.userNameTextField.text?.lowercased().removingWhitespaces()
        AuthController.setUsername(username: emailText!)
        UIViewController.displaySpinner()
        if  isChecked == true {
            UserDefaults.standard.set(userNameTextField.text, forKey: "userName")
        }
        if iswebUser {
            /*self.viewModel?.userInfo.firstName = self.firstNameTextField.text
             self.viewModel?.userInfo.lastName =  self.lastNameTextField.text
             self.viewModel?.userInfo.username = self.userNameTextField.text
             passwordLocalSignup = self.passwordTextField.text!
             self.viewModel?.userInfo.jennyid =   "1234"
             self.performSegue(withIdentifier: Identifiers.SegueIdentifiers.JCGoalWeightSegueIdentifier, sender: self)
             */
            self.fillSignUpData()
            self.registerUserInSonic()
            
        } else {
            
            AWSHandler.sharedInstance.checkIfEmailExistInCognito(email: emailText!) { (exist, exception) in
                
                if let _ = exception {
                    
                    switch exception {
                    case .notAuthorizedException, .resourceConflictException:
                        // Account with this email does exist.
                        self.performSegue(withIdentifier: Identifiers.SegueIdentifiers.JCEmailAlreadyExistSegueIdentifier, sender: self)
                    case .userNotConfirmedException:
                        self.fillSignUpData()
                        
                        self.performSegue(withIdentifier: Identifiers.SegueIdentifiers.JCConfirmEmailSegueIdentifier, sender: self)
                        //self.confirmEmailViewModel.confirmEmailId(withUserName: self.userNameTextField.text!)
                        //self.confirmSignUp()
                        
                    default:
                        // Some other exception (e.g., UserNotFoundException). Allow user to proceed.
                        self.registerUserInCognito()
                    }
                    return
                }
                
                if !exist {
                    self.registerUserInCognito()
                } else {
                    
                    if iswebUser {
                        self.performSegue(withIdentifier: Identifiers.SegueIdentifiers.JCConfirmEmailSegueIdentifier, sender: self)
                        //self.confirmEmailViewModel.confirmEmailId(withUserName: self.userNameTextField.text!)
                        //self.confirmSignUp()
                    } else {
                        self.performSegue(withIdentifier: Identifiers.SegueIdentifiers.JCEmailAlreadyExistSegueIdentifier, sender: self)
                        
                    }
                }
            }
        }
    }
    func fillSignUpData() {
        self.viewModel?.userInfo.firstName = self.firstNameTextField.text?.trimmingTrailingSpaces
        self.viewModel?.userInfo.lastName =  self.lastNameTextField.text?.trimmingTrailingSpaces
        self.viewModel?.userInfo.username = self.userNameTextField.text?.trimmingTrailingSpaces
        passwordLocalSignup = self.passwordTextField.text!
        self.viewModel?.userInfo.jennyid =   "1234"
    }
    func registerUserInCognito() {
        self.fillSignUpData()
        //  self.performSegue(withIdentifier: Identifiers.SegueIdentifiers.JCGoalWeightSegueIdentifier, sender: self)
        
        //change for SONIC
        if let model = self.viewModel?.userInfo {
            AWSHandler.sharedInstance.registerUserInCognito(userInfo: model) { (success, error) in
                if success {
                    
                    //here we have to present confirm email screen
                    self.performSegue(withIdentifier: Identifiers.SegueIdentifiers.JCConfirmEmailSegueIdentifier, sender: self)
                    //self.confirmEmailViewModel.confirmEmailId(withUserName: self.userNameTextField.text!)
                    /* DispatchQueue.main.async {
                     self.confirmSignUp()
                     } */
                    
                } else {
                    if error != nil {
                        self.popupAlert(title: "", message: error?.userInfo["message"] as? String, actionTitles: ["OK"], actions: [ {action1 in
                            UIViewController.removeSpinner()
                            }, nil])
                    } else {
                        _ = self.navigationController?.popToRootViewController(animated: true)
                    }
                }
            }
        }
    }
    
    func validationFailed(_ errors: [(Validatable, ValidationError)]) {
        jcPrint("Validation FAILED!")
        
        for validate in errors {
            self.showAlert(withText: validate.1.errorMessage)
            break
        }
    }
    
    func showAlert(withText text: String) {
        self.popupAlert(title: "", message: text, actionTitles: ["Ok"], actions: [ {action1 in
            }, nil])
    }
}
extension JCCreateProfileController: AWSCognitoIdentityPasswordAuthentication {
    
    func signInUserInCognito() {
        let emailText = self.userNameTextField.text?.trimmingTrailingSpaces
        let authDetails = AWSCognitoIdentityPasswordAuthenticationDetails(username: (emailText!.lowercased()), password: passwordLocalSignup )
        self.passwordAuthenticationCompletion?.set(result: authDetails)
    }
    
    public func getDetails(_ authenticationInput: AWSCognitoIdentityPasswordAuthenticationInput, passwordAuthenticationCompletionSource: AWSTaskCompletionSource<AWSCognitoIdentityPasswordAuthenticationDetails>) {
        self.passwordAuthenticationCompletion = passwordAuthenticationCompletionSource
        signInUserInCognito()
    }
    
    public func didCompleteStepWithError(_ error: Error?) {
        
        jcPrint("didCompleteStepWithError")
        
        DispatchQueue.main.async {
            if let error = error as NSError? {
                
                let errorTitle = error.userInfo["message"] as? String
                if errorTitle ==  "Incorrect username or password." {
                    self.popupAlert(title: "", message: Identifiers.Message.IncorrectEmailOrPassword, actionTitles: ["Retry"], actions: [ {action1 in
                        UIViewController.removeSpinner()
                        }, nil])
                } else {
                    
                    self.popupAlert(title: "", message: error.userInfo["message"] as? String, actionTitles: ["Retry"], actions: [ {action1 in
                        UIViewController.removeSpinner()
                        }, nil])
                }
                
            } else {
                
                do {
                    let emailText = self.viewModel?.userInfo.username?.trimmingTrailingSpaces
                    jcPrint(emailText!)
                    AuthController.setUsername(username: (emailText?.lowercased())!)
                    try AuthController.setPassword(username: (emailText?.lowercased())!, password: passwordLocalSignup)
                } catch {
                    jcPrint("Error signing in: \(error.localizedDescription)")
                }
                
                JCAnalyticsManager.shared.logEvent(eventName: "login")
                
                AWSHandler.sharedInstance.userDetailsCompletionBlock = { (error) -> Void in
                    
                    if (error != nil) {
                        
                        self.popupAlert(title: "", message: error?.userInfo["message"] as? String, actionTitles: ["Ok"], actions: [ {action1 in
                            }, nil])
                    } else {
                        self.registerUserInSonic()
                    }
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
                    
                    jcPrint("AWSHandler.sharedInstance.setUpAWS(called)")
                    AWSHandler.sharedInstance.setUpAWS()
                    
                })
            }
        }
    }
}

extension JCCreateProfileController {
    private func setUploginApiHandler() {
        // MARK: Login to send access token to server
        loginViewModel.successViewClosure = { [weak self] () in
            DispatchQueue.main.async {
                
                if self?.loginViewModel.isRegister == 1 {
                    Identifiers.APPDELEGATE?.window?.rootViewController = UIStoryboard.dashboardStoryboard().instantiateInitialViewController()
                } else if  self?.loginViewModel.isRegister == 0 {
                    self?.registerUserInSonic()
                    
                    /*
                     iswebUser = true
                     idForWebUser = AuthController.getUserName()!
                     let signupVC = UIStoryboard.profileCreator()
                     self?.navigationController?.pushViewController(signupVC!, animated: true)
                     */
                }
            }
        }
        
        loginViewModel.showAlertClosure = { [weak self] (message) in
            DispatchQueue.main.async {
                
                UIViewController.removeSpinner()
                self?.popupAlert(title: "", message: message, actionTitles: ["Ok"], actions: [ {action1 in
                    }, nil])
            }
            } as ((String) -> Void)
    }
    func registerUserInSonic() {
        signInViewModel.registerUserInSonic(firstName: (self.viewModel?.userInfo.firstName)!, lastName: (self.viewModel?.userInfo.lastName)!, timeStamp: Date().stringFromDate(with: Identifiers.yyyyMMddFormatter))
        //sonicAPICalled = true
    }
    
    private func setUpUserSigninHandler() {
        // MARK: Login to send access token to server
        signInViewModel.successViewClosure = { [weak self] () in
            DispatchQueue.main.async {
                
                UIViewController.removeSpinner()
                let accountInfoController =  UIStoryboard.accountInfoController()
                accountInfoController?.signInModel = self?.signInViewModel.model
                self?.navigationController?.pushViewController(accountInfoController!, animated: true)
                
            }
        }
        
        signInViewModel.showAlertClosure = { [weak self] (message) in
            DispatchQueue.main.async {
                
                UIViewController.removeSpinner()
                self?.popupAlert(title: "", message: message, actionTitles: ["Ok"], actions: [ {action1 in
                    }, nil])
            }
            } as ((String) -> Void)
    }
}
