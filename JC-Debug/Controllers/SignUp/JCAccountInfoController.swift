//
//  JCAccountInfoController.swift
//  JennyCraig
//
//  Created by Mobileprogrammingllc on 6/25/18.
//  Copyright © 2018 JennyCraig. All rights reserved.
//

import UIKit
import AWSCognitoIdentityProvider

class JCAccountInfoController: UIViewController, UITextViewDelegate {

    // MARK: - IBOutlets
    @IBOutlet weak var startingWeightTextField: CustomTextField!
    @IBOutlet weak var goalWeightTextField: CustomTextField!
    
    @IBOutlet weak var startingDateTextField: CustomTextField! {
        didSet {
            startingDateTextField.addInputViewDatePicker(target: self, selector: #selector(doneButtonPressed))
        }
    }
    @IBOutlet weak var firstNameTextField: CustomTextField!
    @IBOutlet weak var lastNameTextField: CustomTextField!
    @IBOutlet weak var emailTextField: CustomTextField!
    @IBOutlet weak var countryTextField: CustomTextField!
    @IBOutlet weak var phoneTextField: CustomTextField! {
        didSet {
            self.phoneTextField.delegate = self
        }
    }

    var timeStampForResetGoal = ""
    var newsLetterValue = 0
    @IBOutlet weak var viewGoalWeight: UIView!
    @IBOutlet weak var viewStartWeight: UIView!
    @IBOutlet weak var viewStartDate: UIView!
    @IBOutlet weak var upperShadowView: UIView!
    @IBOutlet weak var checkBoxView: UIView!
    @IBOutlet weak var countryPopup: UIView!
    @IBOutlet weak var countryView: UIView!
    @IBOutlet weak var phoneView: UIView!
    
    @IBOutlet weak var goalWeightLabel: UILabel!
    @IBOutlet weak var startWeightLabel: UILabel!
    @IBOutlet weak var startDateLabel: UILabel!
    @IBOutlet weak var placeHolderLabel: UILabel!
    @IBOutlet weak var requiredLabel: UILabel!


    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var checkBoxBtn: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var countryButton: UIButton!
    
    var selectedCountry = ""
 
    var goalWeightValue = ""
    var dateFormatter = DateFormatter()
    var dateFormatterForResetGoal = DateFormatter()
    var tapGesture = UITapGestureRecognizer()
    //FOR VIEW ENABLE DISABLE
 
    var viewModel = SignUpViewModel()
    var signInModel: SignInModel?
    var jennyID = ""
    private var validator = Validator()
    weak var containerDelegate: UpdateContainerViewDelegate?
   // private var resetGoalViewModel: ResetGoalViewModel!

    // AWS
    var pool: AWSCognitoIdentityUserPool?
    var passwordAuthenticationCompletion: AWSTaskCompletionSource<AWSCognitoIdentityPasswordAuthenticationDetails>?

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // self.placeholderTextView()
        self.validateTextFields()
        self.hideKeyboard()
        self.setUpHandler()
        self.pool = AWSCognitoIdentityUserPool.init(forKey: Identifiers.AWSCognitoUserPoolsSignInProviderKey)
        self.checkBoxBtn.isEnabled = false
        fillData()

        self.startingWeightTextField.becomeFirstResponder()

        dateFormatterForResetGoal.dateFormat = Identifiers.yyyyMMddFormatter
        timeStampForResetGoal = dateFormatterForResetGoal.string(from: Date())
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if isResetGoal {
            signUpButton.setTitle("CONFIRM", for: .normal)

            if firstNameForClearTracking.count > 0 || lastNameForClearTracking.count > 0 || emailForClearTracking.count > 0 {
                firstNameTextField.text = firstNameForClearTracking
                lastNameTextField.text =  lastNameForClearTracking
                emailTextField.text = emailForClearTracking
            }

            //if user comes from clear tracking disable the options
            countryView.isUserInteractionEnabled = false
            phoneView.isUserInteractionEnabled = false
            checkBoxView.isUserInteractionEnabled = false
            startingWeightTextField.resignFirstResponder()
        } else {
            backButton.isHidden = false
            signUpButton.setTitle("SIGN UP", for: .normal)

            //if user comes from registration process enable the options
            countryView.isUserInteractionEnabled = true
            phoneView.isUserInteractionEnabled = true
            checkBoxView.isUserInteractionEnabled = true
        }

        dateFormatterForResetGoal.dateFormat = Identifiers.yyyyMMddFormatter
        timeStampForResetGoal = dateFormatterForResetGoal.string(from: Date())
    }

