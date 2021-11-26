//
//  ResetPopUpClient.swift
//  JennyCraig
//
//  Created by Mobileprogrammingllc on 24.12.19.
//  Copyright © 2019 JennyCraig. All rights reserved.
//

import UIKit

class ResetPopUpClient: APIClient {

    var session: URLSession

    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }

    convenience init() {
        self.init(configuration: .default)
    }

    func callResetPopUpFlag(resource: JCAPIResource, completion: @escaping (APIResponse<GenericResponse, APIError>) -> Void) {

        fetch(with: resource.request, decode: { json -> GenericResponse? in
            guard let user = json as? GenericResponse else { return  nil }
            return user
        }, completion: completion)
    }
}
