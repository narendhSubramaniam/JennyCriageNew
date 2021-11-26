//  StoryboardExtension.swift
//  JennyCraig
//  Created by Mobileprogrammingllc on 7/9/18.
//  Copyright © 2018 JennyCraig. All rights reserved.

import Foundation
import UIKit

extension UIStoryboard {

    class func mainStoryboard() -> UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }

    class func loginSignStoryboard() -> UIStoryboard {
        return UIStoryboard(name: "LoginSignup", bundle: Bundle.main)
    }

    class func dashboardStoryboard() -> UIStoryboard {
        return UIStoryboard(name: "Dashboard", bundle: Bundle.main)
    }

    class func progressStoryboard() -> UIStoryboard {
        return UIStoryboard(name: "Progress", bundle: Bundle.main)
    }

    class func foodListStoryboard() -> UIStoryboard {
        return UIStoryboard(name: "FoodList", bundle: Bundle.main)
    }

    class func moreStoryboard() -> UIStoryboard {
        return UIStoryboard(name: "More", bundle: Bundle.main)
    }

    class func mainNavigationViewController() -> UINavigationController? {
        return loginSignStoryboard().instantiateViewController(withIdentifier: "JCMainNavigationController") as? UINavigationController
    }

//    class func contactViewController() -> JCContactViewController? {
//        return mainStoryboard().instantiateViewController(withIdentifier: "JCContactViewController") as? JCContactViewController
//    }
//
//    class func imagePopOverController() -> ImagePopOverController? {
//        return mainStoryboard().instantiateViewController(withIdentifier: "kImagePopOverController") as? ImagePopOverController
//    }
//
//    class func emailPdfViewController() -> EmailPdfViewController? {
//        return mainStoryboard().instantiateViewController(withIdentifier: "kEmailPdfViewController") as? EmailPdfViewController
//    }
//
//    class func sharePdfViewController() -> JCSharePdfViewController? {
//        return mainStoryboard().instantiateViewController(withIdentifier: "JCSharePdfViewController") as? JCSharePdfViewController
//    }
//
//    class func excercisePopoverController() -> JCAddExercisePopOverVC? {
//        return mainStoryboard().instantiateViewController(withIdentifier: "kJCAddExercisePopOverVC") as? JCAddExercisePopOverVC
//    }
//
//    class func activityListViewController() -> JCActivityListViewController? {
//        return mainStoryboard().instantiateViewController(withIdentifier: "kJCActivityListViewController") as? JCActivityListViewController
//    }
//
//    class func addEditFoodViewController() -> JCAddEditFoodViewController? {
//        return foodListStoryboard().instantiateViewController(withIdentifier: "JCAddEditFoodViewController") as? JCAddEditFoodViewController
//    }
//
//    class func nutritionViewController() -> JCNutritionViewController? {
//        return foodListStoryboard().instantiateViewController(withIdentifier: "JCNutritionViewController") as? JCNutritionViewController
//    }
//
//    class func addNutritionViewController() -> JCAddNutritionViewController? {
//        return foodListStoryboard().instantiateViewController(withIdentifier: "JCAddNutritionViewController") as? JCAddNutritionViewController
//    }
//
//    class func locatorDetailViewController() -> JCCenterLocatorDetailVC? {
//        return mainStoryboard().instantiateViewController(withIdentifier: "kJCCenterLocatorDetailVC") as? JCCenterLocatorDetailVC
//    }
//
//    class func locatorMainViewController() -> JCCenterLocatorController? {
//        return mainStoryboard().instantiateViewController(withIdentifier: "kJCCenterLocatorMainVC") as? JCCenterLocatorController
//    }
//
//    //old app home navigation when we signup
//    /* class func homeNavigation() -> UINavigationController? {
//     return dashboardStoryboard().instantiateViewController(withIdentifier: "homeNavigation") as? UINavigationController
//     }*/
//
//    //New tabbar app home navigation when we signup
//    class func homeNavigation() -> JCCustomTabBarViewController? {
//        return dashboardStoryboard().instantiateViewController(withIdentifier: "JCCustomTabBarViewController") as? JCCustomTabBarViewController
//    }
//
//    class func selMonitorNavigation() -> JCNavigationController? {
//        return dashboardStoryboard().instantiateViewController(withIdentifier: "selfMonitorNavigation") as? JCNavigationController
//    }

    class func progressNavigation() -> UINavigationController? {
        return progressStoryboard().instantiateViewController(withIdentifier: "progressNavigation") as? UINavigationController
    }


    class func moreNavigation() -> UINavigationController? {
        return moreStoryboard().instantiateViewController(withIdentifier: "moreNavigation") as? UINavigationController
    }