    override func viewWillDisappear(_ animated: Bool) {

        super.viewWillDisappear(animated)
        view.endEditing(true)
        validator.unregisterAllField()
    }
    // MARK: - Action method
    @IBAction func buttonBackAction(_ sender: Any) {

        //send user to account infoi page 1
        if let nav  = self.navigationController?.viewControllers {
            if let createProfileVC = nav[1] as? JCCreateProfileController {
                self.navigationController?.popToViewController(createProfileVC, animated: true)
            } else {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent //.default for black style
    }

    @IBAction func readMoreAction(_ sender: Any) {
        let privacyVC = UIStoryboard.privacyPolicyViewController()
        if #available(iOS 13.0, *) {
            privacyVC?.modalPresentationStyle = .fullScreen
        } else {
        }
        self.present(privacyVC!, animated: true, completion: nil)
    }

    @IBAction func receiveNotificationButtonAction(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected

        if sender.isSelected {
            newsLetterValue = 1
        } else {
            newsLetterValue = 0
        }

    }
    @IBAction func countryPopupShow(_ sender: UIButton) {
        self.view.endEditing(true)
        countryPopup.isHidden = !countryPopup.isHidden
    }
    @IBAction func countrySelect(_ sender: UIButton) {
        countryPopup.isHidden = true
        countryButton.setTitle(sender.titleLabel?.text, for: .normal)
    }
    @IBAction func action_SignUp(_ sender: UIButton) {
        if  isChecked == true {
            UserDefaults.standard.set(emailTextField.text, forKey: "userName")
        }
        if !Reachability.isConnectedToNetwork() {
            /*self.popupAlert(title: "", message: Identifiers.Message.NoInternetConnectivity, actionTitles: ["Ok"], actions: [ {action1 in
             }, nil])*/
            return
        }

        if sender.titleLabel?.text?.uppercased() == "SIGN UP" {
            view.endEditing(true)
            validator.validate(self)
        } else {
            //call for Reset goal
            view.endEditing(true)
            validator.validate(self)
        }
    }


    // MARK: Functions
    @objc func doneButtonPressed() {
        if let  datePicker = self.startingDateTextField.inputView as? UIDatePicker {

            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM-dd-yyyy"
            self.startingDateTextField.text = dateFormatter.string(from: datePicker.date)
            dateFormatterForResetGoal.dateFormat = Identifiers.yyyyMMddFormatter
            timeStampForResetGoal = dateFormatterForResetGoal.string(from: datePicker.date)
        }
        self.startingDateTextField.resignFirstResponder()
    }

    func fillData() {

        if let model = self.signInModel?.profileInfo {
            for dict in model {
                if dict.keyName == "emailId" {
                    emailTextField.text = dict.keyValue ?? ""
                    emailTextField.isUserInteractionEnabled = dict.editable == 1 ? true : false

                } else if dict.keyName == "firstName" {
                    firstNameTextField.text = dict.keyValue ?? ""
                    firstNameTextField.isUserInteractionEnabled = dict.editable == 1 ? true : false

                } else if dict.keyName == "lastName" {
                    lastNameTextField.text = dict.keyValue ?? ""
                    lastNameTextField.isUserInteractionEnabled = dict.editable == 1 ? true : false

                } else if dict.keyName == "phone" {

                    //if dict.editable == 0 {
                    if dict.keyValue != nil {
                        let components = dict.keyValue?.components(separatedBy: NSCharacterSet.decimalDigits.inverted)
                        let decimalString = components?.joined(separator: "") as! NSString
                        let length = decimalString.length
                        _ = length > 0
                        //&& decimalString.hasPrefix("1")

                        /*if length == 0 || (length > 10 && !hasLeadingOne) || length > 10 {
                         let newLength = (textField.text! as NSString).length + (string as NSString).length - range.length as Int
                         
                         return (newLength > 10) ? false : true
                         } */
                        var index = 0 as Int
                        let formattedString = NSMutableString()

                        if (length - index) > 3 {
                            let areaCode = decimalString.substring(with: NSRange(location: index, length: 3))
                            formattedString.appendFormat("(%@) ", areaCode)
                            index += 3
                        }
                        if length - index > 3 {
                            let prefix = decimalString.substring(with: NSRange(location: index, length: 3))
                            formattedString.appendFormat("%@-", prefix)
                            index += 3
                        }

                        let remainder = decimalString.substring(from: index)
                        formattedString.append(remainder)
                        phoneTextField.text = formattedString as String
                        //                    } else {
                        //                        phoneTextField.text = dict.keyValue
                        //                    }
                    }
                    phoneTextField.isUserInteractionEnabled = dict.editable == 1 ? true : false
                    self.checkBoxBtn.isEnabled = phoneTextField.text!.count > 0 ? true : false

                    if self.phoneTextField.text!.count > 10 {
                        self.checkBoxBtn.setImage(UIImage(named: "whiteCheckBtn.png"), for: .normal)
                    }

                } else if dict.keyName == "jennyId" {
                    jennyID = dict.keyValue ?? ""

                } else if dict.keyName == "goalWeight" {
                    goalWeightTextField.text = dict.keyValue ?? ""
                    goalWeightValue = goalWeightTextField.text ?? ""
                    goalWeightTextField.isUserInteractionEnabled = dict.editable == 1 ? true : false
                    viewGoalWeight.backgroundColor = dict.editable == 1  ? UIColor.white : .greylightColorwithOpacity
                    goalWeightLabel.text = dict.editable == 1  ? "Goal Weight *" : "Goal Weight"

                } else if dict.keyName == "startingWeight" {
                    startingWeightTextField.text = dict.keyValue ?? ""
                    startingWeightTextField.isUserInteractionEnabled = dict.editable == 1 ? true : false
                    viewStartWeight.backgroundColor = dict.editable == 1  ? UIColor.white : .greylightColorwithOpacity
                    startWeightLabel.text = dict.editable == 1  ? "Start Weight *" : "Start Weight"

                } else if dict.keyName == "startweightdate" {

                    dateFormatter.dateFormat = "MM-dd-yyyy"
                    if let value = dict.keyValue, value != "" {
                        let date = getDateFromString(strDate: dict.keyValue!)
                        self.startingDateTextField.text = dateFormatter.string(from: date)
                    } else {
                        self.startingDateTextField.text = dateFormatter.string(from: Date())
                    }

                    startingDateTextField.isUserInteractionEnabled = dict.editable == 1 ? true : false
                    viewStartDate.backgroundColor = dict.editable == 1  ? UIColor.white : .greylightColorwithOpacity
                    startDateLabel.text = dict.editable == 1  ? "Start Date *" : "Start Date"

                }
            }

            if let placeHolderText = self.signInModel?.sonicNot {
                placeHolderLabel.text = placeHolderText == "*Required" ? "" : placeHolderText
                placeHolderLabel.textAlignment =  placeHolderText == "*Required" ? .center : .left
            }

        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @objc func updateStartWeightDateTapped(_ sender: UITapGestureRecognizer) {

        startingWeightTextField.resignFirstResponder()
        goalWeightTextField.resignFirstResponder()
        startingDateTextField.resignFirstResponder()

        let dateComponents = NSDateComponents()
        dateComponents.year = -30

        /*
        viewPicker.isHidden = false
        currentWeightTextField.resignFirstResponder()

        // to set the calendar limit
        let currentCalendar = NSCalendar.current
       
        let yearsFromNow = currentCalendar.date(byAdding: dateComponents as DateComponents, to: Date())
        datePicker.minimumDate = yearsFromNow
        datePicker.maximumDate = Date()
        */
    }

    // MARK: - SetUp Handler
    private func setUpHandler() {

        viewModel.successViewClosure = { [weak self] (response) in
            DispatchQueue.main.async {

                if response.successful == 1 {

                    DispatchQueue.main.async {

                        iswebUser = false
                        do {
                            let emailText = self?.emailTextField.text?.trimmingTrailingSpaces
                            AuthController.setUsername(username: (emailText?.lowercased())!)
                            try AuthController.setPassword(username: ((emailText?.lowercased())!), password: passwordLocalSignup)
                            isRegisterSuccessfully = true
                            Identifiers.APPDELEGATE?.window?.rootViewController = UIStoryboard.dashboardStoryboard().instantiateInitialViewController()
                        } catch {
                            jcPrint("Error signing in: \(error.localizedDescription)")
                        }
                    }
                } else {

                    //show error alert
                    self?.popupAlert(title: "", message: response.message, actionTitles: ["Ok"], actions: [ {action1 in
                        }, nil])
                }

            }
        }

        viewModel.showAlertClosure = { [weak self] (message) in
            DispatchQueue.main.async {

                UIViewController.removeSpinner()

                //show alert
                self?.popupAlert(title: "", message: message, actionTitles: ["Ok"], actions: [ {action1 in
                    }, nil])
            }
            } as ((String) -> Void)
    }

    //set up view model handler
    private func setUpHandlerForResetGoal() {
//        resetGoalViewModel.successViewClosure = {(serviceType) in            UIViewController.removeSpinner()
//
//            switch serviceType {
//            case .resetGoal:
//                JCManager.shared.cleanUp()
//                Identifiers.APPDELEGATE?.window?.rootViewController = UIStoryboard.homeNavigation()
//            }
//        }
//
//        self.resetGoalViewModel.showAlertClosure = { [weak self] (message) in
//            DispatchQueue.main.async {
//                UIViewController.removeSpinner()
//                self?.popupAlert(title: "", message: message, actionTitles: ["Ok"], actions: [ {action1 in
//                    }, nil])
//            }
//            } as ((String) -> Void)
    }

    func resetGoalPressed() {

        if !Reachability.isConnectedToNetwork() {
            /*self.popupAlert(title: "", message: Identifiers.Message.NoInternetConnectivity, actionTitles: ["Ok"], actions: [ {action1 in
             }, nil])*/
            return
        }

//        resetGoalViewModel = ResetGoalViewModel()
//        self.setUpHandlerForResetGoal()
//        UIViewController.displaySpinner()
//        resetGoalViewModel.getResetGoal(timeStamp: timeStampForResetGoal, startingWeight: self.startingWeightTextField.text!, goalWeight: self.goalWeightTextField.text!, startingWeightDate: timeStampForResetGoal)
    }

}

// MARK: - Extensions
extension JCAccountInfoController: ValidationDelegate, UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        countryPopup.isHidden = true
        validator.validateField(textField) { error in
            if error == nil {
                let nextTag = textField.tag + 1
                if let nextResponder = textField.superview?.viewWithTag(nextTag) {
                    nextResponder.becomeFirstResponder()
                } else {
                    textField.resignFirstResponder()
                }
            }
        }
        return true
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == phoneTextField {
            if phoneTextField.text == "" {
                self.checkBoxBtn.isEnabled = false

            } else {
                self.checkBoxBtn.isEnabled = true
                self.checkBoxBtn.setImage(UIImage(named: "whiteCheckBtn.png"), for: .normal)
            }
            let result = validatePhoneNumber(textField: textField, range: range, string: string)
            return result
        }
        if textField == startingWeightTextField ||  textField == goalWeightTextField {
            let result = validateWeight(textField: textField, range: range, string: string)
            return result
        }

        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if phoneTextField.text == "" {
            self.checkBoxBtn.isEnabled = false
        } else {
            self.checkBoxBtn.isEnabled = true
        }
        
        if textField == self.goalWeightTextField  {
            if goalWeightValue.count > 0 && self.goalWeightTextField.text != goalWeightValue {
                self.showAlert(withText: Identifiers.Message.goalWeightChanged)

            }
        }
        
        /*
         if textField == self.goalWeightTextField  {
         if  self.goalWeightTextField.text == ""{
         self.goalWeightTextField.text = self.goalWeightTextField.text!
         }else{
         self.goalWeightTextField.text = self.goalWeightTextField.text! + " lbs"
         }
         
         }else if textField == self.startingWeightTextField{
         if  self.startingWeightTextField.text == ""{
         self.startingWeightTextField.text = self.startingWeightTextField.text!
         }
         else{
         self.startingWeightTextField.text = self.startingWeightTextField.text! + " lbs"
         }
         }
         */
    }

    func validatePhoneNumber(textField: UITextField, range: NSRange, string: String) -> Bool {
        let newString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        let components = newString.components(separatedBy: NSCharacterSet.decimalDigits.inverted)

        let decimalString = components.joined(separator: "") as NSString
        let length = decimalString.length
        let hasLeadingOne = length > 0
        //&& decimalString.hasPrefix("1")

        if length == 0 || (length > 10 && !hasLeadingOne) || length > 10 {
            let newLength = (textField.text! as NSString).length + (string as NSString).length - range.length as Int

            return (newLength > 10) ? false : true
        }
        var index = 0 as Int
        let formattedString = NSMutableString()
        /*
                if hasLeadingOne {
                    formattedString.append("1 ")
                    index += 1
                }
        */
        if (length - index) > 3 {
            let areaCode = decimalString.substring(with: NSRange(location: index, length: 3))
            formattedString.appendFormat("(%@) ", areaCode)
            index += 3
        }
        if length - index > 3 {
            let prefix = decimalString.substring(with: NSRange(location: index, length: 3))
            formattedString.appendFormat("%@-", prefix)
            index += 3
        }

        let remainder = decimalString.substring(from: index)
        formattedString.append(remainder)
        textField.text = formattedString as String
        return false
    }
    func validateWeight(textField: UITextField, range: NSRange, string: String) -> Bool {

        guard let oldText = textField.text, let rangee = Range(range, in: oldText) else {

            return true
        }

        let newText = oldText.replacingCharacters(in: rangee, with: string)
        let isNumeric = newText.isEmpty || (Double(newText) != nil)
        let numberOfDots = newText.components(separatedBy: ".").count - 1

        if numberOfDots == 0 && newText.count > 3 {
            return false
        }
        let numberOfDecimalDigits: Int
        if let dotIndex = newText.index(of: ".") {
            numberOfDecimalDigits = newText.distance(from: dotIndex, to: newText.endIndex)
        } else {
            numberOfDecimalDigits = 0
        }

        return isNumeric && numberOfDots <= 1 && numberOfDecimalDigits <= 2
    }

    //---------------------------------
    // MARK: - Register TextField for Validation
    //---------------------------------

    private func validateTextFields() {

        validator.styleTransformers(success: { (validationRule) -> Void in
            // clear error label
            validationRule.errorLabel?.isHidden = true
            validationRule.errorLabel?.text = ""

        }, error: { (_) -> Void in
            //if any error occur
            self.showAlert(withText: Identifiers.Message.CompleteRequiredFields)

            /*
            validationError.errorLabel?.isHidden = false
            validationError.errorLabel?.text = validationError.errorMessage
             self.requiredLabel.isHidden = false
             requiredLabel.text = ValidationError.
            */

        })

        //register all the textfield with rules
        validator.registerField(startingWeightTextField, errorLabel: requiredLabel, rules: [RequiredRule()])
        validator.registerField(startingDateTextField, errorLabel: requiredLabel, rules: [RequiredRule()])
        validator.registerField(goalWeightTextField, errorLabel: requiredLabel, rules: [RequiredRule()])

    }

    // MARK: ValidationDelegate Methods
    func validationSuccessful() {

        if phoneTextField.text!.count < 14 && phoneTextField.text!.count > 0 {
            self.showAlert(withText: Identifiers.Message.phoneNolenthMessage)
            return
        }
        if (goalWeightTextField.text! as NSString).floatValue >= (startingWeightTextField.text! as NSString).floatValue {

            self.showMessage(withText: Identifiers.Message.GoalWeightLess)

        } else {
            //self.signUp()
            if isResetGoal {
                self.resetGoalPressed()
            } else {
                //self.signUp()
                self.confirmSignUp()
            }
        }
    }
    /*
     func validationSuccessful() {
     if (goalWeightTextField.text! as NSString).floatValue >= (startingWeightTextField.text! as NSString).floatValue &&  (currentWeightTextField.text! as NSString).floatValue != (startingWeightTextField.text! as NSString).floatValue {
     
     self.showMessage(withText: Identifiers.Message.GoalWeightLess)
     
     } else if (currentWeightTextField.text! as NSString).floatValue != (startingWeightTextField.text! as NSString).floatValue && startingWeightDateTextLabel.text! == currentWeightDateTextLabel.text  && (goalWeightTextField.text! as NSString).floatValue <= (startingWeightTextField.text! as NSString).floatValue {
     
     self.showAlertMessage(withText: Identifiers.Message.EnterDifferentStartDate)
     
     } else if (currentWeightTextField.text! as NSString).floatValue == (startingWeightTextField.text! as NSString).floatValue && (goalWeightTextField.text! as NSString).floatValue >= (startingWeightTextField.text! as NSString).floatValue {
     
     self.showMessage(withText: Identifiers.Message.GoalWeightLess)
     
     } else {
     //self.signUp()
     if isResetGoal {
     self.resetGoalPressed()
     } else {
     self.signUp()
     }
     }
     }
     */

    func confirmSignUp() {

        UIViewController.displaySpinner()
        let countryValue = countryButton.titleLabel?.text == "USA" ? "USA" : countryButton.titleLabel?.text

        JCAnalyticsManager.shared.logEvent(eventName: "sign_up2", parameters: ["username": emailTextField.text!, "start_weight": (self.startingWeightTextField.text!), "goal_weight": (self.goalWeightTextField.text!), "country": countryValue!])

        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "MM-dd-yyyy"
        let showDate = inputFormatter.date(from: self.startingDateTextField.text!)
        inputFormatter.dateFormat = "yyyy-MM-dd"
        let resultString = inputFormatter.string(from: showDate!)
        jcPrint(resultString)

        let phoneField = self.removeSpecialCharsFromString(text: self.phoneTextField.text ?? "0000000000")

        boolIsConfirmSignup = true

        let pathNew = JCPostServicePath.confirmSignup(firstName: self.firstNameTextField.text!, lastName: self.lastNameTextField.text!, jennyid: self.jennyID, phone: phoneField, startingWeight: (self.startingWeightTextField.text!), goalWeight: (self.goalWeightTextField.text!), deviceType: UIDevice.current.name, deviceToken: (UIDevice.current.identifierForVendor?.uuidString)!, userType: "App", startingWeightDate: resultString, country: countryValue!, purpose: "", purposeReminder: 0, motivation: "", motivationReminder: 0, newsLetter: self.newsLetterValue, isConfirm: false, sonicLogic: 1)

        self.viewModel.callRegisterUserWebServices(servicePath: pathNew, withUserName: self.emailTextField.text!)

    }

    func showAlert(withText text: String) {
        self.popupAlert(title: "", message: text, actionTitles: ["Ok"], actions: [ {action1 in
            }, nil])
    }

    func showAlertMessage(withText text: String) {
        self.popupAlert(title: "", message: text, actionTitles: ["YES", "NO"], actions: [ {action1 in

            DispatchQueue.main.async(execute: {
                self.updateStartWeightDateTapped(UITapGestureRecognizer.self())

            })
            }, {action2 in
                //self.signUp()
                if isResetGoal {
                    self.resetGoalPressed()
                } else {
                    self.signUp()
                }
            }, nil])
    }

    func showMessage(withText text: String) {
        self.popupAlert(title: "", message: text, actionTitles: ["Ok"], actions: [ {action1 in
            }, nil])
    }

    func validationFailed(_ errors: [(Validatable, ValidationError)]) {
        jcPrint("Validation FAILED!")
    }

    func signUp() {

        /*    AuthController.resetToken()
         //   let countryValue = countryButton.titleLabel?.text == "United States of America" ? "USA" : countryButton.titleLabel?.text.
         let countryValue = countryButton.titleLabel?.text == "USA" ? "USA" : countryButton.titleLabel?.text
         
         JCAnalyticsManager.shared.logEvent(eventName: "sign_up2", parameters: ["username": emailTextField.text!, "start_weight": (self.startingWeightTextField.text!), "goal_weight": (self.goalWeightTextField.text!), "country": countryValue!])
         
         if iswebUser == true {
         
         if let model = self.viewModel.userInfo {
         
         let inputFormatter = DateFormatter()
         inputFormatter.dateFormat = "MM-dd-yyyy"
         let showDate = inputFormatter.date(from: self.startingDateTextField.text!)
         inputFormatter.dateFormat = "yyyy-MM-dd"
         let resultString = inputFormatter.string(from: showDate!)
         jcPrint(resultString)
         let phoneField = self.removeSpecialCharsFromString(text: self.phoneTextField.text ?? "0000000000")
         
         boolIsConfirmSignup = true
         
         let pathNew = JCPostServicePath.confirmSignup(firstName: model.firstName!, lastName: model.lastName!, jennyid: model.jennyid!, phone: "+1"+phoneField, startingWeight: (self.startingWeightTextField.text!), goalWeight: (self.goalWeightTextField.text!), deviceType: UIDevice.current.name, deviceToken: (UIDevice.current.identifierForVendor?.uuidString)!, userType: "Web", startingWeightDate: resultString, country: countryValue!, purpose: "", purposeReminder: 0, motivation: "", motivationReminder: 0, newsLetter: self.newsLetterValue, isConfirm: false)
         
         UIViewController.displaySpinner()
         self.viewModel?.callRegisterUserWebServices(servicePath: pathNew, withUserName: model.username!)
         }
         } else {
         var attributes = [AWSCognitoIdentityUserAttributeType]()
         UIViewController.displaySpinner()
         
         if let model = self.viewModel.userInfo {
         let emailValue = model.username!
         let email = AWSCognitoIdentityUserAttributeType()
         email?.name = "email"
         email?.value = emailValue
         attributes.append(email!)
         
         let name = AWSCognitoIdentityUserAttributeType()
         name?.name = "given_name"
         name?.value = model.firstName
         attributes.append(name!)
         
         let familyName = AWSCognitoIdentityUserAttributeType()
         familyName?.name = "family_name"
         familyName?.value = model.lastName
         attributes.append(familyName!)
         
         //sign up the user
         self.pool?.signUp(emailValue, password: passwordLocalSignup, userAttributes: attributes, validationData: nil).continueWith {[weak self] (task) -> Any? in
         guard let strongSelf = self else { return nil }
         DispatchQueue.main.async(execute: {
         if let error = task.error as NSError? {
         self?.popupAlert(title: "", message: error.userInfo["message"] as? String, actionTitles: ["OK"], actions: [ {action1 in
         UIViewController.removeSpinner()
         }, nil])
         
         } else if let result = task.result {
         // handle the case where user has to confirm his identity via email / SMS
         if (result.user.confirmedStatus != AWSCognitoIdentityUserStatus.confirmed) {
         jcPrint("Confirmation Sent")
         
         if let model = self?.viewModel?.userInfo {
         
         let inputFormatter = DateFormatter()
         inputFormatter.dateFormat = "MM-dd-yyyy"
         let showDate = inputFormatter.date(from: self!.startingDateTextField.text!)
         inputFormatter.dateFormat = "yyyy-MM-dd"
         let resultString = inputFormatter.string(from: showDate!)
         jcPrint(resultString)
         
         let phoneField = self?.removeSpecialCharsFromString(text: self?.phoneTextField.text ?? "0000000000")
         
         boolIsConfirmSignup = true
         let pathNew = JCPostServicePath.confirmSignup(firstName: model.firstName!, lastName: model.lastName!, jennyid: model.jennyid!, phone: "+1"+(phoneField ?? "0000000000"), startingWeight: (self?.startingWeightTextField.text!)!, goalWeight: (self?.goalWeightTextField.text!)!, deviceType: UIDevice.current.name, deviceToken: (UIDevice.current.identifierForVendor?.uuidString)!, userType: "App", startingWeightDate: resultString, country: countryValue!, purpose: "", purposeReminder: 0, motivation: "", motivationReminder: 0, newsLetter: self!.newsLetterValue, isConfirm: false)
         self?.viewModel?.callRegisterUserWebServices(servicePath: pathNew, withUserName: model.username!)
         
         }
         // self?.phoneTextField.text ?? "0000000000"
         
         } else {
         _ = strongSelf.navigationController?.popToRootViewController(animated: true)
         }
         }
         })
         return nil
         }
         }
         } */
    }
    func removeSpecialCharsFromString(text: String) -> String {
        var text1 = text
        text1 = text.replacingOccurrences(of: "(", with: "")
        text1 = text1.replacingOccurrences(of: ")", with: "")
        text1 = text1.replacingOccurrences(of: "-", with: "")
        text1 = text1.replacingOccurrences(of: " ", with: "")
        return text1
    }
}
extension JCAccountInfoController: AWSCognitoIdentityPasswordAuthentication {

