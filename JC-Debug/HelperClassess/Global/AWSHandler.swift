//  AWSHandler.swift
//  JennyCraig
//  Created by Mobileprogrammingllc on 8/29/18.
//  Copyright © 2018 JennyCraig. All rights reserved.

import UIKit
import AWSCognitoIdentityProvider

enum TokenStatus {
    case tokenRefreshed
    case tokenAlreadyValid
}

class AWSHandler: NSObject {

    var completionBlock: ((TokenStatus) -> Void)?
    var userDetailsCompletionBlock: ((_ error: NSError? ) -> Void)?
    var user: AWSCognitoIdentityUser?
    var pool: AWSCognitoIdentityUserPool?
    var userDetails: AWSCognitoIdentityUserGetDetailsResponse?

    class var sharedInstance: AWSHandler {
        struct Singleton {
            static let instance = AWSHandler()
        }

        return Singleton.instance
    }

    func checkIfTokenExpired() {

        if Date().isGreaterThan(date2: AuthController.getTokenExpirationTime(), granularity: .second) || isSessionLoggedOut == true {

            if let userName = AuthController.getUserName(), userName.count > 0 {
                getNewToken(username: userName)
            } else {
                DispatchQueue.main.async {

                    AWSHandler.sharedInstance.logOut()
                }
            }
        } else {
            if let completionBlock = self.completionBlock {
                completionBlock(.tokenAlreadyValid)
            }
        }
    }

    func logOut() {

        jcPrint("awsHandler logoutCalled")

        self.pool = AWSCognitoIdentityUserPool(forKey: Identifiers.AWSCognitoUserPoolsSignInProviderKey)
        self.user = self.pool?.currentUser()
        self.user?.signOut()
        AuthController.cleanUpStoredInfo()
        self.pool?.clearAll()
        self.userDetails = nil
        JCManager.shared.cleanUp()
        boolLogout = true
        UserDefaults.standard.set(true, forKey: "logOut")
        UserDefaults.standard.removeObject(forKey: "yAxis")
        JCManager.shared.state = .collapsed
        self.user?.getDetails()

    }

    func getNewToken(username: String) {
        self.pool = AWSCognitoIdentityUserPool(forKey: Identifiers.AWSCognitoUserPoolsSignInProviderKey)

        if (self.user == nil) {
            self.user = self.pool?.currentUser()
        }
        let password = AuthController.getPassword(username: username)
        self.user?.getSession(username, password: password, validationData: nil).continueWith(block: {[weak self] (task) -> Any? in

            DispatchQueue.main.async {
                if let error = task.error as NSError? {

                    UIViewController.showAlert(title: "", message: error.userInfo["message"] as? String, actionTitles: ["OK"], actions: [ {action1 in
                        AWSHandler.sharedInstance.logOut()
                        }, nil])

                } else if let session = task.result {
                    if let tokenReceived = session.idToken?.tokenString {
                        AuthController.setToken(token: tokenReceived)
                        AuthController.setTokenExpirationTime(time: session.expirationTime!)
                        isSessionLoggedOut = false
                        sonicAPICalled = false
                        jcPrint("token refreshed")
                        jcPrint("HandlerToken :: \(tokenReceived)")
                        //sonicAPICalled == false ? callUserSigninAPI() : ()
                        if let completionBlock = self?.completionBlock {
                            completionBlock(.tokenRefreshed)
                        }
                    } else {
                        DispatchQueue.main.async {

                            AWSHandler.sharedInstance.logOut()
                        }
                    }
                } else {
                    UIViewController.showAlert(title: "", message: Identifiers.Message.userNamePasswordNotCorrectMessage, actionTitles: ["OK"], actions: [ {action1 in
                        AWSHandler.sharedInstance.logOut()
                        }, nil])
                }
            }

            return nil
        })
    }

    // MARK: - SetUp AWS
    func setUpAWS() {

        self.pool = AWSCognitoIdentityUserPool(forKey: Identifiers.AWSCognitoUserPoolsSignInProviderKey)
        self.user = self.pool?.currentUser()
        self.getUserDetails()
    }

    @objc func getUserDetails() {

        self.user?.getDetails().continueOnSuccessWith { (task) -> AnyObject? in
            DispatchQueue.main.async(execute: {
                self.userDetails = task.result

                // Fetch out token from session and send to API headers
                if let userName = AuthController.getUserName(), userName.count > 0 {
                    let password = AuthController.getPassword(username: userName)
                    self.user?.getSession(userName, password: password, validationData: nil).continueWith(block: {[weak self] (task) -> Any? in

                        DispatchQueue.main.async {
                            if let error = task.error as NSError? {

                                self?.userDetailsCompletionBlock!(error)
                            } else if let session = task.result {

                                if let tokenReceived = session.idToken?.tokenString {
                                    AuthController.setToken(token: tokenReceived)
                                    AuthController.setTokenExpirationTime(time: session.expirationTime!)
                                    jcPrint("HandlerToken :: \(tokenReceived)")
                                   // sonicAPICalled == false ? callUserSigninAPI() : ()
                                    UserDefaults.standard.set(false, forKey: "logOut")
                                    var userName = ""
                                    var firstName = ""
                                    if let attributes = self?.userDetails?.userAttributes {

                                        for item in attributes {
                                            if let nameKey = item.name, nameKey == "email", let username = item.value {
                                                userName = username
                                                JCAnalyticsManager.shared.logUserID(userID: username)
                                                JCAnalyticsManager.shared.logEvent(eventName: "user_id", parameters: ["id": userName])
                                            }

                                            if let nameKey = item.name, nameKey == "given_name", let firstname = item.value {
                                                firstName = firstname
                                                firstNameWebUser = firstname
                                            }

                                            if let nameKey = item.name, nameKey == "family_name", let lastname = item.value {
                                                lastNameWebUser = lastname
                                            }
                                        }

                                        if firstName.count > 0 && userName.count > 0 {
                                            jcPrint("userDetailsCompletionBlock")
                                            self?.userDetailsCompletionBlock!(nil)
                                        } else {
                                            jcPrint("emainID not received")
                                        }
                                    }

                                } else {
                                    DispatchQueue.main.async {
                                        jcPrint("continueOnSuccessResultElseBlock")
                                        AWSHandler.sharedInstance.logOut()
                                    }
                                }
                            }
                        }
                        return nil
                    })
                } else {
                    jcPrint("continueOnSuccessResultElseBlock")
                    DispatchQueue.main.async {
                        AWSHandler.sharedInstance.logOut()
                    }
                }
            })
            return nil
        }
    }

