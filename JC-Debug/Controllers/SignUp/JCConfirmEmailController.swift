//
//  JCConfirmEmailController.swift
//  JennyCraig
//
//  Created by Mobileprogrammingllc on 13/12/19.
//  Copyright © 2019 JennyCraig. All rights reserved.
//

import UIKit
import AWSCognitoIdentityProvider

class JCConfirmEmailController: UIViewController {

    @IBOutlet weak var resetCodeTextField: UITextField!
    
    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var sendCodeButton: UIButton!
    @IBOutlet weak var backBtn: UIButton!
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userFirstNameLabel: UILabel!
    @IBOutlet weak var validationTextLabel: UILabel!

    @IBOutlet weak var validationView: UIView!
    
    @IBOutlet weak var constantHeightForUserFirstNameLabel: NSLayoutConstraint!
    @IBOutlet weak var constantTopForWelcomeLabel: NSLayoutConstraint!
    @IBOutlet weak var constantTopForValidationView: NSLayoutConstraint!

    var emailID = ""
    var passwordAuthenticationCompletion: AWSTaskCompletionSource<AWSCognitoIdentityPasswordAuthenticationDetails>?
    var viewModel: SignUpViewModel?
    var signInViewModel = SignInViewModel()
    var tapGesture = UITapGestureRecognizer()
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.confirmButton.isEnabled = false
        self.resetCodeTextField.delegate = self
        self.confirmButton.backgroundColor = UIColor(red: 152/255, green: 164/255, blue: 174/255, alpha: 1.0)

        if viewModel == nil {
            jcPrint("viewmodel is nil")
            constantHeightForUserFirstNameLabel.constant = 0
            constantTopForWelcomeLabel.constant = -5
            constantTopForValidationView.constant = -20
            userFirstNameLabel.text = ""
            userNameLabel.text = UserDefaults.standard.string(forKey: "userName")

        } else {
            if (viewModel?.userInfo.firstName)!.count > 0 {
                constantHeightForUserFirstNameLabel.constant = 20
                userFirstNameLabel.text = "Hi " + (viewModel?.userInfo.firstName)! + ","
            }
            userNameLabel.text = viewModel?.userInfo.username
        }

        tapGesture = UITapGestureRecognizer(target: self, action: #selector(JCConfirmEmailController.handleTap(_:)))
        tapGesture.numberOfTapsRequired = 1
        tapGesture.numberOfTouchesRequired = 1
        self.validationTextLabel.addGestureRecognizer(tapGesture)
        validationTextLabel.isUserInteractionEnabled = true

        setUpUserSigninHandler()
        AWSHandler.sharedInstance.logOut()
    }

    override func viewWillAppear(_ animated: Bool) {
       // UIViewController.removeSpinner()
    }

    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        self.resetCodeTextField.becomeFirstResponder()
    }
    // MARK: - IBAction
    @IBAction func buttonBackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
           self.view.endEditing(true)
       }

    @IBAction func resendCodeButtonAction(_ sender: UIButton) {

        AWSHandler.sharedInstance.resendConfirmationCode(email: emailID, status: 1)
    }

    @IBAction func confirmButtonClicked(_ sender: UIButton) {

        AWSHandler.sharedInstance.confirmSignUpViaConfirmationCode(email: emailID, code: resetCodeTextField.text!) { (isConfirmed) in

            if isConfirmed {
                UIViewController.displaySpinner()
                let authDetails = AWSCognitoIdentityPasswordAuthenticationDetails(username: (self.emailID.trimmingTrailingSpaces.lowercased()), password: passwordLocalSignup )
                self.passwordAuthenticationCompletion?.set(result: authDetails)

            } else {

                self.validationView.layer.borderColor = UIColor.red.cgColor
                self.validationView.layer.borderWidth = 1.0
            }
        }
    }
}
// MARK: - Extension

extension JCConfirmEmailController: AWSCognitoIdentityPasswordAuthentication {

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

                } else {

                    self.popupAlert(title: "", message: error.userInfo["message"] as? String, actionTitles: ["Retry"], actions: [ {action1 in
                        AWSHandler.sharedInstance.logOut()
                        UIViewController.removeSpinner()
                        }, nil])
                }

            } else {

                do {
//                    AuthController.setUsername(username: self.emailID.trimmingTrailingSpaces.lowercased())
//                    try AuthController.setPassword(username: self.emailID.trimmingTrailingSpaces.lowercased(), password: passwordLocalSignup)
                } catch {
                    jcPrint("Error signing in: \(error.localizedDescription)")
                }

                countHomeScreenDisplayed = 0
                jcPrint(Settings.currentUser?.accessToken ?? "token")
             //   JCAnalyticsManager.shared.logEvent(eventName: "login")

                AWSHandler.sharedInstance.userDetailsCompletionBlock = { (error) -> Void in

                    if (error != nil) {

                        self.popupAlert(title: "", message: error?.userInfo["message"] as? String, actionTitles: ["Ok"], actions: [ {action1 in
                            AWSHandler.sharedInstance.logOut()
                            }, nil])
                    } else {
                        let previousController = self.navigationController?.viewControllers[(self.navigationController?.viewControllers.count)! - 2]

                        if previousController is JCSignInViewController {
                            iswebUser = true
                         //   idForWebUser = AuthController.getUserName()!
                            let createProfileVC = UIStoryboard.profileCreator()
                            self.navigationController?.pushViewController(createProfileVC!, animated: true)

                        } else if previousController is JCCreateProfileController {

                            self.callUserSignIn()
                        }
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

extension JCConfirmEmailController {

    func callUserSignIn() {
        signInViewModel.userSignIn(firstName: (self.viewModel?.userInfo.firstName)!, lastName: (self.viewModel?.userInfo.lastName)!, timeStamp: Date().stringFromDate(with: Identifiers.yyyyMMddFormatter))
        //sonicAPICalled = true
    }

    private func setUpUserSigninHandler() {
        // MARK: Login to send access token to server
        signInViewModel.successViewClosure = { [weak self] () in
            DispatchQueue.main.async {

                let accountInfoController =  UIStoryboard.accountInfoController()
                accountInfoController?.signInModel = self?.signInViewModel.model
                UIViewController.removeSpinner()
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
// MARK: - Extension UITextFieldDelegate
extension JCConfirmEmailController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {

        textField.resignFirstResponder()
        return true
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        self.validationView.layer.borderColor = UIColor.white.cgColor
        self.validationView.layer.borderWidth = 1.0
        var result = true
        let prospectiveText = (textField.text! as NSString).replacingCharacters(in: range, with: string)

        if textField == resetCodeTextField {
            if prospectiveText.count > 0 {
                self.confirmButton.isEnabled = true
                self.confirmButton.backgroundColor = confirmButton.isEnabled ? .slateBlue : UIColor(red: 152/255, green: 164/255, blue: 174/255, alpha: 1.0)
            } else {
                self.confirmButton.isEnabled = false
                               self.confirmButton.backgroundColor = confirmButton.isEnabled ? .slateBlue : UIColor(red: 152/255, green: 164/255, blue: 174/255, alpha: 1.0)
            }
            let disallowedCharacterSet = NSCharacterSet(charactersIn: "0123456789").inverted
            let replacementStringIsLegal = string.rangeOfCharacter(from: disallowedCharacterSet) == nil
            let resultingStringLengthIsLegal = prospectiveText.count <= 6
            result = replacementStringIsLegal && resultingStringLengthIsLegal
        }
        return result
    }
}