//    class func updateEmailPasswordController() -> JCUpdateEmailPasswordVC? {
//        return moreStoryboard().instantiateViewController(withIdentifier: "JCUpdateEmailPasswordVC") as? JCUpdateEmailPasswordVC
//    }
//
//    class func jcMilestoneAnimation() -> JCMilestoneAnimationVC? {
//        return mainStoryboard().instantiateViewController(withIdentifier: "JCMilestoneAnimationVC") as? JCMilestoneAnimationVC
//    }

    class func profileCreator() -> JCCreateProfileController? {
        return loginSignStoryboard().instantiateViewController(withIdentifier: "JCCreateProfileController") as? JCCreateProfileController
    }

    class func forgotPasswordVC() -> JCForgotPasswordController? {
        return loginSignStoryboard().instantiateViewController(withIdentifier: "JCForgotPasswordController") as? JCForgotPasswordController
    }
    class func loginSignUpVC() -> JCLoginSignUpContainerController? {
        return loginSignStoryboard().instantiateViewController(withIdentifier: "JCLoginSignUpContainerController") as? JCLoginSignUpContainerController
    }
    class func emailAlreadyExistVC() -> JCEmailAlreadyExistVC? {
          return loginSignStoryboard().instantiateViewController(withIdentifier: "JCEmailAlreadyExistVC") as? JCEmailAlreadyExistVC
      }

    
    class func resetPasswordVC() -> JCPasswordResetController? {
        return loginSignStoryboard().instantiateViewController(withIdentifier: "JCPasswordResetController") as? JCPasswordResetController
    }

    class func accountInfoController() -> JCAccountInfoController? {
        return loginSignStoryboard().instantiateViewController(withIdentifier: "JCAccountInfoController") as? JCAccountInfoController
    }

    class func confirmEmailController() -> JCConfirmEmailController? {
        return loginSignStoryboard().instantiateViewController(withIdentifier: "JCConfirmEmailController") as? JCConfirmEmailController
    }

    class func privacyPolicyViewController() -> JCTermsConditionsViewController? {
        return loginSignStoryboard().instantiateViewController(withIdentifier: "JCTermsConditionsViewController") as? JCTermsConditionsViewController
    }

    class func noInternetViewController() -> NoInternetViewController? {
        return mainStoryboard().instantiateViewController(withIdentifier: "NoInternetViewController") as? NoInternetViewController
    }

    class func notCompatibleViewController() -> NotCompatibleViewController? {
        return mainStoryboard().instantiateViewController(withIdentifier: "NotCompatibleViewController") as? NotCompatibleViewController
    }
    class func signInViewController() -> JCSignInViewController? {
        return loginSignStoryboard().instantiateViewController(withIdentifier: "JCSignInViewController") as? JCSignInViewController
    }

