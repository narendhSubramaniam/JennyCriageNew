//
//  HealthDataClient.swift
//  JennyCraig
//
//  Created by Mobileprogrammingllc on 04/06/21.
//  Copyright © 2021 JennyCraig. All rights reserved.
//

import Foundation


class HealthDataClient: APIClient {

    var session: URLSession

    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }

    convenience init() {
        self.init(configuration: .default)
    }

//    func saveHealthData(resource: JCAPIResource, completion: @escaping (APIResponse<[HealthDataModel], APIError>) -> Void) {
//
//        fetch(with: resource.request, decode: { json -> [HealthDataModel]? in
//            guard let data = json as? [HealthDataModel] else { return  nil }
//            return data
//        }, completion: completion)
//    }

}
