//  CustomExtension.swift
//  JennyCraig
//  Created by Mobileprogrammingllc on 6/20/18.
//  Copyright © 2018 JennyCraig. All rights reserved.

import Foundation
import UIKit

public enum Devices: String {
    case iPodTouch5
    case iPodTouch6
    case iPhone4
    case iPhone4S
    case iPhone5
    case iPhone5C
    case iPhone5S
    case iPhone6
    case iPhone6Plus
    case iPhone6S
    case iPhone6SPlus
    case iPhone7
    case iPhone7Plus
    case iPhone8
    case iPhone8Plus
    case iPhoneX
    case iPhoneXS
    case iPhoneXSMax
    case iPhoneXR
    case iPhoneSE
    case iPad2
    case iPad3
    case iPad4
    case iPad5
    case iPad6
    case iPadAir
    case iPadAir2
    case iPadMini
    case iPadMini2
    case iPadMini3
    case iPadMini4
    case iPadPro97
    case iPadPro129
    case iPadPro105
    case iPadPro11
    case appleTV
    case appleTV4K
    case homePod
    case simulator
    case other
}

extension UIDevice {

    /// pares the deveice name as the standard name
    var modelName: Devices {

        var identifier = ""
        if let dir = ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] {
            identifier = dir
        } else {
            var systemInfo = utsname()
            uname(&systemInfo)
            let machineMirror = Mirror(reflecting: systemInfo.machine)
            identifier = machineMirror.children.reduce("") { identifier, element in
                guard let value = element.value as? Int8, value != 0 else { return identifier }
                return identifier + String(UnicodeScalar(UInt8(value)))
            }

        }

        switch identifier {
        case "iPod5,1":                                 return Devices.iPodTouch5
        case "iPod7,1":                                 return Devices.iPodTouch6
        case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return Devices.iPhone4
        case "iPhone4,1":                               return Devices.iPhone4S
        case "iPhone5,1", "iPhone5,2":                  return Devices.iPhone5
        case "iPhone5,3", "iPhone5,4":                  return Devices.iPhone5C
        case "iPhone6,1", "iPhone6,2":                  return Devices.iPhone5S
        case "iPhone7,2":                               return Devices.iPhone6
        case "iPhone7,1":                               return Devices.iPhone6Plus
        case "iPhone8,1":                               return Devices.iPhone6S
        case "iPhone8,2":                               return Devices.iPhone6SPlus
        case "iPhone9,1", "iPhone9,3":                  return Devices.iPhone7
        case "iPhone9,2", "iPhone9,4":                  return Devices.iPhone7Plus
        case "iPhone8,4":                               return Devices.iPhoneSE
        case "iPhone10,1", "iPhone10,4":                return Devices.iPhone8
        case "iPhone10,2", "iPhone10,5":                return Devices.iPhone8Plus
        case "iPhone10,3", "iPhone10,6":                return Devices.iPhoneX
        case "iPhone11,2":                              return Devices.iPhoneXS
        case "iPhone11,4", "iPhone11,6":                return Devices.iPhoneXSMax
        case "iPhone11,8":                              return Devices.iPhoneXR
        case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":return Devices.iPad2
        case "iPad3,1", "iPad3,2", "iPad3,3":           return Devices.iPad3
        case "iPad3,4", "iPad3,5", "iPad3,6":           return Devices.iPad4
        case "iPad4,1", "iPad4,2", "iPad4,3":           return Devices.iPadAir
        case "iPad5,3", "iPad5,4":                      return Devices.iPadAir2
        case "iPad6,11", "iPad6,12":                    return Devices.iPad5
        case "iPad7,5", "iPad7,6":                      return Devices.iPad6
        case "iPad2,5", "iPad2,6", "iPad2,7":           return Devices.iPadMini
        case "iPad4,4", "iPad4,5", "iPad4,6":           return Devices.iPadMini2
        case "iPad4,7", "iPad4,8", "iPad4,9":           return Devices.iPadMini3
        case "iPad5,1", "iPad5,2":                      return Devices.iPadMini4
        case "iPad6,3", "iPad6,4":                      return Devices.iPadPro97
        case "iPad6,7", "iPad6,8":                      return Devices.iPadPro129
        case "iPad7,1", "iPad7,2":                      return Devices.iPadPro129   //"iPad Pro (12.9-inch) (2nd generation)"
        case "iPad7,3", "iPad7,4":                      return Devices.iPadPro105
        case "iPad8,1", "iPad8,2", "iPad8,3", "iPad8,4":return Devices.iPadPro11
        case "iPad8,5", "iPad8,6", "iPad8,7", "iPad8,8":return Devices.iPadPro129 //"iPad Pro (12.9-inch) (3rd generation)"
        case "AppleTV5,3":                              return Devices.appleTV
        case "AppleTV6,2":                              return Devices.appleTV4K
        case "AudioAccessory1,1":                       return Devices.homePod
        case "i386", "x86_64":                          return Devices.simulator
        default:                                        return Devices.other
        }
    }
}

