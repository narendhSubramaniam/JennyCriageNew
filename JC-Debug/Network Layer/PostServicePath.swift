//  JCPostServicePath.swift
//  Jenny Craig
//  Created by Mobileprogrammingllc on 6/27/18.
//  Copyright © 2018 JennyCraig. All rights reserved.

import Foundation

protocol ParameterBodyMaker {

    var parameters: [String: Any]? {get}
    var path: ServerPaths {get}
}

/*
 ALL services post dictionary is mentioned under enum switch statement.
 These cases get their values in ViewController (or respective controller or other class).
 This enum also wrap a method which provides dictionary for post body.
 */

internal enum JCPostServicePath: ParameterBodyMaker {

    case login(username: String, password: String)
    case register(username: String, password: String, firstName: String, lastName: String, jennyid: String, phone: String, startingWeight: String, currentWeight: String, goalWeight: String, deviceType: String, deviceToken: String)
    case checkUser(username: String)
    case forgotPassword(username: String)
    case resetPassword(username: String, password: String, verifyToken: String)
  //  case dietMenu(currentDate: String, timeStamp: String )
    case dietMenu(currentDate: String, timeStamp: String, appVersion: Int )

    case dietSubMenu(timeStamp: String, menuId: Int, currentTimeStamp: String, currentDateTime: String)
    case foodItemMenu(timeStamp: String, menuId: Int, day: String, week: String, calorieValue: Int)
    case addExercise(exerciseName: String, timeStamp: String, duration: Int, distance: Float, ofSet: String, exerciseType: String, repitition: String)

    case exerciseList(timeStamp: String)
    case deleteExercise(exerciseId: Int, timeStamp: String)
    case updateExercise(exerciseId: Int, favorite: Int)
    case saveExerciseLog(timeStamp: String, exerciseId: String, duration: Int, distance: Float, ofSet: String, repitition: String, dailySteps: Int, exerciseName: String, exerciseLogId: String)
    case saveFoodMenu(time: String, checkedall: Int)
 //   case editWeightEntry(currentWeightDate: String, currentWeight: Float, timeStamp: String, currentDate: String, startingWeight: Float)
    case editWeightEntry(currentWeightDate: String, currentWeight: Float, timeStamp: String, currentDate: String, startingWeight: Float, wtType: String)


    case getFoodList(foodType: String)
    case addFood(brandName: String, servingSize: String, serving: String, quantity: String, foodType: String, foodName: String, calorieValue: String, day: String, week: String, menuId: String, menuType: String, timeStamp: String, currentTimeStamp: String, nixItemId: String)
    case addGroceryToLog(brandName: String, servingSize: String, serving: String, quantity: String, foodType: String, foodName: String, calorieValue: String, day: String, week: String, menuId: String, menuType: String, timeStamp: String, currentTimeStamp: String, groceryFoodId: Int, additionSubstitution: Int)

    case searchfooddb(foodName: String)
    case foodServing(foodName: String, timeStamp: String, foodType: String, brandName: String, nixItemId: String)
    case foodInfoViaUPCCode(upcCode: String, timeStamp: String, foodType: String, foodNameOrg: String, menuType: String)
    case addsubstitution(foodName: String, oldFoodID: Int, foodType: String, menuId: String, menuType: String, calorieValue: String, week: String, day: String, timeStamp: String, currentTimeStamp: String)

    case listallfood(foodType: String)
    case updatefood(foodId: Int, foodName: String, favorite: Int)

    case addUserFoodLog(servingSize: String, serving: String, quantity: String, foodType: String, foodId: Int, calorieValue: String, day: String, week: String, menuId: String, menuType: String, timeStamp: String, currentTimeStamp: String)

    case deleteFood(foodId: Int)
    case deleteLogExercise(exerciseId: Int, exerciseLogId: Int)
    case deleteWeightAPI(weight: Float, timestamp: String, wtType: String)
    case updateStartingWeight(startingWeight: Float, startingWeightDate: String, halfWayGoalWeight: Float, currentDate: String, timeStamp: String, todayWeight: Float)

