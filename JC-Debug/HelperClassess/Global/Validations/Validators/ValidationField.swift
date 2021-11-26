//
//  ValidationField.swift
//  JennyCraig
//
//  Created by Mobileprogrammingllc on 6/23/18.
//  Copyright © 2018 JennyCraig. All rights reserved.
//

import Foundation
import UIKit

public typealias ValidatableField = AnyObject & Validatable

public protocol Validatable {

    var validationText: String {
        get
    }
}

extension UITextField: Validatable {

    public var validationText: String {
        return self.text ?? ""
    }
}