//    class func substituteViewController() -> JCSubstituteViewController? {
//           return dashboardStoryboard().instantiateViewController(withIdentifier: "JCSubstituteViewController") as? JCSubstituteViewController
//       }
//
//    class func substitutePopupViewController() -> JCSubstitutePopupViewController? {
//        return mainStoryboard().instantiateViewController(withIdentifier: "JCSubstitutePopupViewController") as? JCSubstitutePopupViewController
//    }
//
//    class func calorieBannerPopupViewController() -> JCCalorieBannerPopupViewController? {
//        return mainStoryboard().instantiateViewController(withIdentifier: "JCCalorieBannerPopupViewController") as? JCCalorieBannerPopupViewController
//    }
//
//    class func moreViewController() -> JCMoreViewController? {
//        return dashboardStoryboard().instantiateViewController(withIdentifier: "JCMoreViewController") as? JCMoreViewController
//    }
//
//    class func selfMonitorViewController() -> JCSelfMonitorViewController? {
//        return dashboardStoryboard().instantiateViewController(withIdentifier: "JCSelfMonitorViewController") as? JCSelfMonitorViewController
//    }
//
//    class func pickerViewController() -> JCPickerViewController? {
//        return dashboardStoryboard().instantiateViewController(withIdentifier: "JCPickerViewController") as? JCPickerViewController
//    }
//    class func selectDateViewController() -> JCSelectDateViewController? {
//          return dashboardStoryboard().instantiateViewController(withIdentifier: "JCSelectDateViewController") as? JCSelectDateViewController
//      }
//
//    class func measurmentViewController() -> JCMeasurmentViewController? {
//        return dashboardStoryboard().instantiateViewController(withIdentifier: "kJCMeasurmentViewController") as? JCMeasurmentViewController
//    }
//
//    class func popoverMeasurementsController() -> JCMeasurementsPopoverVC? {
//        return dashboardStoryboard().instantiateViewController(withIdentifier: "kJCMeasurementsPopoverVC") as? JCMeasurementsPopoverVC
//    }
//
//    class func shortCutViewController() -> ShortCutViewController? {
//        return dashboardStoryboard().instantiateViewController(withIdentifier: "ShortCutViewController") as? ShortCutViewController
//    }
//
//    class func customOverlayViewController() -> CustomOverlayViewController? {
//        return dashboardStoryboard().instantiateViewController(withIdentifier: "CustomOverlayViewController") as? CustomOverlayViewController
//    }
//
//    class func weightPopoverVC() -> JCWeightPopoverVC? {
//        return dashboardStoryboard().instantiateViewController(withIdentifier: "kJCWeightPopoverVC") as? JCWeightPopoverVC
//    }
//
//    class func dnaResultController() -> JCDNAResultController? {
//        return moreStoryboard().instantiateViewController(withIdentifier: "JCDNAResultController") as? JCDNAResultController
//    }
//
//    class func lifeCycleWeightController() -> JCLifeCycleWeightViewController? {
//        return moreStoryboard().instantiateViewController(withIdentifier: "JCLifeCycleWeightViewController") as? JCLifeCycleWeightViewController
//    }
///*
//    class func freshFreeFoodController() -> JCFreshViewController? {
//        return moreStoryboard().instantiateViewController(withIdentifier: "JCFreshViewController") as? JCFreshViewController
//    }*/
//
//    class func appConnectViewController() -> JCAppConnectViewController? {
//        return moreStoryboard().instantiateViewController(withIdentifier: "JCAppConnectViewController") as? JCAppConnectViewController
//    }
//
//    class func appleHealthAlertController() -> JCAppleHealthAlertController? {
//        return moreStoryboard().instantiateViewController(withIdentifier: "JCAppleHealthAlertController") as? JCAppleHealthAlertController
//    }
//
//    class func appsDeviceViewController() -> JCAppsDeviceViewController? {
//        return moreStoryboard().instantiateViewController(withIdentifier: "JCAppsDeviceViewController") as? JCAppsDeviceViewController
//    }
//    /*
//    class func weightScaleRegister() -> JCWeightScaleRegisterVC? {
//        return moreStoryboard().instantiateViewController(withIdentifier: "JCWeightScaleRegisterVC") as? JCWeightScaleRegisterVC
//    }
//    class func weightScaleConfirmation() -> JCWeightConfirmationVC? {
//        return moreStoryboard().instantiateViewController(withIdentifier: "JCWeightConfirmationVC") as? JCWeightConfirmationVC
//    }
//*/
//    class func gettingStartedController() -> JCGettingStartedViewController? {
//        return moreStoryboard().instantiateViewController(withIdentifier: "JCGettingStartedViewController") as? JCGettingStartedViewController
//    }
//
//    class func pdfResultViewController() -> JCPDFResultViewController? {
//        return moreStoryboard().instantiateViewController(withIdentifier: "JCPDFResultViewController") as? JCPDFResultViewController
//    }
//
//    class func menuOverlay() -> JCMenuOverlay? {
//        return dashboardStoryboard().instantiateViewController(withIdentifier: "JCMenuOverlay") as? JCMenuOverlay
//    }
//
//    class func foodOverlay() -> JCFoodOverlay? {
//        return foodListStoryboard().instantiateViewController(withIdentifier: "JCFoodOverlay") as? JCFoodOverlay
//    }
//
//    class func addWaterViewController() -> JCAddWaterViewController? {
//        return dashboardStoryboard().instantiateViewController(withIdentifier: "JCAddWaterViewController") as? JCAddWaterViewController
//    }
//
//    class func editMotivationViewController() -> JCEditMotivationViewController? {
//        return dashboardStoryboard().instantiateViewController(withIdentifier: "JCEditMotivationViewController") as? JCEditMotivationViewController
//    }
//    class func editNotesViewController() -> JCEditNotesViewController? {
//        return dashboardStoryboard().instantiateViewController(withIdentifier: "JCEditNotesViewController") as? JCEditNotesViewController
//    }
//    
//    
//    class func substitutionOverlay() -> JCSubstitutionOverlay? {
//         return dashboardStoryboard().instantiateViewController(withIdentifier: "JCSubstitutionOverlay") as? JCSubstitutionOverlay
//     }
//    class func addddExerciseToLogController() -> JCAddExerciseToLogVC? {
//        return mainStoryboard().instantiateViewController(withIdentifier: "kJCAddExerciseToLogVC") as? JCAddExerciseToLogVC
//    }
//
//    class func progressViewController() -> JCProgressViewController? {
//        return progressStoryboard().instantiateViewController(withIdentifier: "JCProgressViewController") as? JCProgressViewController
//    }
}