    case updateGoalWeight(goalWeight: Float, goalWeightDate: String, halfWayGoalWeight: Float, currentDate: String, timeStamp: String)
    case dailyWeightList(currentDate: String, selfMonitorDate: String, weightDurationInterval: Int)

    case progressView(timeStamp: String, currentDate: String)
    case uploadmilestone(milestoneType: String, milestoneImageName: String)

    case confirmSignup( firstName: String, lastName: String, jennyid: String, phone: String, startingWeight: String, goalWeight: String, deviceType: String, deviceToken: String, userType: String, startingWeightDate: String, country: String, purpose: String, purposeReminder: Int = 0, motivation: String, motivationReminder: Int = 0, newsLetter: Int = 0, isConfirm: Bool, sonicLogic: Int)
    case resetToken(username: String, accessToken: String)
    case getSetting(currentDate: String)
    case updatesetting(keyValue: String, keyName: String)
    case checkregistered
    case getPdf(weekstart: String, weekend: String)
    case getCenterLocation
    case getJennyStar(timeStamp: String)
    case setJennyStar(timeStamp: String, jennyStar: Int, reasonFor: Int, selfMonitortDate: String)
    case saveRapidResult(timeStamp: String, rapidType: String, lastCalorieTime: String, firstCalorieTime: String, currentTimeStamp: String, currentDateTime: String)
    
    
    case saveUserCalendar(startDate: String, remove: Int)
    case resetusergoal(timeStamp: String, startingWeight: String, goalWeight: String, startingWeightDate: String)
    case savemeasurements(bustchest: Float, abdomen: Float, waist: Float, hips: Float, timeStamp: String)
    case usermeasurements(timeStamp: String)
    case userSignin(firstName: String, lastName: String, timeStamp: String)
    case sonicRegistration(firstName: String, lastName: String, timeStamp: String)

    case updatemotivation(keyName: String, keyValue: String)
    case updatenotes(dailyNotes: String, timeStamp: String)
    case usersavewater(timeStamp: String, quantity: Float, measureType: Int, isEdit: Int)
    case confirmEmailId
    case resetPopUpFlag
    case generateAccessTokenAndRefreshToken(clientID: String, grantType: String, redirectURI: String, code: String)
    case refreshAccessTokenAndRefreshToken(grantType: String, refreshToken: String)
    case sonicDataHide(displaySonicWeights: Int)
   // case healthDataAPI(sourceType: String, timestamp: String, steps: Int, floors: Int, caloriesBurned: Float, distance: Float, weight: Float, activitylist: [[String:Any]] ,  measurementInfo : [String:Any])
    case healthDataAPI(dictionary: [[String:Any]])


