//  UIColorExtension.swift
//  JennyCraig
//  Created by Mobileprogrammingllc on 14/09/18.
//  Copyright © 2018 JennyCraig. All rights reserved.

import Foundation
import UIKit

extension UIView {

    func addShadowView(width: CGFloat=0.2, height: CGFloat=10.0, opacidade: Float=0.7, maskToBounds: Bool=false, radius: CGFloat=0.5) {
        let grayColor = UIColor(red: 220.0/255.0, green: 220.0/255.0, blue: 220.0/255.0, alpha: 0.5)
        self.layer.shadowColor = grayColor.cgColor
        self.layer.shadowOffset = CGSize(width: width, height: height)
        self.layer.shadowRadius = radius
        self.layer.shadowOpacity = opacidade
        self.layer.masksToBounds = maskToBounds
    }

    func addShadowViewToEditWeight(width: CGFloat=0.2, height: CGFloat=10.0, opacidade: Float=0.7, maskToBounds: Bool=false, radius: CGFloat=0.5) {
        let grayColor = UIColor(red: 206.0/255.0, green: 208.0/255.0, blue: 208.0/255.0, alpha: 0.5)
        self.layer.shadowColor = grayColor.cgColor
        self.layer.shadowOffset = CGSize(width: width, height: height)
        self.layer.shadowRadius = radius
        self.layer.shadowOpacity = opacidade
        self.layer.masksToBounds = maskToBounds
    }

    func addFadedShadow(color: UIColor) {
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowOffset = .zero
        self.layer.shadowRadius = 2.5
    }

    func addOverlayDropShadow(color: UIColor) {
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOpacity = 0.15
        self.layer.shadowOffset = .zero
        self.layer.shadowRadius = 2.5
    }

    func blink(completion: @escaping (Bool) -> Void) {
        self.alpha = 0
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.3, delay: 0.0, options: [.curveLinear], animations: {self.alpha = 1.0}) { (_) in
                completion(true)
            }
        }
    }
}
