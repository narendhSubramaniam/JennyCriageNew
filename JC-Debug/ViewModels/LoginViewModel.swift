//
//  LoginViewModel.swift
//  JennyCraig
//
//  Created by Mobileprogrammingllc on 6/20/18.
//  Copyright © 2018 JennyCraig. All rights reserved.
//

import Foundation

protocol GenericViewModel {

    //Handler
    var successViewClosure: (() -> Void)? {get set}
    var showAlertClosure: ((String) -> Void)? {get set}
    var alertMessage: String {get set}
}

class LoginViewModel: GenericViewModel {

    var isRegister = -1 {
        didSet {
            self.successViewClosure?()
        }
    }

    private let client = LoginClient()
    let validator = Validator()

    //Handler
    var successViewClosure: (() -> Void)?
    var showAlertClosure: ((String) -> Void)?

    internal var userInfo: UserInfo? {
        didSet { self.successViewClosure?() }
    }

    //Private
    internal var alertMessage: String = "Error" {
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

    func checkRegisteredUserType(servicePath: JCPostServicePath) {

        self.callWebServiceToCheckUserType(servicePath: servicePath)
    }

    private func callWebServiceToCheckUserType(servicePath: JCPostServicePath) {

        let resource = GenericResource(path: servicePath.path.rawValue, parameters: servicePath.parameters)
        client.fetchCheckRegisterdUserTypeData(resource: resource) { (result) in

            if result.isSuccess {

                if let data = result.value {

                    if let type = data.checkRegister?.isRegister {
                        self.isRegister = type
                    }
                    jcPrint(data)
                }
            } else {
                if let error = result.error {
                    self.alertMessage = error.debugDescription
                }
            }
        }
    }

}