extension UIApplication {
    class func topViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }

    static var appVersion: String? {
            return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
    }
}

extension UITextField {

    func setBottomLine(borderColor: UIColor) {

        self.borderStyle = UITextField.BorderStyle.none
        self.backgroundColor = UIColor.clear

        let borderLine = UIView()
        let height = 1.0
        borderLine.frame = CGRect(x: 0, y: Double(self.frame.height) - height, width: Double(self.frame.width), height: height)

        borderLine.backgroundColor = borderColor
        self.addSubview(borderLine)
    }

    func addInputViewDatePicker(target: Any, selector: Selector) {

        let screenWidth = UIScreen.main.bounds.width

        //Add DatePicker as inputView
        let datePicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 216))
        datePicker.datePickerMode = .date
        datePicker.maximumDate = Date()
        self.inputView = datePicker
        if #available(iOS 14.0, *) {
            datePicker.preferredDatePickerStyle = .wheels
        }
        //Add Tool Bar as input AccessoryView
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 44))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelBarButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelPressed))
        let doneBarButton = UIBarButtonItem(title: "Done", style: .plain, target: target, action: selector)
        toolBar.setItems([cancelBarButton, flexibleSpace, doneBarButton], animated: false)

        self.inputAccessoryView = toolBar
    }

    @objc func cancelPressed() {
        self.resignFirstResponder()
    }
}

extension NSLayoutConstraint {
    /**
     Change multiplier constraint
     
     - parameter multiplier: CGFloat
     - returns: NSLayoutConstraint
     */
    func setMultiplier(multiplier: CGFloat) -> NSLayoutConstraint {

        NSLayoutConstraint.deactivate([self])

        let newConstraint = NSLayoutConstraint(
            item: firstItem!,
            attribute: firstAttribute,
            relatedBy: relation,
            toItem: secondItem,
            attribute: secondAttribute,
            multiplier: multiplier,
            constant: constant)

        newConstraint.priority = priority
        newConstraint.shouldBeArchived = self.shouldBeArchived
        newConstraint.identifier = self.identifier

        NSLayoutConstraint.activate([newConstraint])
        return newConstraint
    }
}

extension String {