    func signInUserInCognito(username: String) {

        let authDetails = AWSCognitoIdentityPasswordAuthenticationDetails(username: username, password: passwordLocalSignup )
        self.passwordAuthenticationCompletion?.set(result: authDetails)
    }

    public func getDetails(_ authenticationInput: AWSCognitoIdentityPasswordAuthenticationInput, passwordAuthenticationCompletionSource: AWSTaskCompletionSource<AWSCognitoIdentityPasswordAuthenticationDetails>) {
        self.passwordAuthenticationCompletion = passwordAuthenticationCompletionSource
        if let name = self.viewModel.userInfo.username {
            self.signInUserInCognito(username: name.lowercased())
        }
    }

    public func didCompleteStepWithError(_ error: Error?) {

        DispatchQueue.main.async {
            if let error = error as NSError? {

                DispatchQueue.main.async {
                    UIViewController.removeSpinner()
                }
                self.popupAlert(title: "", message: error.userInfo["message"] as? String, actionTitles: ["Retry"], actions: [ {action1 in
                    }, nil])

            } else {

                do {
                    let emailText = self.viewModel.userInfo.username?.trimmingTrailingSpaces
                    AuthController.setUsername(username: (emailText?.lowercased())!)
                    try AuthController.setPassword(username: ((emailText?.lowercased())!), password: passwordLocalSignup)
                } catch {
                    jcPrint("Error signing in: \(error.localizedDescription)")
                }

                countHomeScreenDisplayed = 0
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {

                    DispatchQueue.main.async {
                        UIViewController.removeSpinner()
                    }
                    jcPrint("pushed to monitor")
                    Identifiers.APPDELEGATE?.window?.rootViewController = UIStoryboard.dashboardStoryboard().instantiateInitialViewController()

                })
                globalTimer?.invalidate()
                globalTimer = nil

            }
        }
    }

}
