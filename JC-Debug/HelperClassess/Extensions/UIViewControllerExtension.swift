//  UIViewControllerExtension.swift
//  JennyCraig
//  Created by Mobileprogrammingllc on 7/5/18.
//  Copyright © 2018 JennyCraig. All rights reserved.

import Foundation
import UIKit

extension UIViewController {

    func popupAlert(title: String?, message: String?, actionTitles: [String?], actions: [((UIAlertAction) -> Void)?]) {

        if message == "" || message == nil {
            return
        }
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let messageFont = [NSAttributedString.Key.font: UIFont(name: "SFProText-Bold", size: 17.0)! ]
        let messageAttrString = NSMutableAttributedString(string: message!, attributes: messageFont)
        alert.setValue(messageAttrString, forKey: "attributedMessage")
        for (index, title) in actionTitles.enumerated() {
            let action = UIAlertAction(title: title, style: .default, handler: actions[index])
            alert.addAction(action)
        }
        self.present(alert, animated: true, completion: nil)
    }

    func customPopupAlert(title: String?, message: String?, actionTitles: [String?], actions: [((UIAlertAction) -> Void)?]) {

        if message == "" || message == nil {
            return
        }
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        let titleAttributedString = NSMutableAttributedString(string: title!, attributes: [NSAttributedString.Key.font: UIFont(name: "SFProText-Bold", size: 16.0)!])
        alert.setValue(titleAttributedString, forKey: "attributedTitle")

        let messageAttributedString = NSMutableAttributedString(string: message!, attributes: [NSAttributedString.Key.font: UIFont(name: "SFProText-Regular", size: 13.0)!])
        alert.setValue(messageAttributedString, forKey: "attributedMessage")

        for (index, title) in actionTitles.enumerated() {
            let action = UIAlertAction(title: title, style: .default, handler: actions[index])
            alert.addAction(action)
        }
        self.present(alert, animated: true, completion: nil)
    }

    func showAppleHealthAlertController(message: String) {
//        let viewController = UIStoryboard.appleHealthAlertController()
//        viewController!.message = message
//        if #available(iOS 13.0, *) {
//            viewController?.modalPresentationStyle = .overCurrentContext
//        } else {
//            viewController?.modalPresentationStyle = .overCurrentContext
//        }
//        self.present(viewController!, animated: true, completion: nil)
    }

}

extension UIViewController {
    func hideKeyboard() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(UIViewController.dismissKeyboard))

        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}


extension UIViewController {

    class func displaySpinner(onView: UIView? = nil) {

        if let container = UIApplication.topViewController() {
            
            
            //   if container is JCSelfMonitorViewController || container is JCProgressViewController || container is JCContactViewController || container is JCSettingViewController {
//                if container is JCSelfMonitorViewController || container is JCProgressViewController || container is JCContactViewController  {
//
//
//                if let _ = container.tabBarController?.view.viewWithTag(100000) {
//                    return
//                }
//
//            } else {
                if let _ = container.view.viewWithTag(100000) {
                    return
                }
           // }

        }

        let spinnerView = UIView.init(frame: UIScreen.main.bounds)
        spinnerView.tag = 100000
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let indicator = UIActivityIndicatorView.init(style: .whiteLarge)
        indicator.startAnimating()
        indicator.center = spinnerView.center

//        let imageView = addMicrowaveanimation()
//        //        imageView.frame = CGRect(x: spinnerView.bounds.midX-70/2, y: spinnerView.bounds.midY, width: 70, height: 49)
//        //imageView.frame = CGRect(x: spinnerView.bounds.midX-150/2, y: spinnerView.bounds.midY, width: 150, height: 120)
//        imageView.frame = CGRect(x: spinnerView.bounds.midX-100/2, y: spinnerView.bounds.midY-50, width: 100, height: 100)
//
//        //  DispatchQueue.main.async {
//        // spinnerView.addSubview(indicator)
//        spinnerView.addSubview(imageView)

