//  GlobalFunctions.swift
//  JennyCraig
//  Created by Mobileprogrammingllc on 8/3/18.
//  Copyright © 2018 JennyCraig. All rights reserved.

import UIKit

class GlobalFunctions: NSObject {

    func setNourishmentPeriodOnOff(bool: Bool) {
        UserDefaults.standard.set(bool, forKey: "nourishment")
    }

    func getNourisgmentPeriodOff() -> Bool {
        return UserDefaults.standard.bool(forKey: "nourishment")
    }

    func setRejuvinationPeriodOnOff(bool: Bool) {
        UserDefaults.standard.set(bool, forKey: "rejuvination")
    }

    func getRejuvinationPeriodOff() -> Bool {
        return UserDefaults.standard.bool(forKey: "rejuvination")
    }
}

func getMonth(strDate: String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"

    let date = dateFormatter.date(from: strDate)
    let month =  date?.monthAsNumeric()

    if date != nil {
        return "\(month ?? "")"
    } else {
        return ""
    }
}

func getDay(strDate: String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"

    let date = dateFormatter.date(from: strDate)

    let calendar = Calendar.current
    if date != nil {
        let day = calendar.component(.day, from: date!)
        return "\(day)"
    } else {
        return ""
    }
}

func getDateForDateTextField(strDate: String?) ->Date {
    
    guard let dateValue = strDate else {
        
        return Date()
    }
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"

    let date = dateFormatter.date(from: dateValue)
    let month =  date?.monthAsString()

    let calendar = Calendar.current
    if date != nil {
        let year = calendar.component(.year, from: date!)
        let day = calendar.component(.day, from: date!)
        let components = calendar.dateComponents([.month, .year, .day], from: date ?? Date())
        let finalDate = calendar.date(from: components)
        
        return finalDate!
    }
    
    else {
        
        return Date()
    }
}

func getDateForWeightSection(strDate: String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"

    let date = dateFormatter.date(from: strDate)
    let month =  date?.monthAsString()

    let calendar = Calendar.current
    if date != nil {
        let year = calendar.component(.year, from: date!)
        let day = calendar.component(.day, from: date!)
        let components = calendar.dateComponents([.month, .year, .day], from: date ?? Date())
        let finalDate = calendar.date(from: components)
        return "\(month ?? ""). \(day), \(year)"
    } else {
        return ""
    }
}

func getDateForMeasurement(strDate: String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"

    let date = dateFormatter.date(from: strDate)
    let month =  date?.monthAsString()

    let calendar = Calendar.current
    if date != nil {
        let year = calendar.component(.year, from: date!)
        let day = calendar.component(.day, from: date!)
        return "\(month ?? "") \(day), \(year)"
    } else {
        return ""
    }

}

func getDateForProgressView(strDate: String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"

    let date = dateFormatter.date(from: strDate)
    let month =  date?.monthAsString()

    let calendar = Calendar.current
    _ = calendar.component(.year, from: date!)
    let day = calendar.component(.day, from: date!)

    return "\(day) \(month ?? "")"
}

func getDateFromString(strDate: String) -> Date {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    if let date = dateFormatter.date(from: strDate) {
        return date
    } else {
        return Date()
    }
}

func getDateFromStringWithFormat(strDate: String, format: String) -> Date {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = format
    if let date = dateFormatter.date(from: strDate) {
        return date
    } else {
        return Date()
    }
}
func convertStringintoDate(dateStr:String, format:String) -> Date{
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale.init(identifier:"en_US_POSIX")
    dateFormatter.timeZone = TimeZone.init(abbreviation: "GMT")
    dateFormatter.dateFormat = format
    if let startDate = dateFormatter.date(from: dateStr){
        return startDate as Date
    }
    return Date() as Date
}

func convertDateintoString( date:Date,dateFormat format  : String ) -> String
    {
        let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale.init(identifier:"en_US_POSIX")
    dateFormatter.timeZone = TimeZone.init(abbreviation: "GMT")
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: date)
    }
func getDateInUTC(dateLocal: Date) -> Date {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    let todayDateString = dateFormatter.string(from: dateLocal)
    //    dateFormatter.dateFormat = "h:mm a"
    dateFormatter.calendar = NSCalendar.current
    dateFormatter.timeZone = TimeZone.current

    dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
    //dateFormatter.dateFormat = "H:mm:ss"

    return dateFormatter.date(from: todayDateString)!
}

func getDateDifferenceSinceRejuvenationStarted(calorieTime: String) -> Int {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    if !calorieTime.isEmpty {
        if let dateFirstCalorie = dateFormatter.date(from: calorieTime ) {
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let resultString = dateFormatter.string(from: dateFirstCalorie)
            if let finalDate = dateFormatter.date(from: resultString) {
                return Date().days(from: finalDate )
            } else {
                return  0
            }
        } else {
            return 0
        }
    }
    return 0
}

