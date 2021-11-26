//  JCAnalyticsManager.swift
//  JennyCraig
//  Created by mobileprogrammingllc on 2/26/19.
//  Copyright © 2019 JennyCraig. All rights reserved.

import UIKit
//import Flurry_iOS_SDK
//import FirebaseAnalytics

struct JCAnalyticsManager {

    static var shared = JCAnalyticsManager()

    func logEvent(eventName: String, parameters: [String: String]? = nil) {
        //Flurry.logEvent(eventName)
//        Flurry.logEvent(eventName, withParameters: parameters)
//        Analytics.logEvent(eventName, parameters: parameters)
    }

    func logUserID(userID: String) {
//        Flurry.setUserID(userID)
//        Analytics.setUserID(userID)
    }
}
