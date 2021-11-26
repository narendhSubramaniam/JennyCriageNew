//  GradientViewProvider+iOS.swift
//  JennyCraig
//  Created by Mobileprogrammingllc on 6/21/18.
//  Copyright © 2018 JennyCraig. All rights reserved.

import UIKit

extension GradientViewProvider where Self: UIView {
var gradientLayer: Self.GradientViewType {
return layer as! Self.GradientViewType
}
}


/*
extension GradientViewProvider where Self: UIView, Self.GradientViewType: CAGradientLayer {

    public var gradientLayer: Self.GradientViewType {
        return (layer as? Self.GradientViewType)!
    }
}
*/


