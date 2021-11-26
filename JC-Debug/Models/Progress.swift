//  ProgressView.swift
//  JennyCraig
//  Created by Mobileprogrammingllc on 8/14/18.
//  Copyright © 2018 JennyCraig. All rights reserved.

import UIKit

// MARK: - FoodList
struct ProgressModel: Codable, ResponseData {

    var error: Int?
    var successful: Int?
    var message: String?
    var dailyWeight: Float?
    var spinLeft: Int?
    var totalJennyStar: Int?
    var progressView: [ProgressView]?
    var messageType: String?
}

struct ProgressView: Codable {
    var mealsTracked: String?
    var exerciseMinutes: String?
    var weighIn: String?
    var mileStone1: String?
    var mileStone2: String?
    var fasting: String?
    var rejuvenationStart: String?
    var timeStamp: String?
    var colorFlag: String?
    var sharePresent: Int?
    //var shareMessage: String?
    var shareURL: String?
    var jennyStar: Int?
    var day: String?
    var mileStoneWeightLoss: String?
    var milestoneType: String?
    var spinWheelStar: String?
    var weeklyMealBonus: String?
    var weeklyActivityBonus: String?
    //var halfWay:String?
}
