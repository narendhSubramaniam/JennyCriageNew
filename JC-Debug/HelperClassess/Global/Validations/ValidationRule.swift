//
// ValidationRule.swift
//  JennyCraig
//
//  Created by Mobileprogrammingllc on 6/23/18.
//  Copyright © 2018 JennyCraig. All rights reserved.
//

import Foundation
import UIKit

/**
 The `Rule` protocol declares the required methods for all objects that subscribe to it.
 */
public protocol Rule {
    /**
     Validates text of a field.
     
     - parameter value: String of text to be validated.
     - returns: Boolean value. True if validation is successful; False if validation fails.
     */
    func validate(_ value: String) -> Bool
    /**
     Displays error message of a field that has failed validation.
     
     - returns: String of error message.
     */
    func errorMessage() -> String
}

/**
 `ValidationRule` is a class that creates an object which holds validation info of a field.
 */
public class ValidationRule {
    /// the field of the field
    public var field: ValidatableField
    /// the errorLabel of the field
    public var errorLabel: UILabel?
    /// the rules of the field
    public var rules: [Rule] = []

    /**
     Initializes `ValidationRule` instance with field, rules, and errorLabel.
     
     - parameter field: field that holds actual text in field.
     - parameter errorLabel: label that holds error label of field.
     - parameter rules: array of Rule objects, which field will be validated against.
     - returns: An initialized `ValidationRule` object, or nil if an object could not be created for some reason that would not result in an exception.
     */
    public init(field: ValidatableField, rules: [Rule], errorLabel: UILabel?) {
        self.field = field
        self.errorLabel = errorLabel
        self.rules = rules
    }

    /**
     Used to validate field against its validation rules.
     - returns: `ValidationError` object if at least one error is found. Nil is returned if there are no validation errors.
     */
    public func validateField() -> ValidationError? {

        if let textField = field as? CustomTextField {

            if textField.tag == 100 || textField.tag == 9 || textField.tag == 10 {
                return rules.filter {
                    return !$0.validate(field.validationText.trimmingTrailingSpaces)
                    }.map { rule -> ValidationError in return ValidationError(field: self.field, errorLabel: self.errorLabel, error: rule.errorMessage()) }.first
            } else {
                return rules.filter {
                    return !$0.validate(field.validationText)
                    }.map { rule -> ValidationError in return ValidationError(field: self.field, errorLabel: self.errorLabel, error: rule.errorMessage()) }.first

            }
        }
        return rules.filter {
            return !$0.validate(field.validationText)
            }.map { rule -> ValidationError in return ValidationError(field: self.field, errorLabel: self.errorLabel, error: rule.errorMessage()) }.first
    }
}