    func isValidEmail() -> Bool {
        let regex = try? NSRegularExpression(pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", options: .caseInsensitive)
        return regex!.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
    }
        func isValidphoneNumber(value: String) -> Bool {
            let phoneRegex = "^\\d{3}-\\d{3}-\\d{4}$"
            let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
            let result = phoneTest.evaluate(with: value)
            return result
        }
    func isValidThreeDigitText(value: String) -> Bool {
    var result = true
    let disallowedCharacterSet = NSCharacterSet(charactersIn: "0123456789").inverted
    let replacementStringIsLegal = value.rangeOfCharacter(from: disallowedCharacterSet) == nil
    let resultingStringLengthIsLegal = value.count <= 3
    result = replacementStringIsLegal && resultingStringLengthIsLegal
    return result
    }
    func isValidFiveDigitText(value: String) -> Bool {
       var result = true
       let disallowedCharacterSet = NSCharacterSet(charactersIn: "0123456789").inverted
       let replacementStringIsLegal = value.rangeOfCharacter(from: disallowedCharacterSet) == nil
       let resultingStringLengthIsLegal = value.count <= 5
       result = replacementStringIsLegal && resultingStringLengthIsLegal
       return result
       }
    func isValidSixDigitText(value: String) -> Bool {
          var result = true
          let disallowedCharacterSet = NSCharacterSet(charactersIn: "0123456789").inverted
          let replacementStringIsLegal = value.rangeOfCharacter(from: disallowedCharacterSet) == nil
          let resultingStringLengthIsLegal = value.count <= 6
          result = replacementStringIsLegal && resultingStringLengthIsLegal
          return result
          }
    func isValidThreeDigitWithDot(value: String) -> Bool {

        let regex = "\\d{0,3}(\\.\\d{0,2})?"
        let distanceTest = NSPredicate(format: "SELF MATCHES %@", regex)
        let result = distanceTest.evaluate(with: value)
        return result
    }
    func isValidFourDigitWithDot(value: String) -> Bool {

        let regex = "\\d{0,4}(\\.\\d{0,2})?"
        let distanceTest = NSPredicate(format: "SELF MATCHES %@", regex)
        let result = distanceTest.evaluate(with: value)
        return result
    }

    func isValidWeightCount() -> Bool {
  
        let weightRegex = "\\d{0,3}(\\.\\d{0,1})?"
        return NSPredicate(format: "SELF MATCHES %@", weightRegex).evaluate(with: self)
       
    }
    var isEmptyOrWhitespace: Bool {
        return self.trimmingCharacters(in: .whitespaces).isEmpty
    }

    func removingWhitespaces() -> String {
        return components(separatedBy: .whitespaces).joined()
    }

    var trimmingTrailingSpaces: String {
        if let range = rangeOfCharacter(from: .whitespacesAndNewlines, options: [.anchored, .backwards]) {
            return String(self[..<range.lowerBound]).trimmingTrailingSpaces
        }
        return self
    }

    func isPasswordValid() -> Bool {
        let passwordRegex = "^(?=.*[0-9]).{6,20}$"
        return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: self)
    }
    func isValidLessThenTwentyDigit(value: String) -> Bool {
        if value.count > 20{
            return false
        }else{
            return true
        }
    }
        func isValidLessThenSixDigit(value: String) -> Bool {
               if value.count > 6{
                   return false
               }else{
                   return true
               }
    }
/*
    func convertToActualDay() -> String {

        if self.isEmpty || self == "---" {
            return self
        }

        let array = self.components(separatedBy: " ")
        let str = array[1]
        var number: Int = Int(str)!
        if number > 7 {
            if number > 7 && number < 15 {
                number -=  7
            } else if number >= 15 && number < 22 {
                number -= 14
            } else if number >= 22 {
                number -= 21
            }
            let str = "Day " + String(describing: number)
            return str
        }
        return self
    }*/
    // Added Condition for Week 5 Pumpkin days
    func convertToActualDay() -> String {

        if self.isEmpty || self == "---" {
            return self
        }

        let array = self.components(separatedBy: " ")
        let str = array[1]
        var number: Int = Int(str)!
        if number > 7 {
            if number > 7 && number < 15 {
                number -=  7
            } else if number >= 15 && number < 22 {
                number -= 14
            } else if number >= 22  && number < 29 {
                number -= 21
            } else if number >= 29 {
                 number -= 28
            }
            let str = "Day " + String(describing: number)
            return str
        }
        return self
    }

    func getSubString(needle: String, beforeNeedle: Bool = false) -> String? {
        guard let range = self.range(of: needle) else { return self }

        if beforeNeedle {
            return self.substring(to: range.lowerBound)
        }

        return self.substring(from: range.upperBound)
    }

    func contains(_ find: String) -> Bool {
        return self.range(of: find) != nil
    }

    func containsIgnoringCase(_ find: String) -> Bool {
        return self.range(of: find, options: .caseInsensitive) != nil
    }

    func deletePrefix(_ prefix: String) -> String {
        guard self.hasPrefix(prefix) else { return self }
        return String(self.dropFirst(prefix.count))
    }

    func getSetDateForNourishment() -> String {
        if self == "" {
            return ""
        } else {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale?
            let startCalorieDate = dateFormatter.date(from: self)
            let stringDate = dateFormatter.string(from: startCalorieDate!)

            let fullName: String = stringDate
            let fullNameArr = fullName.components(separatedBy: " ")
            let fullNameArr2 = fullNameArr[1].components(separatedBy: ":")

            let dateAsString = fullNameArr2[0]+":"+fullNameArr2[1]
            let dateFormatter1 = DateFormatter()
            dateFormatter1.dateFormat = "HH:mm"

            if let date = dateFormatter1.date(from: dateAsString) {
                dateFormatter1.dateFormat = "h:mm a"
                let dateString = dateFormatter1.string(from: date)
                return dateString
            }
            return ""
        }

    }

    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)

        return ceil(boundingBox.height)
    }

    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)

        return ceil(boundingBox.width)
    }

    func encode() -> String {
        let data = self.data(using: .nonLossyASCII, allowLossyConversion: true)!
        return String(data: data, encoding: .utf8)!
    }

    func decode() -> String? {
        let data = self.data(using: .utf8)!
        return String(data: data, encoding: .nonLossyASCII)
    }

    func customGroceryTitle() -> String {

        if self.containsIgnoringCase("Protein") {
            return "proteins"
        } else if self.containsIgnoringCase("Fruit") {
            return "fruits"
        } else if self.containsIgnoringCase("Vegetable") {
            return "non-starchy vegetables"
        } else if self.containsIgnoringCase("Fats") {
            return "healthy fats"
        } else if self.containsIgnoringCase("Milk") {
            return "milks"
        } else if self.containsIgnoringCase("Starch") {
            return "starch"
        }
        return ""
    }

    func isLimitedFood() -> Bool {
        return self.containsIgnoringCase("limited") ? true : false
    }

    func isGroceryFood() -> Bool {
        return self.containsIgnoringCase("grocery") ? true : false
    }

    func isAdditionalFood() -> Bool {
        return self.containsIgnoringCase("foodDB_add") ? true : false
    }

    func fromBase64() -> String? {
        guard let data = Data(base64Encoded: self, options: Data.Base64DecodingOptions(rawValue: 0)) else {
            return nil
        }

        return String(data: data as Data, encoding: String.Encoding.utf8)
    }

    func toBase64() -> String? {
        guard let data = self.data(using: String.Encoding.utf8) else {
            return nil
        }

        return data.base64EncodedString(options: Data.Base64EncodingOptions(rawValue: 0))
    }

}

