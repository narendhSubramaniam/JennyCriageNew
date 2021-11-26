//  GradientLayer.swift
//  JennyCraig
//  Created by Mobileprogrammingllc on 6/21/18.
//  Copyright © 2018 JennyCraig. All rights reserved.

import Foundation
import QuartzCore

public class GradientLayer: CAGradientLayer {
    public var gradient: GradientType? {
        didSet {
            startPoint = gradient?.x ?? CGPoint.zero
            endPoint = gradient?.y ?? CGPoint.zero
        }
    }
}
