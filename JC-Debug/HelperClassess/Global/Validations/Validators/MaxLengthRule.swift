//
//  MaxLengthRule.swift
//  JennyCraig
//
//  Created by Mobileprogrammingllc on 6/23/18.
//  Copyright © 2018 JennyCraig. All rights reserved.
//

import Foundation

/**
 `MaxLengthRule` is a subclass of `Rule` that defines how maximum character length is validated.
 */
public class MaxLengthRule: Rule {

    /// Default maximum character length.
    private var defaultLength: Int = 16
    /// Error message to be displayed if validation fails.
    private var message: String = AlertMessages.inValidMaxLength.rawValue
    /**
     Initializes a `MaxLengthRule` object that is to validate the length of the text of a field.
     - parameter length: Maximum character length.
     - parameter message: String of error message.
     - returns: An initialized object, or nil if an object could not be created for some reason that would not result in an exception.
     */
    public init(length: Int, message: String = "Must be at most %ld characters long") {
        self.defaultLength = length
        self.message = String(format: message, self.defaultLength)
    }

    /**
     Used to validate a field.
     
     - parameter value: String to checked for validation.
     - returns: A boolean value. True if validation is successful; False if validation fails.
     */
    public func validate(_ value: String) -> Bool {
        return value.count <= defaultLength
    }

    /**
     Displays an error message if a field fails validation.
     
     - returns: String of error message.
     */
    public func errorMessage() -> String {
        return message
    }
}
