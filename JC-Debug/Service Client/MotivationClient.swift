//  MotivationClient.swift
//  JennyCraig
//  Created by Mobileprogrammingllc on 22/11/19.
//  Copyright © 2019 JennyCraig. All rights reserved.

import UIKit

class MotivationClient: APIClient {

    var session: URLSession

    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }

    convenience init() {
        self.init(configuration: .default)
    }

    func updateMotivation(resource: JCAPIResource, completion: @escaping (APIResponse<MotivationModel, APIError>) -> Void) {

        fetch(with: resource.request, decode: { json -> MotivationModel? in
            guard let data = json as? MotivationModel else { return  nil }
            return data
        }, completion: completion)
    }

}
