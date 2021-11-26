//
//  AuthController.swift
//  JennyCraig
//
//  Created by Mobileprogrammingllc on 7/8/18.
//  Copyright © 2018 JennyCraig. All rights reserved.
//

import Foundation
//import SwiftKeychainWrapper

final class AuthController {

    // MARK: - Variables
    static var isSignedIn: Bool {

        do {
            if let username = self.getUserName(), username.count > 0 {
                if let password = UserDefaults.standard.string(forKey: "kpassword") {
                    //let password = try KeychainPasswordItem(service: keychainService, account: username).readPassword()
                    return password.count > 0
                } else {
                    return false
                }

            } else {
                return false
            }
        } catch {
            return false
        }
    }

    // MARK: Functions
    class func signOut() throws {
        guard let currentUser = Settings.currentUser else {
            return
        }

        try KeychainPasswordItem(service: keychainService, account: currentUser.username!).deleteItem()

        Settings.currentUser = nil
    }

    class func resetToken() {

        if isChecked {
            //KeychainWrapper.standard.removeObject(forKey: "kaccessToken")
            UserDefaults.standard.removeObject(forKey: "kaccessToken")
        } else {
            JCManager.shared.token = ""
        }
    }

}

// MARK: - Extensions
extension AuthController {

    class func getPassword(username: String) -> String {

        if isChecked {

            if let password = UserDefaults.standard.string(forKey: "kpassword") {
                return password
            } else {
                return ""
            }

            /* do {
             let password = try KeychainPasswordItem(service: keychainService, account: username).readPassword()
             return password
             } catch {
             return ""
             } */
        } else {
            return JCManager.shared.password
        }

    }

    class func getUserName() -> String? {

        if isChecked {
            if let firstName = UserDefaults.standard.string(forKey: "kusername") {
                // if let firstName = KeychainWrapper.standard.string(forKey: "kusername") {
                return firstName
            } else {
                return ""
            }
        } else {
            return JCManager.shared.userName
        }
    }

    class func getToken() -> String {

        if isChecked {

            if let token = UserDefaults.standard.string(forKey: "kaccessToken") {
                //if let token = KeychainWrapper.standard.string(forKey: "kaccessToken") {
                return token
            } else {
                return  ""
            }
        } else {
            return JCManager.shared.token
        }

    }

    class func getTokenExpirationTime() -> Date {

        if isChecked {

            if let tokenExpirationTime = UserDefaults.standard.object(forKey: "ktokenExpirationTime") {
                return tokenExpirationTime as? Date ?? Date().subtract(days: 1)
            } else {
                return  Date().subtract(days: 1)
            }
        } else {
            return JCManager.shared.tokenExpirationTime
        }

    }

    class func getFirstname() -> String {

        if isChecked {

            if let firstName = UserDefaults.standard.string(forKey: "kfirstname") {
                //if let firstName = KeychainWrapper.standard.string(forKey: "kfirstname") {
                return firstName
            } else {
                return ""
            }
        } else {
            return JCManager.shared.firstName
        }

    }

    class func getLastname() -> String {

        if isChecked {
            if let lastName = UserDefaults.standard.string(forKey: "klastname") {

                //if let lastName = KeychainWrapper.standard.string(forKey: "klastname") {
                return lastName
            } else {
                return ""
            }
        } else {
            return JCManager.shared.lastName
        }

    }

    class func getFitbitAccessToken() -> String? {

        if let fitbitAccessToken = UserDefaults.standard.string(forKey: "kfitbitaccessToken") {

            //if let lastName = KeychainWrapper.standard.string(forKey: "klastname") {
            return fitbitAccessToken
        } else {
            return ""
        }

    }

    class func getFitbitRefreshToken() -> String? {

        if let fitbitRefreshToken = UserDefaults.standard.string(forKey: "kfitbitrefreshToken") {

            //if let lastName = KeychainWrapper.standard.string(forKey: "klastname") {
            return fitbitRefreshToken
        } else {
            return ""
        }
    }

