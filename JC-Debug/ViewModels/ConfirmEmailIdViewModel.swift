//
//  confirmEmailIdViewModel.swift
//  JennyCraig
//
//  Created by Mobileprogrammingllc on 18/12/19.
//  Copyright © 2019 JennyCraig. All rights reserved.
//

import UIKit

class ConfirmEmailIdViewModel: NSObject {

    private let client = ConfirmEmailClient()

    internal var alertMessage: String = "Error" {
        didSet {
            if  alertMessage.caseInsensitiveCompare(Identifiers.Message.IncorrectEmailOrPassword) == .orderedSame {
                AWSHandler.sharedInstance.logOut()
            } else {
                self.showAlertClosure?(alertMessage)

            }
        }
    }
     //Handlerre
    var successViewClosure: ((GenericResponse) -> Void)?
    var showAlertClosure: ((String) -> Void)?

    internal var response: GenericResponse? {
           didSet { self.successViewClosure?(response!) }
       }

    // MARK: - Computed Properties
    internal var model: GenericResponse?

    func confirmEmailId(withUserName: String) {
        let path = JCPostServicePath.confirmEmailId
        self.callconfirmEmailId(servicePath: path, userName: withUserName)
    }

    private func callconfirmEmailId(servicePath: JCPostServicePath, userName: String) {

        var resource = GenericResource(path: servicePath.path.rawValue, parameters: servicePath.parameters)
        resource.usernameForSignUp = userName

        client.callConfirmEmailId(resource: resource) { (result) in
            if result.isSuccess {
                //get the parse data from result
                self.model = result.value
                self.successViewClosure?(self.response!)
            } else {
                //if response did not come from services then show alert message
                if let error = result.error {
                    self.alertMessage = error.debugDescription

                }
            }
        }
    }
}
