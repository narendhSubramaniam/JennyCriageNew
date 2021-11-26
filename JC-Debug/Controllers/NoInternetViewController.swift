//
//  NoInternetViewController.swift
//  JennyCraig
//
//  Created by mobileprogrammingllc on 1/16/19.
//  Copyright © 2019 JennyCraig. All rights reserved.
//

import UIKit

class NoInternetViewController: UIViewController {

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        let colors = [UIColor.black.cgColor, UIColor.darkGray.cgColor]
        self.view.gradientLayer.colors = colors
        self.view.gradientLayer.gradient = GradientPoint.bottomTop.draw()
    }
}
