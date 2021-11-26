//  GlobalValues.swift
//  JennyCraig
//  Created by Mobileprogrammingllc on 8/14/18.
//  Copyright © 2018 JennyCraig. All rights reserved.

import Foundation
import UIKit

var passwordLocalSignup = ""
var durationForNourishment: TimeInterval = Identifiers.nourishmentRejuvinationTimePeriod
var rejuvenationTimerDuration: TimeInterval = Identifiers.nourishmentRejuvinationTimePeriod

var boolIsConfirmSignup = false
var isRegisterSuccessfully = false


var iswebUser = false
var idForWebUser = ""
var firstNameWebUser = ""
var lastNameWebUser = ""
var gifTimer: Float = 1.0

var countHomeScreenDisplayed = 0

var isSessionLoggedOut = false
var isFollowingRegistrationProcess = false

var boolnavigate = false
var boolRemoveImage = false
var lastWeighIn: Float?
var lastWeighInHistory: Float?
var todaysWeight: Float?
var totalJennyStar: Int?
var boolLogout = false
var limitedFoodUrl = ""
var isFoodSelected =  false
var isResetGoal: Bool = false
var checkedAllValue = 0
var startDateForPDF: Date = Date()
var endDateForPDF: Date = Date()
var isMessageShowing = false
var isEditWeightFromProgress: Bool = false
var isViewEditing: Bool = false
//updateFood
//var foodObjectToEdit: FoodItemsList?

var labelTimerOnRejuvenationCell = UILabel()
var rapidResultPeriod = ""
var globalTimer: Timer?
//let imageCache = NSCache<NSString, AnyObject>()

var arrayForBool = [Bool]()
//var isHeaderEnabled = true
var isTableViewUserInteracted =  false
var isChecked = true

var sonicAPICalled = false
var keychainService = ""
var currentOption = 0
var secondMileStone = ""
var mileStoneGifImage2 = ""

var secondInspirationalQuote = ""
var secondMilestoneQuote = ""
var motivationText = ""
var notesText = ""

var firstNameForClearTracking = ""
var lastNameForClearTracking = ""
var emailForClearTracking = ""
var waterTapped = false
var isAddWaterFromQuickNav: Bool = false
var waterText = ""
var unitText = ""
var textFieldTapped = true
var isDateChanged: Bool = false
var nutritionTab = 0
var progressTab = 0
var weightHeaderTitle = "LAST WEIGH-IN"
var lastSyncDateString = ""
var addButtonClicked = false
var substitureArrayShow: SubstitureArrayShow = .jennyCraigArray  // Change type of enum if we will need to both substitute and jennyCraig array .


var weightScaleMacAvailable = false
var weightScaleMacList = [String]()
let weightScaleDefaults = UserDefaults.standard
let lastWeightValueDefaults = UserDefaults.standard
