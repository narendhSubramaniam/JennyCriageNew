//  KeyboardScroll.swift
//  JennyCraig
//  Created by Mobileprogrammingllc on 6/25/18.
//  Copyright © 2018 JennyCraig. All rights reserved.

import Foundation
import UIKit

// MARK: - Observers
extension UIViewController {

    func addObserverForNotification(_ notificationName: Notification.Name, actionBlock: @escaping (Notification) -> Void) {
        NotificationCenter.default.addObserver(forName: notificationName, object: nil, queue: OperationQueue.main, using: actionBlock)
    }

    func removeObserver(_ observer: AnyObject, notificationName: Notification.Name) {
        NotificationCenter.default.removeObserver(observer, name: notificationName, object: nil)
    }
}

// MARK: - Keyboard handling
extension UIViewController {

    typealias KeyboardHeightClosure = (CGFloat) -> Void

    func addKeyboardChangeFrameObserver(willShow willShowClosure: KeyboardHeightClosure?,
                                        willHide willHideClosure: KeyboardHeightClosure?) {
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillChangeFrameNotification,
                                               object: nil, queue: OperationQueue.main, using: { [weak self](notification) in
                if let userInfo = notification.userInfo,
                   let frame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue,
                   let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double,
                   let curveUserInfo = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt,
                let kFrame = self?.view.convert(frame, from: nil),
                let kBounds = self?.view.bounds {

                    let animationType = UIView.AnimationOptions(rawValue: curveUserInfo)
                               let kHeight = kFrame.size.height
                        UIView.animate(withDuration: duration, delay: 0, options: animationType, animations: {
                          if kBounds.intersects(kFrame) { // keyboard will be shown
                                willShowClosure?(kHeight)
                        } else { // keyboard will be hidden
                            willHideClosure?(kHeight)
                        }

                        }, completion: nil)
                 } else {
                      jcPrint("Invalid conditions for UIKeyboardWillChangeFrameNotification")
                }
        })
    }

    func removeKeyboardObserver() {
        removeObserver(self, notificationName: UIResponder.keyboardWillChangeFrameNotification)
    }
}
