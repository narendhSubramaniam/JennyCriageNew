//
//  NotCompatibleViewController.swift
//  JennyCraig
//
//  Created by mobileprogrammingllc on 2/26/19.
//  Copyright © 2019 JennyCraig. All rights reserved.
//

import UIKit

class NotCompatibleViewController: UIViewController {

    @IBOutlet weak var labelTitle: UILabel!
    var message = ""

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.labelTitle.text = message
        let colors = [UIColor.black.cgColor, UIColor.darkGray.cgColor]
        self.view.gradientLayer.colors = colors
        self.view.gradientLayer.gradient = GradientPoint.bottomTop.draw()
    }

}
