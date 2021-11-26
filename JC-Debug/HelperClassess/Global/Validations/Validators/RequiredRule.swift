//
//  RequireRule.swift
//  JennyCraig
//
//  Created by Mobileprogrammingllc on 6/23/18.
//  Copyright © 2018 JennyCraig. All rights reserved.
//

import Foundation

/**
 `RequiredRule` is a subclass of Rule that defines how a required field is validated.
 */
public class RequiredRule: Rule {
    /// String that holds error message.
    private var message: String

    /**
     Initializes `RequiredRule` object with error message. Used to validate a field that requires text.
     
     - parameter message: String of error message.
     - returns: An initialized `RequiredRule` object, or nil if an object could not be created for some reason that would not result in an exception.
     */
    public init(message: String = "Please complete the required fields.") {
        self.message = message
    }

    /**
     Validates a field.
     
     - parameter value: String to checked for validation.
     - returns: Boolean value. True if validation is successful; False if validation fails.
     */
    public func validate(_ value: String) -> Bool {
        return !value.isEmpty
    }

    /**
     Used to display error message when validation fails.
     
     - returns: String of error message.
     */
    public func errorMessage() -> String {
        return message
    }
}