    // MARK: - Path
    internal var path: ServerPaths{
        switch self {
        case .login:
            return .login
        case .register:
            return .register
        case .checkUser:
            return .checkUser
        case .forgotPassword:
            return .forgotPassword
        case .resetPassword:
            return .resetPassword
        case .dietMenu:
            return .dietMenu
        case .dietSubMenu:
            return .dietSubMenu
        case .foodItemMenu:
            return .foodItemMenu
        case.addExercise:
            return .addExercise
        case.saveFoodMenu:
            return .saveFoodMenu
        case .exerciseList:
            return .exerciseList
        case .saveExerciseLog:
            return .saveExerciseLog
        case .deleteExercise:
            return .deleteExercise
        case .editWeightEntry:
            return .editWeightEntry
        case .getFoodList:
            return .getFoodList
        case .addFood:
            return .addFood
        case .searchfooddb:
            return .searchfooddb
        case .listallfood:
            return .listallfood
        case .updatefood:
            return .updatefood
        case .addUserFoodLog:
            return .addUserFoodLog
        case .deleteFood:
            return .deleteFood
        case .deleteLogExercise:
            return .deleteLogExercise
            case .deleteWeightAPI:
                      return .deleteWeightAPI
        case .updateStartingWeight:
            return .updateStartingWeight

        case.updateGoalWeight:
            return .updateGoalWeight

        case .dailyWeightList:
            return .dailyWeightList

        case .progressView:
            return .progressView

        case .uploadmilestone:
            return .uploadmilestone

        case .confirmSignup:
            return .confirmSignup

        case .resetToken:
            return .resetToken

        case .getSetting:
            return .getSetting

        case .updatesetting:
            return .updatesetting

        case .getCenterLocation:
            return .getCenterLocation

        case .checkregistered:
            return .checkregistered

        case .getPdf:
            return .getPdf

        case .getJennyStar:
            return .getJennyStar

        case .setJennyStar:
            return .setJennyStar

        case .saveRapidResult:
            return .saveRapidResult

        case .updateExercise:
            return .updateExercise

        case .saveUserCalendar:
            return .saveUserCalendar

        case .resetusergoal:
            return .resetusergoal

        case .savemeasurements:
            return .savemeasurements

        case .usermeasurements:
            return .usermeasurements

        case .sonicRegistration:
            return .sonicRegistration

        case .userSignin:
            return .userSignin

        case .updatemotivation:
            return .updatemotivation
            
        case .updatenotes:
            return .updatenotes
            

        case .usersavewater:
            return .usersavewater

        case .confirmEmailId:
            return .confirmEmailId

        case .resetPopUpFlag:
            return .resetPopUpFlag

        case .foodServing:
            return .foodServing

        case .foodInfoViaUPCCode:
            return .foodInfoViaUPCCode

        case .addsubstitution:
            return .addsubstitution

        case .addGroceryToLog:
            return .addGroceryToLog

        case .generateAccessTokenAndRefreshToken:
            return .fitbitOauth2Token

        case .refreshAccessTokenAndRefreshToken:
            return .fitbitOauth2Token

        case .sonicDataHide:
            return .sonicDataHide
        case .healthDataAPI:
            return .healthDataAPI

        }
   
    }

