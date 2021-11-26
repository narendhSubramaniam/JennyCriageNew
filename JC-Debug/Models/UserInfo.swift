//  UserInfo.swift
//  JennyCraig
//  Created by Mobileprogrammingllc on 6/21/18.
//  Copyright © 2018 JennyCraig. All rights reserved.

import Foundation

struct UserInfo: Codable, ResponseData {

    var userId: Int?
    var firstName: String?
    var lastName: String?
    var username: String?
    var phone: String?
    var jennyid: String?
    var startingWeight: Int?
    var currentWeight: Int?
    var goalWeight: Int?
    var deviceType: String?
    var deviceToken: String?
    var accessToken: String?
    var error: Int?
    var successful: Int?
    var message: String?
    var country: String?
    var messageType: String?
}

struct GenericResponse: Codable, ResponseData {

    var error: Int?
    var message: String?
    var successful: Int?
    var messageType: String?
}

struct UserRegistered: Codable, ResponseData {

    var error: Int?
    var message: String?
    var successful: Int?
    var checkRegister: CheckRegister?
    var messageType: String?
}

struct CheckRegister: Codable {

    var isRegister: Int?
    var userType: String?
}
