//
//  RapidResultClient.swift
//  JennyCraig
//
//  Created by Mobileprogrammingllc on 9/26/18.
//  Copyright © 2018 JennyCraig. All rights reserved.
//

import UIKit

class RapidResultClient: APIClient {

    var session: URLSession

    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }

    convenience init() {
        self.init(configuration: .default)
    }

//    func saveRapidResult(resource: JCAPIResource, completion: @escaping (APIResponse<RapidResultModel, APIError>) -> Void) {
//
//        fetch(with: resource.request, decode: { json -> RapidResultModel? in
//            guard let data = json as? RapidResultModel else { return  nil }
//            return data
//        }, completion: completion)
//    }

}