func jcPrint(_ items: Any...) {
    #if DEBUG
    items.forEach { item in
        Swift.print("✅♥️\(item)")

    }
    #endif
}

func isDeviceOfNotchType() -> Bool {

    return UIApplication.shared.statusBarFrame.size.height > 20 ? true : false
}

func isDeviceSmallerThaniPhone6() -> Bool {

    return UIScreen.main.nativeBounds.height < 1334.0 ? true : false
}
/*
func manipulateArrayForBool(count: Int) {

   /* if JCManager.shared.state == .collapsed {

        if count >= 4 {
            arrayForBool[arrayForBool.count - 1] = true
            arrayForBool[arrayForBool.count - 2] = true
            arrayForBool[arrayForBool.count - 3] = true

            if count == 9 {
                arrayForBool[arrayForBool.count - 4] = false

            } else {
                arrayForBool[arrayForBool.count - 4] = true
            }

            if count == 11 {
                if JCManager.shared.hasRapidResultFeature {

                    arrayForBool[arrayForBool.count - 5] = true
                } else {
                    arrayForBool[arrayForBool.count - 5] = false
                }
            } else {
                if JCManager.shared.hasRapidResultFeature {
                    if count > 4 {
                        arrayForBool[arrayForBool.count - 5] = true
                    }
                }
            }
        }

    } */
    jcPrint("manipulationdone")
}
*/
func getFormattedRejuvenationDuration(timeInterval: TimeInterval) -> String {

    let formatter = DateComponentsFormatter()
    formatter.unitsStyle = .positional
    formatter.allowedUnits = [ .hour, .minute, .second ]
    formatter.zeroFormattingBehavior = [ .pad ]
    return formatter.string(from: timeInterval)!
}

func togglePassword(textField: CustomTextField, sender: UIButton) {

        if sender.tag == 0 {
        textField.leftImage = UIImage(named: "pass_icon-1")
        sender.tag = 1
        textField.isSecureTextEntry = false

    } else {
        textField.leftImage = UIImage(named: "pass_icon_h")
        sender.tag = 0
        textField.isSecureTextEntry = true
    }
}

//For Flurry log event
func convertDictionaryToJSONString(value: AnyObject) -> String {
    if JSONSerialization.isValidJSONObject(value) {
        if let theJSONData = try?  JSONSerialization.data(
            withJSONObject: value,
            options: []
            ),
            let theJSONText = String(data: theJSONData,
                                     encoding: String.Encoding.utf8) {
            let jsonFormattedString = theJSONText.replacingOccurrences(of: "\"", with: "")
            jcPrint(jsonFormattedString)
            return jsonFormattedString
        }
    }
    return ""
}

func isUpdateAvailable() throws -> Bool {

    guard let info = Bundle.main.infoDictionary,

        let currentVersion = info["CFBundleShortVersionString"] as? String,
        let identifier = info["CFBundleIdentifier"] as? String,
        let url = URL(string: "https://itunes.apple.com/lookup?bundleId=\(identifier)") else {
            throw VersionError.invalidBundleInfo
    }
    let data = try Data(contentsOf: url)
    guard let json = try JSONSerialization.jsonObject(with: data, options: [.allowFragments]) as? [String: Any] else {
        throw VersionError.invalidResponse
    }
    if let result = (json["results"] as? [Any])?.first as? [String: Any], let version = result["version"] as? String {
        //return version != currentVersion
        return version > currentVersion
    }
    throw VersionError.invalidResponse
}

func showAlertIfAppUpdateAvailable() {

    if  Bundle.main.infoDictionary?["CFBundleIdentifier"] as? String == Identifiers.ProdAppIdentifier {

        DispatchQueue.global().async {
            do {
                let update = try isUpdateAvailable()
                if update == true {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {

                        let alertController = UIAlertController(title: Identifiers.Message.NewVersionAvailable, message:
                                                                    Identifiers.Message.NewVersionUpdate, preferredStyle: UIAlertController.Style.alert)
                        alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
                            openAppStoreLinkToUpdate()
                        }))
                        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (_: UIAlertAction!) in
                                        if let container = UIApplication.topViewController() {

//                                            if container is JCSelfMonitorViewController || container is JCProgressViewController || container is JCContactViewController || container is JCMoreViewController {
//
//                                                for view in container.view.subviews {
//                                                    if let spinnerView = container.tabBarController?.view.viewWithTag(100000) {
//                                                        spinnerView.removeFromSuperview()
//                                                    }
//                                                }
//
//                                            } else {
                                                for view in container.view.subviews {
                                                    if let spinnerView = container.tabBarController?.view.viewWithTag(100000) {
                                                        spinnerView.removeFromSuperview()
                                                    }
                                                }
                                            //}
                                        }
                        }))

                        if #available(iOS 13.0, *) {
                            UIApplication.shared.keyWindow?.rootViewController!.present(alertController, animated: true, completion: nil)
                        } else {
                            UIApplication.shared.keyWindow?.rootViewController!.present(alertController, animated: true, completion: nil)
                        }
                    }
                }

            } catch {
                print(error)
            }
        }
    }

}