    // MARK: - Parameters
    internal var parameters: [String: Any]? {
        var params = [String: Any]()
        switch self {
        case .login(let username, let password):
            params["username"] = username.lowercased()
            params["password"] = password
        case .checkUser(let username):
            params["username"] = username.lowercased()
        case .forgotPassword(let username):
            params["username"] = username.lowercased()
        case let .resetPassword(username, password, verifyToken):
            params["username"] = username.lowercased()
            params["password"] = password
            params["verifyToken"] = verifyToken
        case let .register(username, password, firstName, lastName, jennyid, phone, startingWeight, currentWeight, goalWeight, deviceType, deviceToken):
            params["username"] = username.lowercased()
            params["password"] = password
            params["firstName"] = firstName
            params["lastName"] = lastName
            params["jennyid"] = jennyid
            params["phone"] = phone
            params["startingWeight"] = startingWeight
            params["currentWeight"] = currentWeight
            params["goalWeight"] = goalWeight
            params["deviceType"] = deviceType
            params["deviceToken"] = deviceToken

    case .dietMenu(let currentDate, let timeStamp, let appVersion):
            params["currentDate"] = currentDate
            params["timeStamp"] = timeStamp
            params["appVersion"] = appVersion
            
        case .dietSubMenu(let timeStamp, let menuId, let currentTimeStamp, let currentDateTime):
            params["timeStamp"] = timeStamp
            params["menuId"] = menuId
            params["currentTimeStamp"] = currentTimeStamp
            params["currentDateTime"] = currentDateTime

        case .foodItemMenu(let timeStamp, let menuId, let day, let week, let calorieValue):
            params["timeStamp"] = timeStamp
            params["menuId"] = menuId
            params["day"] = day
            params["week"] = week
            params["calorieValue"] = calorieValue

        case .addExercise(let exerciseName, let timeStamp, let duration, let distance, let ofSet, let exerciseType, let repitition):
            params["exerciseName"] = exerciseName
            params["timeStamp"] = timeStamp
            params["duration"] = duration
            params["distance"] = distance
            params["ofSet"] = ofSet
            params["exerciseType"] = exerciseType
            params["repitition"] = repitition

        case .deleteExercise(let  exerciseId, let timeStamp):
            params["exerciseId"] = exerciseId
            params["timeStamp"] = timeStamp

        case .exerciseList(let timeStamp):
            params["timeStamp"] = timeStamp

        case .saveExerciseLog(let timeStamp, let exerciseId, let duration, let distance, let ofSet, let repitition, let dailySteps, let exerciseName, let exerciseLogId):
            params["timeStamp"] = timeStamp
            params["exerciseId"] = exerciseId
            params["duration"] = duration
            params["distance"] = distance
            params["ofSet"] = ofSet
            params["repitition"] = repitition
            params["dailySteps"] = dailySteps
            params["exerciseName"] = exerciseName
            params["exerciseLogId"] = exerciseLogId

        case .editWeightEntry(let currentWeightDate, let currentWeight, let timeStamp, let currentDate, let startingWeight, let wtType):
            params["currentWeightDate"] = currentWeightDate
            params["currentWeight"] = currentWeight
            params["timeStamp"] = timeStamp
            params["currentDate"] = currentDate
            params["startingWeight"] = startingWeight
            params["WtType"] = wtType

        case .getFoodList(let foodType):
            params["foodType"] = foodType

        case .addFood(let brandName, let servingSize, let serving, let quantity, let foodType, let foodName, let calorieValue, let day, let week, let menuId, let menuType, let timeStamp, let currentTimeStamp, let nixItemId):
            params["brandName"] = brandName
            params["servingSize"] = servingSize
            params["serving"] = serving
            params["quantity"] = quantity
            params["foodType"] = foodType
            params["foodName"] = foodName
            params["calorieValue"] = calorieValue
            params["day"] = day
            params["week"] = week
            params["menuId"] = menuId
            params["menuType"] = menuType
            params["timeStamp"] = timeStamp
            params["currentTimeStamp"] = currentTimeStamp
            params["nix_item_id"] = nixItemId

        case .addGroceryToLog(let brandName, let servingSize, let serving, let quantity, let foodType, let foodName, let calorieValue, let day, let week, let menuId, let menuType, let timeStamp, let currentTimeStamp, let groceryFoodId, let additionSubstitution):
            params["brandName"] = brandName
            params["servingSize"] = servingSize
            params["serving"] = serving
            params["quantity"] = quantity
            params["foodType"] = foodType
            params["foodName"] = foodName
            params["calorieValue"] = calorieValue
            params["day"] = day
            params["week"] = week
            params["menuId"] = menuId
            params["menuType"] = menuType
            params["timeStamp"] = timeStamp
            params["currentTimeStamp"] = currentTimeStamp
            params["groceryFoodId"] = groceryFoodId
            params["additionSubstitution"] = additionSubstitution

        case .searchfooddb(let foodName):
            params["foodName"] = foodName

        case .listallfood(let foodType):
            params["foodType"] = foodType

        case .foodServing(let foodName, let timeStamp, let foodType, let brandName, let nixItemId):
            params["foodName"] = foodName
            params["timeStamp"] = timeStamp
            params["foodType"] = foodType
            params["brandName"] = brandName
            params["nix_item_id"] = nixItemId

        case .foodInfoViaUPCCode(let upcCode, let timeStamp, let foodType, let foodNameOrg, let menuType):
            params["upcCode"] = upcCode
            params["timeStamp"] = timeStamp
            params["foodType"] = foodType
            params["foodName_org"] = foodNameOrg
            params["menuType"] = menuType

        case .addsubstitution(let foodName, let oldFoodID, let foodType, let menuId, let menuType, let calorieValue, let week, let day, let timeStamp, let currentTimeStamp):
            params["foodName"] = foodName
            params["oldFoodID"] = oldFoodID
            params["foodType"] = foodType
            params["menuId"] = menuId
            params["menuType"] = menuType
            params["calorieValue"] = calorieValue
            params["week"] = week
            params["day"] = day
            params["timeStamp"] = timeStamp
            params["currentTimeStamp"] = currentTimeStamp

        case .updatefood(let foodId, let foodName, let favorite):
            params["foodId"] = foodId
            params["foodName"] = foodName
            params["favorite"] = favorite

        case .addUserFoodLog(let servingSize, let serving, let quantity, let foodType, let foodId, let calorieValue, let day, let week, let menuId, let menuType, let timeStamp, let currentTimeStamp):

            params["servingSize"] = servingSize
            params["serving"] = serving
            params["quantity"] = quantity
            params["foodType"] = foodType
            params["foodId"] = foodId
            params["calorieValue"] = calorieValue
            params["day"] = day
            params["week"] = week
            params["menuId"] = menuId
            params["menuType"] = menuType
            params["timeStamp"] = timeStamp
            params["currentTimeStamp"] = currentTimeStamp

        case .deleteFood(let foodId):
            params["foodId"] = foodId

        case .deleteLogExercise(let exerciseId, let exerciseLogId):
            params["exerciseId"] = exerciseId
            params["exerciseLogId"] = exerciseLogId
            
            case .deleteWeightAPI(let weight, let timestamp, let wtType):
            params["weight"] = weight
            params["timestamp"] = timestamp
            params["WtType"] = wtType

        case .updateStartingWeight(let startingWeight, let startingWeightDate, let halfWayGoalWeight, let currentDate, let timeStamp, let todayWeight):
            params["startingWeight"] = startingWeight
            params["startingWeightDate"] = startingWeightDate
            params["halfWayGoalWeight"] = halfWayGoalWeight
            params["currentDate"] = currentDate
            params["timeStamp"] = timeStamp
            params["todayWeight"] = todayWeight

        case .updateGoalWeight(let goalWeight, let goalWeightDate, let halfWayGoalWeight, let currentDate, let timeStamp):
            params["goalWeight"] = goalWeight
            params["goalWeightDate"] = goalWeightDate
            params["halfWayGoalWeight"] = halfWayGoalWeight
            params["currentDate"] = currentDate
            params["timeStamp"] = timeStamp

        case .dailyWeightList(let currentDate, let selfMonitorDate, let weightDurationInterval):
            params["currentDate"] = currentDate
            params["selfMonitorDate"] = selfMonitorDate
            params["weightDurationInterval"] = weightDurationInterval

        //Original
        case .progressView(let timeStamp, let currentDate):
            params["timeStamp"] = timeStamp
            params["currentDate"] = currentDate

        case .uploadmilestone(let milestoneType, let milestoneImageName):
            params["milestoneType"] = milestoneType
            params["milestoneImageName"] = milestoneImageName

        case .saveFoodMenu(let time, let checkedall):
            params["time"] = time
            params["checkedall"] = checkedall

        case .confirmSignup( let firstName, let lastName, let jennyid, let phone, let startingWeight, let goalWeight, let deviceType, let deviceToken, let userType, let startingWeightDate, let country, let purpose, let purposeReminder, let motivation, let motivationReminder, let newsLetter, let isConfirm, let sonicLogic):
            params["firstName"] = firstName
            params["lastName"] = lastName
            params["jennyid"] = jennyid
            params["phone"] = phone
            params["startingWeight"] = startingWeight
            params["goalWeight"] = goalWeight
            params["deviceType"] = deviceType
            params["deviceToken"] = deviceToken
            params["userType"] = userType
            params["startingWeightDate"] = startingWeightDate
            params["country"] = country
            params["purpose"] = purpose
            params["purpose_reminder"] = purposeReminder
            params["motivation"] = motivation
            params["motivation_reminder"] = motivationReminder
            params["newsletter"] = newsLetter
            params["isConfirm"] = isConfirm
            params["sonicLogic"] = sonicLogic

        case .sonicDataHide(let displaySonicWeights):
            params["display_sonic_weights"] = displaySonicWeights
            
        case .resetToken(let username, let accessToken):
            params["username"] = username.lowercased()
            params["accessToken"] = accessToken

        case .getSetting(let currentDate):
            params["currentDate"] = currentDate
           // break

        case .updatesetting(let keyValue, let keyName):
            if keyValue.count == 0 {
                params["keyName"] = keyName
            } else {
                params["keyValue"] = keyValue
                params["keyName"] = keyName
            }

        case .getCenterLocation:
            break

        case .confirmEmailId:
            break

        case .checkregistered:
            break

        case .userSignin(let firstName, let lastName, let timeStamp):
            params["timeStamp"] = timeStamp
            params["firstName"] = firstName
            params["lastName"] = lastName

        case .sonicRegistration(let firstName, let lastName, let timeStamp):
                params["timeStamp"] = timeStamp
                params["firstName"] = firstName
                params["lastName"] = lastName

        case .getPdf(let weekstart, let weekend):
            params["weekstart"] = weekstart
            params["weekend"] = weekend

        case .getJennyStar(let timeStamp):
            params["timeStamp"] = timeStamp

        case .setJennyStar(let timeStamp, let jennyStar, let reasonFor, let selfMonitortDate):
            params["timeStamp"] = timeStamp
            params["jennyStar"] = jennyStar
            params["reasonFor"] = reasonFor
            params["selfMonitortDate"] = selfMonitortDate

        case .saveRapidResult(let timeStamp, let rapidType, let lastCalorieTime, let firstCalorieTime, let currentTimeStamp, let currentDateTime):
            params["timeStamp"] = timeStamp
            params["rapidType"] = rapidType
            params["lastCalorieTime"] = lastCalorieTime
            params["firstCalorieTime"] = firstCalorieTime
            params["currentTimeStamp"] = currentTimeStamp
            params["currentDateTime"] = currentDateTime

        case .updateExercise(let exerciseId, let favorite):
            params["exerciseId"] = exerciseId
            params["favorite"] = favorite
        case .saveUserCalendar(let startDate, let remove):
            params["startDate"] = startDate
            params["remove"] = remove

        case .resetusergoal(let timeStamp, let startingWeight, let goalWeight, let startingWeightDate):
            params["timeStamp"] = timeStamp
            params["startingWeight"] = startingWeight
            params["goalWeight"] = goalWeight
            params["startingWeightDate"] = startingWeightDate

        case .savemeasurements(let bustchest, let abdomen, let waist, let hips, let timeStamp):
            params["bustchest"] = bustchest
            params["abdomen"] = abdomen
            params["waist"] = waist
            params["hips"] = hips
            params["timeStamp"] = timeStamp

        case .usermeasurements(let timeStamp):
            params["timeStamp"] = timeStamp

        case .updatemotivation(let keyName, let keyValue):
            params["keyName"] = keyName
            params["keyValue"] = keyValue
            
        case .updatenotes(let dailyNotes, let timeStamp):
            params["dailyNotes"] = dailyNotes
            params["timeStamp"] = timeStamp

        case .usersavewater(let timeStamp, let quantity, let measureType, let isEdit):
            params["timeStamp"] = timeStamp
            params["quantity"] = quantity
            params["measureType"] = measureType
            params["isEdit"] = isEdit

        case .resetPopUpFlag:
            break

        case .generateAccessTokenAndRefreshToken(let clientID, let grantType, let redirectURI, let code):
            params["client_id"] = clientID
            params["grant_type"] = grantType
            params["redirect_uri"] = redirectURI
            params["code"] = code

        case .refreshAccessTokenAndRefreshToken(let grantType, let refreshToken):
            params["grant_type"] = grantType
            params["refresh_token"] = refreshToken
       /*
        case .healthDataAPI(let sourceType,  let timestamp,  let steps,  let floors,  let caloriesBurned,  let distance,  let weight, let activitylist, let measurementInfo ):

            params["sourceType"] = sourceType
            params["timestamp"] = timestamp
            params["steps"] = steps
            params["floors"] = floors
            params["caloriesBurned"] = caloriesBurned
            params["distance"] = distance
            params["Weight"] = weight
            params["activityList"] = activitylist
            params["measurementInfo"] = measurementInfo
            */
            
        case .healthDataAPI(let list):

            params["healthData"] = list

            
          
        }
        
        
        return params
    }
}

