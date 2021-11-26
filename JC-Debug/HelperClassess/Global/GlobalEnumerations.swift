//  GlobalEnumerations.swift
//  JennyCraig
//  Created by mobileprogrammingllc on 11/16/18.
//  Copyright © 2018 JennyCraig. All rights reserved.

import Foundation
import UIKit

enum VersionError: Error {
    case invalidResponse, invalidBundleInfo
}

public enum RapidType: String {
    case nourishment = "Nourishment"
    case rejuvenation = "Rejuvenation"
}

public enum ActivityType: String {
    case myActivity = "MyActivity"
}

public enum State: Int {
    case expanded
    case collapsed
}

public enum RejuvenationStatus: Int, Codable {
    case inProgress   //means going on
    case isCompleted  //means finished by user  eg 11:25:29
    case inComplete  //means  eg 24:00:00
    case isNone  // 00:00:00
}

public enum StartType: String {
    case selfStart = "0"
    case selfStartEdit = "1"
}

public enum NutritionStatus: Int {

    case noNutrition
    case inNourishment
    case inRejuvination
    case rejuvinationCompleted
}

public enum ActionType: Int {

    case check
    case picker
}

public enum Location: Int {
    case calendar
    case mail
    case graph
}

public enum ConnectionType: Int {
    case fitbit
    case healthApp
    case none
    
}

public enum ConnectedApp: Int {
    case fitbit
    case healthApp
    case none
    case scale
    
}
public enum WeightScaleConnected: Int {
    case scale
    case none
    
}
public enum SourceType: Int, Codable {
    case fitbit
    case healthApp
    case server
    case scale
}

public enum ScreenSourceType: Int {
    case selfMonitor
    case more
}

public enum PickerType: Int {

    case first
    case last
}
public enum SubstitureArrayShow: String {
    case substituteArray = "Substitute"
    case jennyCraigArray = "JennyCraig"
}

public enum DietMenuType: String {
    case classic = "Classic"
    case meatless = "Meatless"
    case rapidresults = "Rapid"
    case travel = "Travel"
    case maintenance = "Maintenance"
    case type2 = "Type"
    case reducedCarb = "Reduced Carb"
    case reducedFat = "Reduced Fat"
    case vegetarian = "Vegetarian"
    case noPork = "No Pork"
    case balanced = "Balanced"
    case rrMAX = "RR Max"
}
 public enum ExerciseType: String {
            case cardio = "Cardio"
            case strength = "Strength"
            case manualSteps = "Manual"
        }

public enum MenuType: String, Codable {
    case breakfast = "Breakfast"
    case recharge = "Recharge"
    case lunch = "Lunch"
    case dinner = "Dinner"
    case snacks1 = "Snack-1"
    case snacks2 = "Snack-2"
    case snacks3 = "Snack-3"
    case limitedFood = "Limited Foods"
    case activity = "Activity"
    case dailyWeight = "Daily Weight"
    case water = "Water"
    case motivation = "Motivation"
    case notes = "Daily_Notes"
}

public enum MenuHeader: String, Codable {
    case food = "FOOD"
    case recharge = "RECHARGE"
    case breakfast = "BREAKFAST"
    case lunch = "LUNCH"
    case dinner = "DINNER"
    case snacks = "SNACK"
    case limitedFood = "LIMITED FOODS"
    case activity = "ACTIVITY"
    case weight = "WEIGHT"
    case measurements = "MEASUREMENTS"
    case nourishmentPeriod = "NOURISHMENT PERIOD"
    case motivation = "MOTIVATION"
    case notes = "NOTES"
    
    case water = "WATER"
    case none = "none"
}

public enum ImageFormat {
    case png
    case jpeg(CGFloat)
}

public enum ExceptionString: String {
    /// Thrown during sign-up when email is already taken.
    case aliasExistsException = "AliasExistsException"
    /// Thrown when a user is not authorized to access the requested resource.
    case notAuthorizedException = "NotAuthorizedException"
    /// Thrown when the requested resource (for example, a dataset or record) does not exist.
    case resourceNotFoundException = "ResourceNotFoundException"
    /// Thrown when a user tries to use a login which is already linked to another account.
    case resourceConflictException = "ResourceConflictException"
    /// Thrown for missing or bad input parameter(s).
    case invalidParameterException = "InvalidParameterException"
    /// Thrown during sign-up when username is taken.
    case usernameExistsException = "UsernameExistsException"
    /// Thrown when user has not confirmed his email address.
    case userNotConfirmedException = "UserNotConfirmedException"
    /// Thrown when specified user does not exist.
    case userNotFoundException = "UserNotFoundException"
}

public enum NutritionTabType: Int {
    case search
    case recent
    case custom
}

 public enum DBType: Int {
    case foodDB
    case custom

}

public enum NutritionAdditionType: Int {
    case grocery
    case other
    case fresh
    case substitute
}
public enum SectionType: String {
    
    case substitutionType = "Substitution"
    case jennyCraigType = "JennyCraig Meal"
}
public enum NutritionType: String {

    case dbGrocery = "foodDB_grocery"
    case dbOther = "foodDB_other"
    case dbSubstitute = "foodDB_sub"
    case dbFresh = "foodDB_fresh"

    case dbMilks = "foodDB_add_Milks"
    case dbFats = "foodDB_add_Fats"
    case dbVegetables = "foodDB_add_Vegetables"

    case dBLimited = "foodDB_limited"
    case customGrocery = "customUSR_grocery"
    case customOther = "customUSR_other"
    case customFresh = "customUSR_fresh"
    case jcFood = "jc_food"

}

struct Nutrition {

    var nutritionTuple : (nutritionAdditionType: NutritionAdditionType, dbType: DBType)

    func nutritionType() -> NutritionType {

        switch nutritionTuple.nutritionAdditionType {

        case .grocery:
            switch nutritionTuple.dbType {
            case .foodDB:
                return .dbGrocery
            case .custom:
                return .customGrocery
            }
        case .other:
            switch nutritionTuple.dbType {
            case .foodDB:
                return .dbOther
            case .custom:
                return .customOther
            }
        case .fresh:
            switch nutritionTuple.dbType {
            case .foodDB:
                return .dbFresh
            case .custom:
                return .customFresh
            }
        case .substitute:
            switch nutritionTuple.dbType {
            case .foodDB:
                return .dbSubstitute
            case .custom:
                return .dbSubstitute
            }
        }

    }

}