        if let container = UIApplication.topViewController() {
//            if container is JCSelfMonitorViewController || container is JCProgressViewController || container is JCContactViewController || container is JCMoreViewController {
//
//                container.tabBarController?.view.addSubview(spinnerView)
//            } else {
                container.view.addSubview(spinnerView)

            //}
        }
        // }
    }

//    class func addMicrowaveanimation() -> UIImageView {
//        do {
//            //   let gif = try UIImage(gifName: "microwave.gif")
//            let gif = try UIImage(gifName: "animatedJ.gif")
//            let imageView = UIImageView()
//            imageView.setGifImage(gif)
//            return imageView
//        } catch {
//            jcPrint(error)
//        }
//        return UIImageView()
//    }

    class func removeSpinner(spinner: UIView? = nil) {
        DispatchQueue.main.async {
            if let container = UIApplication.topViewController() {

//                if container is JCSelfMonitorViewController || container is JCProgressViewController || container is JCContactViewController || container is JCMoreViewController {
//
//                    if let spinnerView = container.tabBarController?.view.viewWithTag(100000) {
//                        spinnerView.removeFromSuperview()
//                    }
//
//                } else {
                    if let spinnerView = container.view.viewWithTag(100000) {
                        spinnerView.removeFromSuperview()
                    }
              //  }

            }
        }
    }
}

private var window: UIWindow!

 extension UIAlertController {

    func show(animated: Bool, completion: (() -> Void)?) {

        let messageFont = [NSAttributedString.Key.font: UIFont(name: "SFProText-Bold", size: 17.0)! ]
        let messageAttrString = NSMutableAttributedString(string: self.message!, attributes: messageFont)
        self.setValue(messageAttrString, forKey: "attributedMessage")

        window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = UIViewController()
        window.windowLevel = UIWindow.Level.alert + 1
        window.makeKeyAndVisible()
        window.rootViewController?.present(self, animated: animated, completion: completion)
    }

    func showAlertWindow(animated: Bool, completion: (() -> Void)?) {

        window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = UIViewController()
        window.windowLevel = UIWindow.Level.alert + 1
        window.makeKeyAndVisible()
        window.rootViewController?.present(self, animated: animated, completion: completion)
    }

    open override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        window = nil
    }
}

extension UIViewController {

    class func showAlert(title: String?, message: String?, actionTitles: [String?], actions: [((UIAlertAction) -> Void)?]) {

        if message == "" || message == nil {
            return
        }

        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let messageFont = [NSAttributedString.Key.font: UIFont(name: "SFProText-Bold", size: 17.0)! ]
        let messageAttrString = NSMutableAttributedString(string: message!, attributes: messageFont)
        alert.setValue(messageAttrString, forKey: "attributedMessage")

        //   let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        for (index, title) in actionTitles.enumerated() {
            let action = UIAlertAction(title: title, style: .default, handler: actions[index])
            alert.addAction(action)
        }
        alert.show(animated: true, completion: nil)
    }

    class func showCustomAlert(title: String?, message: String?, actionTitles: [String?], actions: [((UIAlertAction) -> Void)?]) {

        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        let titleAttributedString = NSMutableAttributedString(string: title!, attributes: [NSAttributedString.Key.font: UIFont(name: "SFProText-Bold", size: 17.0)!, NSAttributedString.Key.foregroundColor: UIColor.grayDark])
        alert.setValue(titleAttributedString, forKey: "attributedTitle")

        let messageAttributedString = NSMutableAttributedString(string: message!, attributes: [NSAttributedString.Key.font: UIFont(name: "SFProText-Regular", size: 13.0)!, NSAttributedString.Key.foregroundColor: UIColor.grayDark])
        alert.setValue(messageAttributedString, forKey: "attributedMessage")

        for (index, title) in actionTitles.enumerated() {
            let action = UIAlertAction(title: title, style: .cancel, handler: actions[index])
            alert.addAction(action)
        }
        alert.showAlertWindow(animated: true, completion: nil)
    }
}