    func registerUserInCognito(userInfo: UserInfo, completion: @escaping (Bool, NSError?) -> Void) {

        self.pool = AWSCognitoIdentityUserPool(forKey: Identifiers.AWSCognitoUserPoolsSignInProviderKey)
        var attributes = [AWSCognitoIdentityUserAttributeType]()

        let email = AWSCognitoIdentityUserAttributeType(name: "email", value: userInfo.username!.lowercased())
        attributes.append(email)

        let name = AWSCognitoIdentityUserAttributeType(name: "given_name", value: userInfo.firstName!)
        attributes.append(name)

        let familyName = AWSCognitoIdentityUserAttributeType(name: "family_name", value: userInfo.lastName!)
        attributes.append(familyName)

        self.pool?.signUp(userInfo.username!.lowercased(), password: passwordLocalSignup, userAttributes: attributes, validationData: nil).continueWith {[weak self] (task) -> Any? in
            guard self != nil else { return nil }
            DispatchQueue.main.async(execute: {
                if let error = task.error as NSError? {

                    completion(false, error)

                } else if let result = task.result {
                    // handle the case where user has to confirm his identity via email / SMS
                    if (result.user.confirmedStatus != AWSCognitoIdentityUserStatus.confirmed) {

                        completion(true, nil)

                    } else {
                        completion(false, nil)
                    }
                }
            })
            return nil
        }
    }

    func checkIfEmailExistInCognito(email: String, completion: @escaping (Bool, ExceptionString?) -> Void ) {

        self.pool = AWSCognitoIdentityUserPool(forKey: Identifiers.AWSCognitoUserPoolsSignInProviderKey)
        let proposedUser = pool?.getUser(email.lowercased())
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        proposedUser?.getSession(email, password: "deadbeef", validationData: nil).continueWith(executor: AWSExecutor.mainThread(), block: { (awsTask) in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            if let error = awsTask.error as NSError? {
                // Error implies login failed. Check reason for failure
                if let exceptionString = error.userInfo["__type"] as? String {
                    if let exception = ExceptionString(rawValue: exceptionString) {
                        completion(false, exception)
                    } else {
                        // Some error we did not recognize. Optimistically allow user to proceed.
                        completion(false, nil)
                    }
                }

            } else {
                // No error implies login worked (edge case where proposed email
                // is linked with an account which has password 'deadbeef').
                completion(true, nil)
            }
            return nil
        })
    }

    func resendConfirmationCode(email: String, status: Int) {

        self.pool = AWSCognitoIdentityUserPool(forKey: Identifiers.AWSCognitoUserPoolsSignInProviderKey)
        let proposedUser = pool?.getUser(email.lowercased())
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        proposedUser?.resendConfirmationCode().continueWith(block: { (response) -> Any? in

            DispatchQueue.main.async {
                if let error = response.error as NSError? {

                    UIViewController.showAlert(title: "", message: error.userInfo["message"] as? String, actionTitles: ["OK"], actions: [ {action1 in

                        }, nil])
                } else {
                    if status==1 {
                        let message = "Your verification code has been emailed to " + email
                        UIViewController.showAlert(title: "", message: message as? String, actionTitles: ["OK"], actions: [ {action1 in

                                                                  }, nil])
                    }

                }
            }
            return nil
        })
    }

    func confirmSignUpViaConfirmationCode(email: String, code: String, completion: @escaping (Bool) -> Void ) {

           self.pool = AWSCognitoIdentityUserPool(forKey: Identifiers.AWSCognitoUserPoolsSignInProviderKey)
           let proposedUser = pool?.getUser(email.lowercased())
           UIApplication.shared.isNetworkActivityIndicatorVisible = true
        proposedUser?.confirmSignUp(code).continueWith(block: { (response) -> Any? in

            DispatchQueue.main.async {
                if let error = response.error as NSError? {
                    if error.code == 3 {

                        UIViewController.showCustomAlert(title: Identifiers.Message.verificationNotMatchedMessage, message: Identifiers.Message.doubleCheckMessage as? String, actionTitles: ["OK"], actions: [ {action1 in
                        completion(false)
                        }, nil])
                    } else {
                    UIViewController.showAlert(title: "", message: error.userInfo["message"] as? String, actionTitles: ["OK"], actions: [ {action1 in
                        completion(false)
                        }, nil])
                    }

                } else {
                    completion(true)
                }
            }
            return nil
        })

       }

    func callResetPopUpFlag() {
//        let resetPopUpViewModel = ResetPopUpViewModel()
//        resetPopUpViewModel.resetPopUpFlag()
    }
}

func callUserSigninAPI() {
    /*let signInViewModel = SignInViewModel()
    signInViewModel.userSignIn(timeStamp: Date().stringFromDate(with: Identifiers.yyyyMMddFormatter))
    sonicAPICalled = true */
}
