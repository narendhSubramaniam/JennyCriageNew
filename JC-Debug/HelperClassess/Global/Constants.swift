//  Constants.swift
//  JennyCraig
//  Created by Mobileprogrammingllc on 6/21/18.
//  Copyright © 2018 JennyCraig. All rights reserved.

import Foundation
import UIKit
import AWSCognitoIdentityProvider

struct Identifiers {
    
    static let nourishmentRejuvinationTimePeriod: TimeInterval = 43200
    //Formatters
    static let eeMMMdFormatter = "EE, MMM d"
    static let eeeeMMMdFormatter = "EEEE MMM d"
    static let mmmdFormatter = "MMM d"
    static let mmdFormatter = "MM/d"
    static let mmmdyyyyFormatter = "MMM d, yyyy"
    static let mmmmdyyyyFormatter = "MMMM d, yyyy"
    static let syncDateFormatter = "MMMM d, yyyy h:mm a"
    static let yyyyMMddFormatter = "yyyy-MM-dd"
    static let mmddyyyyFormatter = "MM-dd-yyyy"
    static let yyyyMMddHHmmssFormatter = "yyyy-MM-dd HH:mm:ss" //2018-08-01 12:12:33
    
    static let yyyyMMddTZFormatter = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
    static let yyyyMMddTZXXXFormatter = "yyyy-MM-dd'T'HH:mm:ss.SSSXXX"
    