enum ServerPaths: String {

    case forgotPassword = "newuser/forgotpassword"
    case resetPassword = "newuser/resetpassword"
    case login = "newuser/userlogin"
    case checkUser = "newuser/checkuser"
    case register = "newuser/registeruser"
    case dietMenu = "updatednewhome/selfmonitor"
    case dietSubMenu = "updatednewhome/usedmenu"
    //case foodItemMenu = "updatednewhome/foodmenu"
    //case foodItemMenu = "updatednewhome/newfoodmenu"
    case foodItemMenu = "updatednewhome/updatedfoodmenu" //updated on march 11,2020
    case addExercise =  "updatednewhome/saveexercise"
    case exerciseList =  "updatednewhome/listexercise"
   // case saveFoodMenu =  "updatednewhome/newsavefoodmenu"
    case saveFoodMenu =  "updatednewhome/updatedsavefoodmenu" // Updated on January 15,2020
    case saveExerciseLog = "updatednewhome/saveexerciselog"
    case deleteExercise = "updatednewhome/deleteexercise"
    case editWeightEntry = "updatednewhome/updatecurrentweight"
    case getFoodList = "updatednewhome/listfood"
    case addFood = "updatednewhome/addfood"
    case searchfooddb = "fooddb/searchfooddb"
    case listallfood = "updatednewhome/listallfood"
    case updatefood = "updatednewhome/updatefood"
    case addUserFoodLog = "updatednewhome/adduserfoodlog"
    case deleteFood = "updatednewhome/deletefood"
    case deleteLogExercise = "updatednewhome/deletelogexercise"
    case deleteWeightAPI = "updatednewhome/deleteweight"
    case updateStartingWeight = "updatednewhome/updatestartingweight"
    case updateGoalWeight = "updatednewhome/updategoalweight"
    case dailyWeightList = "updatednewhome/dailyweightlist"
    case progressView = "updatednewhome/progressview"
    case uploadmilestone = "updatednewhome/uploadmilestone"
    case confirmSignup = "user/signup"
    case resetToken = "resettoken"
    //case getSetting = "newuser/getsetting"
    case getSetting = "newuser/getsettingnew"
    case updatesetting = "newuser/updatesetting"
    case getCenterLocation = ""
    case checkregistered = "newuser/checkregistered"
    //case getPdf = "updatednewhome/getpdf"
    case getPdf = "foodmenu/getpdfmenu"
    case getJennyStar = "updatednewhome/getjennystar"
    case setJennyStar = "updatednewhome/savejennystarspinner"
    case saveRapidResult = "updatednewhome/saverapidresults"
    case updateExercise = "updatednewhome/updateexercise"
    case saveUserCalendar = "updatednewhome/saveusercalender"
    case resetusergoal = "newuser/resetusergoal"
    case savemeasurements = "newuser/savemeasurements"
    case usermeasurements = "newuser/usermeasurements"
    case sonicRegistration = "newuser/sonicregistrationnew"
    case userSignin = "newuser/signinnew"
    case updatemotivation = "newuser/updatemotivation"
    case updatenotes = "newuser/addusernotes" 
    case usersavewater = "newuser/savewater"
    case confirmEmailId  = "newuser/confirmemailid"
    case resetPopUpFlag  = "newuser/resetpopupflag"
    case foodServing = "fooddb/servingbyfoodname"
    case foodInfoViaUPCCode = "fooddb/servingbyscanning"
    case addsubstitution =  "updatednewhome/addsubstitution"
    case addGroceryToLog = "updatednewhome/addgroceryfood"
    case fitbitOauth2Token = "oauth2/token"
    case sonicDataHide = "newuser/displaysonicweight"
    
    case healthDataAPI = "user/healthdata"
}
