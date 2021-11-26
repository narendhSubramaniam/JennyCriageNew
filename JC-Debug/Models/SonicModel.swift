//
//  SonicModel.swift
//  JennyCraig
//
//  Created by Mobileprogrammingllc on 24/02/21.
//  Copyright © 2021 JennyCraig. All rights reserved.
//

import UIKit

struct SonicModel: Codable, ResponseData {
    var error: Int?
    var successful: Int?
    var message: String?
    var messageType: String?
}