    class func getFitbitAccessTokenExpirationTime() -> Date? {

        if let fitbitRefreshToken = UserDefaults.standard.object(forKey: "kfitbitaccessTokenExpirationTime") {

            //if let lastName = KeychainWrapper.standard.string(forKey: "klastname") {
            return fitbitRefreshToken as? Date
        } else {
            return Date()
        }

    }

}

extension AuthController {

    class func passwordHash(from email: String, password: String) -> String {

        return "\(password)"
    }

    class func setPassword(username: String, password: String) throws {

        if isChecked {
            UserDefaults.standard.set(password, forKey: "kpassword")
            // let finalHash = passwordHash(from: username, password: password)
            // try KeychainPasswordItem(service: keychainService, account: username).savePassword(finalHash)
        } else {
            JCManager.shared.password = password
        }
    }

    class func setUsername(username: String) {

        if isChecked {
            UserDefaults.standard.set(username, forKey: "kusername")
            //KeychainWrapper.standard.set(username, forKey: "kusername")
        } else {
            JCManager.shared.userName = username
        }

    }

    class func setToken(token: String) {

        if isChecked {
            UserDefaults.standard.set(token, forKey: "kaccessToken")
            //KeychainWrapper.standard.set(token, forKey: "kaccessToken")
        } else {
            JCManager.shared.token = token
        }

    }

    class func setTokenExpirationTime(time: Date) {

        if isChecked {
            UserDefaults.standard.set(time, forKey: "ktokenExpirationTime")
        } else {
            JCManager.shared.tokenExpirationTime = time
        }

    }

    class func setFirstname(strFirstName: String) {

        if isChecked {
            UserDefaults.standard.set(strFirstName, forKey: "kfirstname")
            //KeychainWrapper.standard.set(strFirstName, forKey: "kfirstname")
        } else {
            JCManager.shared.firstName = strFirstName
        }

    }

    class func setLastname(strLastName: String) {

        if isChecked {
            UserDefaults.standard.set(strLastName, forKey: "klastname")
            //KeychainWrapper.standard.set(strLastName, forKey: "klastname")
        } else {
            JCManager.shared.lastName = strLastName
        }
    }

    class func setFitbitAccessToken(token: String) {

        UserDefaults.standard.set(token, forKey: "kfitbitaccessToken")

    }

    class func setFitbitRefreshToken(token: String) {

        UserDefaults.standard.set(token, forKey: "kfitbitrefreshToken")

    }

    class func setFitbitAccessTokenExpirationTime(expiresIn: Date) {

        UserDefaults.standard.set(expiresIn, forKey: "kfitbitaccessTokenExpirationTime")

    }
}

extension AuthController {

   class func cleanUpStoredInfo() {

        if isChecked {
            //KeychainWrapper.standard.removeObject(forKey: "kaccessToken")
            //KeychainWrapper.standard.removeObject(forKey: "kusername")
            //KeychainWrapper.standard.removeObject(forKey: "kfirstname")
            //KeychainWrapper.standard.removeObject(forKey: "klastname")

            UserDefaults.standard.removeObject(forKey: "kaccessToken")
            UserDefaults.standard.removeObject(forKey: "ktokenExpirationTime")
            UserDefaults.standard.removeObject(forKey: "kusername")
            UserDefaults.standard.removeObject(forKey: "kfirstname")
            UserDefaults.standard.removeObject(forKey: "klastname")
            UserDefaults.standard.removeObject(forKey: "kpassword")

           /*  do {
                try KeychainPasswordItem(service: keychainService, account: AuthController.getUserName()!).deleteItem()
                
            } catch {
            } */

        } else {
            JCManager.shared.userName = ""
            JCManager.shared.password = ""
            JCManager.shared.firstName = ""
            JCManager.shared.lastName = ""
            JCManager.shared.token = ""
            JCManager.shared.tokenExpirationTime = Date().subtract(days: 1)

        }
    }
}