    static let CognitoIdentityUserPoolRegion: AWSRegionType = .Unknown
    static let AWSCognitoUserPoolsSignInProviderKey = "UserPool"
    static let FlurryAPIKEY = "GNBRT39HT2R2XV46ZSXG"
    static let ProdAppIdentifier = "com.jennycraig.jennycraigios"
    static let APPDELEGATE = UIApplication.shared.delegate as? AppDelegate
    struct WeightPopoverConstants {
        static let kTypeWeightEntryCurrent = "current"
        static let kTypeWeightEntryStarting = "starting"
        static let kTypeWeightEntryGoal = "goal"
        static let kTypeWeightEntryToday = "Today"
    }
    struct SubstituteVCConstant {
        static let kTypeSubstitute = "kSubstitute"
    }
    struct AddFoodExerciseConstant {
        static let kTypeFood = "kFood"
        static let kTypeExercise = "kExercise"
        static let kTypeWeight = "kWeight"
    }
    struct PopoverConstant {
        static let kTypeSelfMonitorPopoverSwap = "kSwap"
        static let kTypeSelfMonitorPopoverMenu = "kMenu"
    }
    struct SegueIdentifiers {
        static let JCCreateProfileSegueIdentifier = "JCCreateProfileSegueIdentifier"
        static let JCGoalWeightSegueIdentifier = "JCGoalWeightSegueIdentifier"
        static let JCHomeNavigationSegueIdentifier = "JCHomeNavigationSegueIdentifier"
        static let JCEmailAlreadyExistSegueIdentifier = "JCEmailAlreadyExistSegueIdentifier"
        static let JCResetPasswordSegueIdentifier = "JCResetPasswordSegueIdentifier"
        static let JCTermsConditionsSegueIdentifier = "JCTermsConditionsSegueIdentifier"
        static let JCEmailValidatorSegueIdentifier = "JCEmailValidatorSegueIdentifier"
        static let JCSignInViewSegueIdentifier = "JCSignInViewSegueIdentifier"
        static let JCConfirmEmailSegueIdentifier = "JCConfirmEmailController"
    }
    static var hasTopNotch: Bool {
        if #available(iOS 11.0, *) {
            return       UIApplication.shared.delegate?.window??.safeAreaInsets.top ?? 0 > 20
        }
        return false
    }
    struct Message {
        static let NewVersionUpdate = "There is a newer version of the Jenny Craig app available for download. Please visit the Apple Store to update to the new version."
        static let NewVersionAvailable = "New Version Available"
        static let CouldNotConnectWithServer = "Could not connect with server."
        static let NoInternetConnectivity = "You are not connected to Internet. Please connect to the internet to continue using the Jenny Craig app."
        static let PasswordMatch = "Passwords must match"
        static let PasswordValidation = "Password must be at least 6 characters with a number."
        static let RejuvenationClearance = "Your Rejuvenation Period will be cleared."
        static let CallNotAllowed = "Call Not Allowed"
        static let TermsAndConditions = "Prior to accessing the Jenny Craig app, you must agree to the terms and conditions."
        static let FoodDeletion = "Do you want to delete this food item?"
        static let EnterFoodName = "Please enter food name."
        static let EnterServingSize = "Please enter serving size."
        static let EnterWeight = "Please enter weight."
        static let EnterDate = "Please enter date."
        static let MilestoneToSpinWheel = "You have to reach a milestone to spin the wheel."
        static let NoZeroMinutes = "Duration should not be 0."
        static let NoZeroDistance = "Distance should not be 0."
        static let NoZeroOfsets = "of Sets should not be 0."
        static let NoZeroRepetition = "Repetitions should not be 0."
        static let CountryEmptyMessage = "Country cannot be empty."
        
        static let NoZeroStartWeight =  "Start weight cannot be 0."
        static let NoZeroGoalWeight =  "Goal weight cannot be 0."
        
        static let NoZeroSteps = "Steps should not be 0."
        static let AddMinutes = "Please add minutes."
        static let AddMinutesWithExcercise = "Please add your duration and then save."
        static let AddDistanceWithActivty = "Please add your distance and then save."
        static let AddOfSets = "Please add # of Sets and then save."
        static let AddRepetitions = "Please add Repititions and then save."
        static let manualSteps = "Please add manual steps and then save."
        static let AddDistanceOrdurationWithActivty = "Please enter a value for duration or distance."
        static let AddSetsOrrepetitionWithActivty = "Please enter a value for # of sets or repititions."
        static let EnterExerciseName = "Please enter activity name."
        static let UsernameChanged = "Username successfully changed"
        static let ResetGoal = "Using this function will delete all your tracking history (meals, weights and milestones). Are you sure you want to start over?"
        static let AllFieldsRequired = "All fields are required"
        static let PasswordDoesNotMatch = "Password does not match"
        static let ResetCodeDoesNotMatch = "The reset code entered does not match the emailed code."
        static let EmailNotAssociated = "This email is not associated with an existing account. Please try a different email address or go back and tap SIGN UP to create an account."
        static let IncorrectEmailOrPassword = "Incorrect email address or password."
        static let SelectFirstCalorieTime = "Please set your nourishment start time prior to setting your nourishment stop time."
        static let SelectAllMenus = "Please select all menu options"
        static let SelectPreviousMenu = "Please select the previous menu option."
        static let UnderDevelopment = "Under Development"
        static let IncorrectPassword = "Incorrect Current Password"
        static let PasswordChangedSuccess = "Password changed successfully"
        static let EmailIsDifferent = "This email address is in use on a different account. Please log out and log back in using this email address or contact 800-JennyCare for assistance."
        static let ResetCodeMailed = "A reset code has been emailed to you. Please check your email and return to enter your code"
        static let EmailAlreadyExists = "Email Already Exists"
        static let EmailCannotEmpty = "Email ID cannot be empty."
        static let ConfimationCodeCannotEmpty = "Confirmation code cannot be empty."
        static let EmailChanged = "Email address changed successfully."
        static let PhotosNotAccessed = "Jenny Craig does not have access to your photos. To enable access, tap Settings and turn on photos."
        static let CameraNotAccessed = "Jenny Craig does not have access to your camera. To enable access, tap Settings and turn on camera."
        static let StartWeightGreater = "Your start weight must be greater than your goal weight. Please review and update your weights."
        static let GoalWeightLess = "Your goal weight must be less than your start weight. Please review and update your weights."
        static let CompleteRequiredFields = "Please complete the required fields."
        static let EnterDifferentStartDate = "Since your starting weight and current weight are different, do you want to enter a different starting date?"
        static let TrackingForSelectedFood = "If you change your menu today, your tracking will be removed. Are you sure you want to continue?"
        static let CalorieBanner2000 =  "Additional daily calories are needed"
        static let CalorieBanner2300 = "Additional daily calories are needed"
        static let Type2CalorieBanner2000 = "Additional daily calories are needed"
        static let Type2CalorieBanner2300 = "Additional daily calories are needed"
        static let Calorie2000 = "Add one additional Jenny Craig item every day or follow alternate options as directed by your Consultant. Track these foods in the \"Other Food and Drink\" section."
        static let Calorie2300 = "Add two additional Jenny Craig items and one milk every day or follow alternate options as directed by your Consultant. Track these foods in the \"Other Food & Drink\" section."
        static let Type2Calorie2300 = "Add 2 Starch, 1 Fruit, 4 Protein 1 Milk and 1 Fat every day or follow alternate options as directed by your Consultant. Track these foods using \"Other Food & Drink\" section."
        static let Type2Calorie2000 = "Add 1 Starch, 1 Fruit, 2 Protein and 1 Fat every day or follow alternate options as directed by your Consultant. Track these foods using \"Other Food & Drink\" section."
        static let ChooseMenuToBeginTracking = "Choose Menu above to begin tracking your food"
        static let ChooseCalorieToBeginTracking = "Choose Calorie above to begin tracking your food"
        static let ChooseWeekToBeginTracking = "Choose Week above to begin tracking your food"
        static let ChooseDayToBeginTracking = "Choose Day above to begin tracking your food"
        static let cantTrackOnADayInTheFuture = "You can’t track on a day in the future."
        static let measurementFieldRequired =  "Measurements entered must be greater than 0. Enter a valid measurement or leave blank."
        static let passwordResetConfirmationMessage = "Your password was successfully reset."
        static let phoneNolenthMessage = "Please update your phone number to include 10 digits"
        static let emptyTextFieldMessage = "Text field cannot be empty."
        static let dontForgetToStopRejuvenationMessage = "Don’t forget to stop your rejuvenation timer. Go to the nourishment tab to enter the time you started eating today."
        static let weightsUpdatedByConsultantMessage = "Your start date, start weight and goal weights have been updated to match information entered by your consultant."
        static let  noMatchingRecentFoodsFound   = "No matching recent foods found.Tap the + above to create a new custom food or tap the search tab to search for your food."
        static let  noMatchingCustomFoodsFound   =  "No matching custom foods found.Tap the + above to create a new custom food or tap the search tab to search for your food."
        static let  createNewCustomFood   =   "Tap the + above to create a new custom food."
        static let  useTheBarcodeScannerToAdd   =  "Tap the + above or use the barcode scanner to add other food."
        static let  syncWithFitBitOrAppleHealthDevice = "Would you like to sync with Fitbit or AppleHealth?"
        static let  bottomNoteForDeviceSync = "You can adjust your settings from the More screen."
        static let  connectionOneAtaTimeMessage = "To ensure accurate data, our app only can connects to  one device or app at a time."
        static let  healkitDisconnectMessage = "Would you like to disconnect your Health app?"
        static let  fitbitDisconnectMessage = "Would you like to disconnect your fitbit?"
        static let  discardChangesMessage = "Are you sure you want to discard your changes?"
        static let  accessHealthAppMessage = "Please open Apple health app to allow access."
        static let  disconnectHealthAppMessage = "Please open Apple health app to disconnect."
        static let  deleteActivityMessage =  "Are you sure you want to delete this activity from your log?"
        static let  enterServingSizeMessage = "Please enter Serving Size that you are showing for custom foods"
        static let  selectAllMenuOptionMessage = "Please select all menu options before setting your Start and Stop times."
        static let  logoutAlldevicesMessage = "This will log you out from all logged in devices"
        static let  motivatePlannedMenuMessage = "What will motivate you to stick to your planned menu this week?"
        static let  notesPlannedMenuMessage = "Enter notes here"
        static let  missingNourishmentMessage = "Please set any missing nourishment start times to properly calculate your rejuvenation period."
        static let  noResultMessage = "No results. Try searching for your food by name or tap + to add it manually"
        static let  userNamePasswordNotCorrectMessage = "Username or Password is not correct, Logging the user out"
        static let  verificationNotMatchedMessage = "The verification code you entered does not match"
        static let  doubleCheckMessage = "Double check that you have entered the code exactly as it appears."
        static let  deleteImageMessage = "Could not delete image."
        static let  imageNotAvailableMessage = "Image not available."
        static let  valueNotEdited = "This value cannot be edited."
        static let  activityDeletedMessage =  "Activity has been deleted."
        static let  emailNotValid = "email is not valid."
        static let  clearMessage = "Self-reported weights and measurements have been cleared from your account."
        static let  confirmationCodeEmptyMessage = "Confirmation code cannot be empty."
        static let  enterResetCodeMessage = "Please enter the reset code."
        static let  countryCodeEmptyMessage = "Country cannot be empty."
        static let  addedTextMesage = "Added!"
        static let  updatedTextMesage = "Updated!"
        static let  locationMarkerMessage = "Tap the location marker button or search by city or zip code to find your nearest Jenny Craig Center."
        static let  sorryMessage =  "Sorry, we are unable to return center location information at this time. Please call us at 800.536.6922 or visit our website to find a center."
        static let  noJennyCraigCentersMessage = "There are no Jenny Craig Centers within 50 miles of your location. Your area is serviced by Jenny Craig Anywhere. You'll meet our Consultant via phone or video and your food will be delivered."
        static let NoAccess = "Make sure Location Services are turned on from iPhone settings."
        
        static let  connectedMessage =  "Connected"
        static let  notConnectedMessage = "Not connected"
        static let  connectWithHealthMessage = "Connect with Health app to view personal activity data achieved during your workouts."
        static let  connectWithfitbitMessage =  "Connect with Fitbit to view personal activity data achieved during your workouts."
        static let  connected = "You are connected!"
        static let  connectHealthApp = "connect health app"
        static let  contactJennyCareMessage = "We could not locate a DNA Kit associated with your Jenny ID. Please contact JennyCare at 800.536.6922 for assistance."
        static let  goalWeightChanged = "Your goal weight has been changed in the mobile app. Discuss these goals with your consultant."
        static let WeightDeletion = "Are you sure you want to delete the weight on "
        static let startWeightSwipeMessage = "To make edits to this weight, go to Progress and tap Start Weight."
        static let weightreplaceMessage = "Are you sure you want to replace your weight on this day from "
        static let weightGetFromWeightScale = " will be added to today’s scale weight."
        static let alreadyTodayWeightScaleWeightAdded = "There is already a scale weight added today. Do you want to replace "
        static let updateStartWeightMessage = "You are adding a weight on the Start Date. Adding a Weight to this date will update the Start Weight."
        static let wantToSubstituteMessage = "Are you sure you want to substitute your "
        static let atLeast6DigitMessage = "At least 6 characters with a digit"
        static let scaleFoundMessage =  "Jenny Craig Scale Found"
        static let scaleAlreadyPairedMessage =  "This Weight scale is already paired"
    }
}

struct NotificationConstants {
    static let launchNotification = "SampleBitLaunchNotification"
}