extension UIView {

    public enum BorderPlace {
        case top
        case bottom
        case right
        case left
    }

    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }

    func addBorderWithColor(color: UIColor, width: CGFloat, place: BorderPlace = .top) {
        let border = CALayer()
        border.backgroundColor = color.cgColor

        switch place {

        case .bottom:
            border.frame = CGRect(x: 0, y: self.frame.size.height - width, width: self.frame.size.width + 50, height: width)

        case .left:
            border.frame = CGRect(x: 0, y: 0, width: width, height: self.frame.size.height)

        case .right:
            border.frame = CGRect(x: self.frame.size.width - width, y: 0, width: width, height: self.frame.size.height)

        default:
            border.frame = CGRect(x: 0, y: 0, width: self.frame.size.width + 50, height: width)
        }
        self.layer.addSublayer(border)
    }

    func addConstraintsWithFormatString(formate: String, views: UIView...) {

        var viewsDictionary = [String: UIView]()

        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewsDictionary[key] = view
        }

        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: formate, options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: viewsDictionary))

    }

    func takeScreenshot() -> UIImage {

        // Begin context
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, UIScreen.main.scale)

        // Draw view in that context
        drawHierarchy(in: self.bounds, afterScreenUpdates: true)

        // And finally, get image
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        if (image != nil) {
            return image!
        }
        return UIImage()
    }

}

extension Array {
    func chunked(into size: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }

    //This method check if a date array contains specific date only by comparing the day of date.
    func containsDate(date: Date) -> Bool {

        if self.count < 1 {
            return false
        }
         for number in 0...self.count {

            let order = Calendar.current.compare((self[number] as? Date)!, to: date, toGranularity: .day)
            if order == .orderedSame {
                return true
            } else {
                if number == self.count - 1 {
                    return false
                } else {
                    continue
                }
            }
        }
        return false
    }

    func filterDuplicates(includeElement: (_ lhs: Element, _ rhs: Element) -> Bool) -> [Element] {
        var results = [Element]()

        forEach { (element) in
            let existingElements = results.filter {
                return includeElement(element, $0)
            }
            if existingElements.count == 0 {
                results.append(element)
            }
        }

        return results
    }

}

extension Array where Element: Equatable {
    mutating func removeFoodItem(_ obj: Element) {
        self = self.filter { $0 != obj }
    }
}

extension UIImage {
    convenience init?(url: URL?, completonHandler: (_ image: UIImage) -> Void ) {
        guard let url = url else { return nil }

        do {
            let data = try Data(contentsOf: url)
            self.init(data: data)
            completonHandler(self)
        } catch {
            jcPrint("Cannot load image from url: \(url) with error: \(error)")
            return nil
        }
    }

}

// MARK: - Tab bar controller selection indicator
extension UIImage {
    func createSelectionIndicator(color: UIColor, size: CGSize, lineWidth: CGFloat) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        UIRectFill(CGRect(x: 0, y: 0, width: size.width, height: lineWidth))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}

extension Int {

    private static var commaFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()

    internal var commaRepresentation: String {
        return Int.commaFormatter.string(from: NSNumber(value: self)) ?? ""
    }
}

extension Double {
    func roundTo(places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}

extension Float {
    func roundTo(places: Int) -> Float {
        let divisor = pow(10.0, Float(places))
        return (self * divisor).rounded() / divisor
    }
}
