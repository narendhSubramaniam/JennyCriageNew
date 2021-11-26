//
//  MeasurementClient.swift
//  JennyCraig
//
//  Created by Mobileprogrammingllc on 21/06/19.
//  Copyright © 2019 JennyCraig. All rights reserved.
//

import UIKit

class MeasurementClient: APIClient {

    var session: URLSession

    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }

    convenience init() {
        self.init(configuration: .default)
    }

//    func saveMeasurement(resource: JCAPIResource, completion: @escaping (APIResponse<MeasurementModel, APIError>) -> Void) {
//
//        fetch(with: resource.request, decode: { json -> MeasurementModel? in
//            guard let data = json as? MeasurementModel else { return  nil }
//            return data
//        }, completion: completion)
//    }
//
//    func userMeasurement(resource: JCAPIResource, completion: @escaping (APIResponse<UserMeasurementModel, APIError>) -> Void) {
//
//        fetch(with: resource.request, decode: { json -> UserMeasurementModel? in
//            guard let data = json as? UserMeasurementModel else { return  nil }
//            return data
//        }, completion: completion)
//    }

}
