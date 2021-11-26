//
//  User.swift
//  JC-Debug
//
//  Created by Narendh Subramanian on 10/12/21.
//

import Foundation
import Amplify


struct User {
    let id: String
    let username: String
    let sub: String
    let postcode: String?
    let createdAt: Temporal.DateTime?
}
