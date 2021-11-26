//
//  MinLengthRule.swift
//  JennyCraig
//
//  Created by Mobileprogrammingllc on 6/23/18.
//  Copyright © 2018 JennyCraig. All rights reserved.
//

import Foundation

/**
 `MinLengthRule` is a subclass of Rule that defines how minimum character length is validated.
 */
public class MinLengthRule: Rule {
    /// Default minimum character length.
    private var defaultLength: Int = 3
    /// Default error message to be displayed if validation fails.
    private var message: String = AlertMessages.inValidMinLength.rawValue

    /// - returns: An initialized `MinLengthRule` object, or nil if an object could not be created for some reason that would not result in an exception.
    public init() {}

    /**
     Initializes a `MinLengthRule` object that is to validate the length of the text of a field.
     
     - parameter length: Minimum character length.
     - parameter message: String of error message.
     - returns: An initialized `MinLengthRule` object, or nil if an object could not be created for some reason that would not result in an exception.
     */
    public init(length: Int, message: String = "Must be at least %ld characters long") {
        self.defaultLength = length
        self.message = String(format: message, self.defaultLength)
    }

    /**
     Validates a field.
     - parameter value: String to checked for validation.
     - returns: A boolean value. True if validation is successful; False if validation fails.
     */
    public func validate(_ value: String) -> Bool {
        return value.count >= defaultLength
    }

    /**
     Displays error message when field has failed validation.
     
     - returns: String of error message.
     */
    public func errorMessage() -> String {
        return message
    }
}
