//
//  ProgressClient.swift
//  JennyCraig
//
//  Created by Mobileprogrammingllc on 8/14/18.
//  Copyright © 2018 JennyCraig. All rights reserved.
//

import UIKit

class ProgressClient: APIClient {
    var session: URLSession

    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }

    convenience init() {
        self.init(configuration: .default)
    }

    func getProgress(resource: JCAPIResource, completion: @escaping (APIResponse<ProgressModel, APIError>) -> Void) {

        fetch(with: resource.request, decode: { json -> ProgressModel? in
            guard let data = json as? ProgressModel else { return  nil }
            return data
        }, completion: completion)
    }
}
