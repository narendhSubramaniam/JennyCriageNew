//  CustomTextField.swift
//  JennyCraig
//  Created by Mobileprogrammingllc on 6/20/18.
//  Copyright © 2018 JennyCraig. All rights reserved.

import Foundation
import UIKit

@IBDesignable
class CustomTextField: UITextField {
    let border1 = CALayer()
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }

    @IBInspectable var bottomBorder: Bool = true {
        didSet {
            border1.isHidden = !bottomBorder
        }
    }

    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }

    @IBInspectable var borderColor: UIColor? {
        didSet {
            layer.borderColor = borderColor?.cgColor
        }
    }

    @IBInspectable var bgColor: UIColor? {
        didSet {
            backgroundColor = bgColor
        }
    }

    @IBInspectable var leftImage: UIImage? {
        didSet {
            if let image = leftImage {

                rightViewMode = .always
                let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 15, height: 15))
                imageView.image = image
                imageView.contentMode = .scaleAspectFit
                imageView.tintColor = tintColor
                let view = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 15))
                view.addSubview(imageView)
                rightView = view
            } else {
                rightViewMode = .never
            }

        }
    }
/*
    @IBInspectable var placeholderColor : UIColor? {
        didSet {
            let rawString = attributedPlaceholder?.string != nil ? attributedPlaceholder!.string : ""
            let str = NSAttributedString(string: rawString, attributes: [kCTForegroundColorAttributeName as NSAttributedStringKey : placeholderColor!])
            attributedPlaceholder = str
            self.attributedPlaceholder.co  = NSAttributedString(string: rawString, attributes: [NSForegroundColorAttributeName: UIColor.white])
        }
    }
    */

    override func textRect(forBounds bounds: CGRect) -> CGRect {

        if self.leftImage != nil {

            return bounds.insetBy(dx: 10, dy: 5)
        }

        return bounds.insetBy(dx: 0, dy: 5)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {

        if self.leftImage != nil {

            return bounds.insetBy(dx: 10, dy: 5)
        }
        return bounds.insetBy(dx: 0, dy: 5)
    }

     override func awakeFromNib() {
        let width1 = CGFloat(1.0)
        border1.borderColor = UIColor.white.cgColor
        border1.frame = CGRect(x: 0, y: self.frame.size.height - width1, width: self.frame.size.width, height: self.frame.size.height)
        border1.borderWidth = width1
        self.layer.addSublayer(border1)
        self.layer.masksToBounds = true
    }

}

extension UITextField {
    @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {

            self.attributedPlaceholder = NSAttributedString(string: self.placeholder != nil ? self.placeholder! : "", attributes: [NSAttributedString.Key.foregroundColor: newValue!])
        }
    }
}