func openAppStoreLinkToUpdate() {
    if let url = URL(string: "https://apps.apple.com/us/app/jenny-craig/id1456159614"),
        UIApplication.shared.canOpenURL(url) {
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
}

func showAlertIfTrackingNotAllowedInFutureDays() {

    let title = Identifiers.Message.cantTrackOnADayInTheFuture
    let alertController = UIAlertController(title: "", message: "", preferredStyle: UIAlertController.Style.alert)
    let messageFont = [NSAttributedString.Key.font: UIFont(name: "SFProText-Bold", size: 17.0)! ]
    let messageAttrString = NSMutableAttributedString(string: title, attributes: messageFont)
    alertController.setValue(messageAttrString, forKey: "attributedMessage")
    alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
    UIApplication.shared.keyWindow?.rootViewController!.present(alertController, animated: true, completion: nil)
}

func showMaintenanceController(message: String) {
    let viewController = UIStoryboard.notCompatibleViewController()
    viewController!.message = message
    if #available(iOS 13.0, *) {
        viewController?.modalPresentationStyle = .fullScreen
    } else {
    }
    Identifiers.APPDELEGATE?.window?.rootViewController?.present(viewController!, animated: true, completion: nil)
}

func boldSearchResult(searchString: String, resultString: String, font: UIFont) -> NSMutableAttributedString {
      let attributedString: NSMutableAttributedString = NSMutableAttributedString(string: resultString)

      guard let regex  = try? NSRegularExpression(pattern: searchString.lowercased(), options: []) else {
          return attributedString
      }

      let range: NSRange = NSRange(location: 0, length: resultString.count)

      regex.enumerateMatches(in: resultString.lowercased(), options: [], range: range) { (textCheckingResult, _, _) in
          guard let subRange = textCheckingResult?.range else {
              return
          }

          attributedString.addAttributes([NSAttributedString.Key.font: UIFont(name: "SFProText-Bold", size: font.pointSize)], range: subRange)
      }

      return attributedString
  }

func timeFormatted(totalSeconds: Int) -> String {
    let seconds: Int = totalSeconds % 60
    let minutes: Int = (totalSeconds / 60) % 60
    let hours: Int = totalSeconds / 3600
    return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
 }

func openSettingAppBle(message: String) {
    
    let alertController = UIAlertController (title: "Jenny Craig", message:message , preferredStyle: .alert)

    let settingsAction = UIAlertAction(title: NSLocalizedString("settings", comment: ""), style: .default) { (_) -> Void in
        let url = URL(string: "App-Prefs:root=General")

        guard let settingsUrl = url else {
            return
        }
        if UIApplication.shared.canOpenURL(settingsUrl) {
            UIApplication.shared.open(settingsUrl, options: [:], completionHandler: nil)
        }
    }

    alertController.addAction(settingsAction)
    let cancelAction = UIAlertAction(title: NSLocalizedString("cancel", comment: ""), style: .default, handler: nil)
    alertController.addAction(cancelAction)
    UIApplication.shared.keyWindow?.rootViewController!.present(alertController, animated: true, completion: nil)
}
func showAlertWhenWeightGetFromScaleMachine(message: String) {
    let title = Identifiers.Message.weightGetFromWeightScale
    let alert = UIAlertController(title: "Jenny Craig", message: message + title, preferredStyle: .alert)
        
         let okButton = UIAlertAction(title: "OK", style: .default, handler: { action in
            
            UIViewController.removeSpinner()
         })
         alert.addAction(okButton)
         let cancel = UIAlertAction(title: "Cancel", style: .default, handler: { action in
            UIViewController.removeSpinner()
         })
         alert.addAction(cancel)
         
            UIApplication.shared.keyWindow?.rootViewController!.present(alert, animated: true, completion: nil)

}
func showToast(message : String, seconds: Double){
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.view.backgroundColor = .black
        alert.view.alpha = 1.0
        alert.view.layer.cornerRadius = 15
    UIApplication.shared.keyWindow?.rootViewController!.present(alert, animated: true, completion: nil)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + seconds) {
            alert.dismiss(animated: true)
        }
    }

/*
func showSaveButtonInToolbarInKeyboardGlobal() {
    let toolBar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 48))
    toolBar.barStyle = UIBarStyle.default
    toolBar.isTranslucent = false
    toolBar.isUserInteractionEnabled = true
    toolBar.barTintColor = .slateBlue
    let barButton = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(self.sendNotificationSaveButton(_:)))
    barButton.tintColor = .white
    toolBar.sizeToFit()
    toolBar.items = [
        UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
        barButton,
        UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)]
       textView.inputAccessoryView = toolBar
}

func sendNotificationSaveButton(){
    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "saveButton"), object: nil, userInfo: nil)
}
*/
