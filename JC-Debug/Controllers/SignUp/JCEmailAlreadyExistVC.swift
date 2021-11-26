//
//  JCEmailAlreadyExistVC.swift
//  JennyCraig
//
//  Created by Mobileprogrammingllc on 7/7/18.
//  Copyright © 2018 JennyCraig. All rights reserved.
//

import UIKit
import AWSCognitoIdentityProvider

class JCEmailAlreadyExistVC: UIViewController {

    weak var containerDelegate: UpdateContainerViewDelegate?
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var sendPasswordBtn: UIButton!
    @IBOutlet weak var backBtn: UIButton!
    
    var viewModel = SignUpViewModel()
    var pool: AWSCognitoIdentityUserPool?
    var user: AWSCognitoIdentityUser?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpHandler()
        self.pool = AWSCognitoIdentityUserPool(forKey: Identifiers.AWSCognitoUserPoolsSignInProviderKey)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    @IBAction func backButtonAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func signInButtonPressed(_ sender: UIButton) {

     let signInVC = UIStoryboard.signInViewController()
    self.navigationController?.pushViewController(signInVC!, animated: true)
    }

    @IBAction func sendPasswordResetLinkButtonPressed(_ sender: UIButton) {
        if !Reachability.isConnectedToNetwork() {
            /*self.popupAlert(title: "", message: Identifiers.Message.NoInternetConnectivity, actionTitles: ["Ok"], actions: [ {action1 in
                }, nil])*/
            return
        }
        validationSuccessful()
    }

    // MARK: navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
//        if segue.destination is JCPasswordResetController {
//            //send data
//            if let controller = segue.destination as? JCPasswordResetController {
//                if let defaults = AuthController.getUserName() as? String {
//                    controller.userNameString = defaults
//                    controller.containerDelegate = containerDelegate
//                }
//            }
//
//        }
    }

    private func setUpHandler() {

        viewModel.successViewClosure = { [weak self] (response) in
            DispatchQueue.main.async {

                //UIViewController.removeSpinner()

                guard (response.successful != 0) else {

                    //show alert
                    self?.popupAlert(title: "", message: response.message, actionTitles: ["Ok"], actions: [ {action1 in
                        }, nil])
                    return
                }

                self?.popupAlert(title: "", message: response.message, actionTitles: ["Ok"], actions: [ {action1 in

                    self?.performSegue(withIdentifier: Identifiers.SegueIdentifiers.JCResetPasswordSegueIdentifier, sender: self)
                    }, nil])
            }
        }

        viewModel.showAlertClosure = { [weak self] (message) in
            DispatchQueue.main.async {

               // UIViewController.removeSpinner()

                //show alert
                self?.popupAlert(title: "", message: message, actionTitles: ["Ok"], actions: [ {action1 in
                    }, nil])
            }
            } as ((String) -> Void)
    }

    func validationSuccessful() {

            if !Reachability.isConnectedToNetwork() {
                /*self.popupAlert(title: "", message: Identifiers.Message.NoInternetConnectivity, actionTitles: ["Ok"], actions: [ {action1 in
                    }, nil])*/
                return
            }

        //  let username = AuthController.getUserName()
         //   UIViewController.displaySpinner()
            //self.user = self.pool?.getUser(username!)

            self.user?.forgotPassword().continueWith {[weak self] (task: AWSTask) -> AnyObject? in
                guard let _ = self else {
                    return nil

                }
                DispatchQueue.main.async(execute: {
                   // UIViewController.removeSpinner()

                    if let error = task.error as NSError? {

                        if error.userInfo["__type"] as? String == ExceptionString.userNotFoundException.rawValue {
                            self!.popupAlert(title: "", message: Identifiers.Message.EmailNotAssociated, actionTitles: ["Ok"], actions: [ {action1 in
                               // UIViewController.removeSpinner()

                                }, nil])
                        } else {

                            self?.popupAlert(title: "", message: error.userInfo["message"] as? String, actionTitles: ["Ok"], actions: [ {action1 in
                               //  UIViewController.removeSpinner()
                            }, nil])

                        }

                    } else {
                            self?.performSegue(withIdentifier: Identifiers.SegueIdentifiers.JCResetPasswordSegueIdentifier, sender: self)
                        }
                })
                return nil
            }
        }

}
