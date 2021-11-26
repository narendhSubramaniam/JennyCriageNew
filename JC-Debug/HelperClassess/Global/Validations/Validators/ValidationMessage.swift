//
//  ValidationMessage.swift
//  JennyCraig
//
//  Created by Mobileprogrammingllc on 6/23/18.
//  Copyright © 2018 JennyCraig. All rights reserved.
//

import Foundation

enum RegEx: String {
    case email = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,13}" // Email
    case password = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{6,}$"
    case alphabeticStringWithSpace = "^[a-zA-Z ]*$" // e.g. hello gourav
    case alphabeticStringFirstLetterCaps = "^[A-Z]+[a-zA-Z]*$" // Mobileprogrammingllc
    case phoneNo = "^\\d{10}$" // PhoneNo 10-14 Digits
}

enum AlertMessages: String {

    //case inValidEmail = "Must be a valid email address"
    case inValidEmail = "Invalid email address"
    case invalidFirstLetterCaps = "First Letter should be capital"
    case inValidPhone = "Enter a valid 10 digit phone numbere"
    case inValidMaxLength = "Must be at most 16 characters long"
    case inValidMinLength = "Must be at least 3 characters long"
    case inValidPassword = "Min 6 characters with 1 number"

    func localized() -> String {
        return NSLocalizedString(self.rawValue, comment: "")
    }
}
