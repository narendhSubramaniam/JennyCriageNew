//
//  EmailRule.swift
//  JennyCraig
//
//  Created by Mobileprogrammingllc on 6/23/18.
//  Copyright © 2018 JennyCraig. All rights reserved.
//

import Foundation

protocol RegexValidationRule {

    var REGEX: String {get set}
    var message: String {get set}
    func validate(_ value: String) -> Bool
    func errorMessage() -> String
}

extension RegexValidationRule {

    var REGEX: String {
        /// Regular express string to be used in validation.
        return RegEx.email.rawValue
    }

    /**
     Method used to validate field.
     
     - parameter value: String to checked for validation.
     - returns: Boolean value. True if validation is successful; False if validation fails.
     */
    public func validate(_ value: String) -> Bool {
        let test = NSPredicate(format: "SELF MATCHES %@", self.REGEX)
        return test.evaluate(with: value)
    }

    /**
     Method used to dispaly error message when field fails validation.
     
     - returns: String of error message.
     */
    public func errorMessage() -> String {
        return message
    }
}

public class EmailValidationRule: RegexValidationRule, Rule {

    var REGEX: String = RegEx.email.rawValue
    var message: String = AlertMessages.inValidEmail.rawValue
}

public class PasswordValidationRule: RegexValidationRule, Rule {

    var REGEX: String = RegEx.password.rawValue
    var message: String = AlertMessages.inValidPassword.rawValue
}

public class PhoneNumberValidationRule: RegexValidationRule, Rule {

    var REGEX: String = RegEx.phoneNo.rawValue
    var message: String = AlertMessages.inValidPhone.rawValue
}
