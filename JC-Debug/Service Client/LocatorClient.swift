//
//  LocatorClient.swift
//  JennyCraig
//
//  Created by Mobileprogrammingllc on 8/30/18.
//  Copyright © 2018 JennyCraig. All rights reserved.
//

import UIKit

class LocatorClient: APIClient {

    var session: URLSession

    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }

    convenience init() {
        self.init(configuration: .default)
    }

//    func getCenterList(resource: JCAPIResource, completion: @escaping (APIResponse<[LocatorModel], APIError>) -> Void) {
//
//        fetch(with: resource.request, decode: { json -> [LocatorModel]? in
//            guard let data = json as? [LocatorModel] else { return  nil }
//            return data
//        }, completion: completion)
//    }

}
