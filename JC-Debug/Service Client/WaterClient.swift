//  WaterClient.swift
//  JennyCraig
//  Created by Mobileprogrammingllc on 26/11/19.
//  Copyright © 2019 JennyCraig. All rights reserved.

import UIKit

class WaterClient: APIClient {

    var session: URLSession

    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }

    convenience init() {
        self.init(configuration: .default)
    }

//    func userSaveWater(resource: JCAPIResource, completion: @escaping (APIResponse<WaterModel, APIError>) -> Void) {
//
//        fetch(with: resource.request, decode: { json -> WaterModel? in
//            guard let data = json as? WaterModel else { return  nil }
//            return data
//        }, completion: completion)
//    }

}
