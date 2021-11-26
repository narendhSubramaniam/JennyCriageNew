//  JCManager.swift
//  JennyCraig
//  Created by mobileprogrammingllc on 11/13/18.
//  Copyright © 2018 JennyCraig. All rights reserved.

import UIKit

final class JCManager: NSObject {

    static let shared = JCManager()

    /*All these 4 vars values will depend on the date of which user see the data eg.If its rejuvention on current day if user switches to previous days vars will become false */
    var isRejuvenationPeriodInProcess: Bool = false
    var isRejuvenationPeriodFinished: Bool = false
    var isNourishmentPeriodInProcess: Bool = false
    var isRejuvinationCarriedToNextDay: Bool = false
    /***********************/

    /*All these 3 vars values are independent of the date of which user see the data.
     eg.If its rejuvention on current day if user switches to previous days vars will still show rejuvention going on */
    var isRejuvenationCarriedToCurrentDay: Bool = false
    var rejuvenationTimerValue = ""
    var isClearingRejuvenation = false
    /***********************/

    var isUsernameUpdated: Bool = false
    var resetCodeDoesNotMatched: Bool = false
    var isNoInternetViewPresented: Bool  = false
    var currentCalenderDate = Date()
    var selectedDietMenuType = "Classic"
    var state: State = .collapsed
    var hasRapidResultFeature = false
    var currentWeight: Float?
    var startingWeight: Float?
    var goalWeight: Float?
    var todayWeight: Float?
    var selectedDay = ""
    var allMenusFilled = false
    var calendarDateForProgressView: String?
    var connectedApp: ConnectedApp = .none
    var weightScaleConnected: WeightScaleConnected = .none
    
    var userName = ""
    var password = ""
    var firstName = ""
    var lastName = ""
    var token = ""
    var tokenExpirationTime = Date().subtract(days: 1)
    var screenSourceType = ScreenSourceType.more
    
    var lastSyncDate = ""
    var sourceType = ""
    
    func cleanUp() {
        isRejuvenationPeriodInProcess = false
        isRejuvenationPeriodFinished = false
        isNourishmentPeriodInProcess = false
        countHomeScreenDisplayed = 0
        rejuvenationTimerDuration = 0
        labelTimerOnRejuvenationCell.text = ""
        rejuvenationTimerValue = ""
        isRejuvenationCarriedToCurrentDay = false
        durationForNourishment = 0
        isResetGoal = false
        isMessageShowing = false
        calendarDateForProgressView = nil
        isEditWeightFromProgress = false
        isViewEditing = false
        hasRapidResultFeature = false
        //isHeaderEnabled = true
        globalTimer?.invalidate()
        globalTimer = nil
        userName = ""
        password = ""
        firstName = ""
        lastName = ""
        token = ""
        sonicAPICalled = false
        currentOption = 0
        iswebUser = false
        var lastSyncDate = ""
        var sourceType = ""
        
    }

}
