//
//  ProgressShareClient.swift
//  JennyCraig
//
//  Created by Mobileprogrammingllc on 06/11/18.
//  Copyright © 2018 JennyCraig. All rights reserved.
//

import UIKit

class ProgressShareClient: APIClient {
    var session: URLSession

    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }

    convenience init() {
        self.init(configuration: .default)
    }

//    func uploadMilestone(resource: JCAPIResource, completion: @escaping (APIResponse<ProgressShareModel, APIError>) -> Void) {
//
//        fetch(with: resource.request, decode: { json -> ProgressShareModel? in
//            guard let data = json as? ProgressShareModel else { return  nil }
//            return data
//        }, completion: completion)
//    }
}
