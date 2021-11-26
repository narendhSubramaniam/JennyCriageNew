//
//  SignInViewModel.swift
//  JennyCraig
//
//  Created by Mobileprogrammingllc on 9/15/18.
//  Copyright © 2018 JennyCraig. All rights reserved.
//

import UIKit

class SignInViewModel: NSObject {

    private let client = SignInClient()

    internal var alertMessage: String = "Error" {
        didSet {
            if  alertMessage.caseInsensitiveCompare(Identifiers.Message.IncorrectEmailOrPassword) == .orderedSame {
                AWSHandler.sharedInstance.logOut()
            } else {
                self.showAlertClosure?(alertMessage)
            }
        }
    }
    var succusfullMessage: Int = 0
    var successViewClosure: (() -> Void)?
    var showAlertClosure: ((String) -> Void)?

    // MARK: - Computed Properties
    internal var model: SignInModel?

    func userSignIn(firstName: String, lastName: String, timeStamp: String) {
        let path = JCPostServicePath.userSignin(firstName: firstName, lastName: lastName, timeStamp: timeStamp)
        self.callUserSignIn(servicePath: path)
    }

    func registerUserInSonic(firstName: String, lastName: String, timeStamp: String) {
           let path = JCPostServicePath.sonicRegistration(firstName: firstName, lastName: lastName, timeStamp: timeStamp)
           self.callUserSignIn(servicePath: path)
       }

    private func callUserSignIn(servicePath: JCPostServicePath) {

        let resource = GenericResource(path: servicePath.path.rawValue, parameters: servicePath.parameters)

        client.callUserSignIn(resource: resource) { (result) in
            if result.isSuccess {
                //get the parse data from result
                self.model = result.value
                self.succusfullMessage = self.model?.successful! as! Int
                self.successViewClosure?()
            } else {
                //if response did not come from services then show alert message
                if let error = result.error {
                    self.alertMessage = error.debugDescription
                }
            }
        }
    }
}
