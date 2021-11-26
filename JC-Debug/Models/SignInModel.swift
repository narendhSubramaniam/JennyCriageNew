//  SignInModel.swift
//  JennyCraig
//  Created by Mobileprogrammingllc on 13.12.19.
//  Copyright © 2019 JennyCraig. All rights reserved.

import Foundation

// MARK: - SignInModel
struct SignInModel: Codable, ResponseData {
    var messageType: String?
    var error, successful: Int?
    var message, sonicNot: String?
    var profileInfo: [ProfileInfo]?
}

// MARK: - ProfileInfo
struct ProfileInfo: Codable {
    var editable: Int?
    var keyName, keyValue: String?
}
