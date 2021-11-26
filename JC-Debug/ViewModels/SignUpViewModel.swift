//
//  SignUpViewModel.swift
//  JennyCraig
//
//  Created by Mobileprogrammingllc on 6/20/18.
//  Copyright © 2018 JennyCraig. All rights reserved.
//

import Foundation

class SignUpViewModel {

    private let client = RegistrationClient()
    var userInfo = UserInfo()

    //Handler
    var successViewClosure: ((GenericResponse) -> Void)?
    var showAlertClosure: ((String) -> Void)?

    internal var response: GenericResponse? {
        didSet { self.successViewClosure?(response!) }
    }

    //Private
     var alertMessage: String = "Error" {
        didSet {
            if  alertMessage.caseInsensitiveCompare(Identifiers.Message.IncorrectEmailOrPassword) == .orderedSame {
                AWSHandler.sharedInstance.logOut()
            }
            /*
            else if alertMessage.caseInsensitiveCompare("Could not connect to server") == .orderedSame
            {
                NotificationCenter.default.post(name: Notification.Name.refreshToken, object: nil, userInfo: nil)
            }
                */
            else {
                self.showAlertClosure?(alertMessage)
            }
        }
    }

    func callForgotPasswordWebServices(servicePath: JCPostServicePath) {

        self.callWebService(servicePath: servicePath)
    }

    func callResetPasswordWebServices(servicePath: JCPostServicePath) {

        self.callWebService(servicePath: servicePath)
    }

    func callRegisterUserWebServices(servicePath: JCPostServicePath, withUserName: String) {

        self.callWebServiceConfirmSignup(servicePath: servicePath, userName: withUserName)
    }

    func checkUserExistAlready(servicePath: JCPostServicePath) {

        self.callWebService(servicePath: servicePath)
    }

    private func callWebServiceConfirmSignup(servicePath: JCPostServicePath, userName: String) {

        var resource = GenericResource(path: servicePath.path.rawValue, parameters: servicePath.parameters)
        resource.usernameForSignUp = userName
        client.registerUser(resource: resource) { (result) in

            if result.isSuccess {

                if let data = result.value {

                    self.response = data
                }
            } else {
                if let error = result.error {
                    self.alertMessage = error.debugDescription
                }
            }
        }
    }

    private func callWebService(servicePath: JCPostServicePath) {

        let resource = GenericResource(path: servicePath.path.rawValue, parameters: servicePath.parameters)
        client.registerUser(resource: resource) { (result) in

            if result.isSuccess {

                if let data = result.value {

                    self.response = data
                }
            } else {
                if let error = result.error {
                    self.alertMessage = error.debugDescription
                }
            }
        }
    }
}
