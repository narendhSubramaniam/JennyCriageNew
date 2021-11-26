//
//  RegistrationClient.swift
//  JennyCraig
//
//  Created by Mobileprogrammingllc on 7/5/18.
//  Copyright © 2018 JennyCraig. All rights reserved.
//

import Foundation

class RegistrationClient: APIClient {

    var session: URLSession

    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }

    convenience init() {
        self.init(configuration: .default)
    }

    func checkUserExist(resource: JCAPIResource, completion: @escaping (APIResponse<GenericResponse, APIError>) -> Void) {

        fetch(with: resource.request, decode: { json -> GenericResponse? in
            guard let user = json as? GenericResponse else { return  nil }
            return user
        }, completion: completion)
    }

    func registerUser(resource: JCAPIResource, completion: @escaping (APIResponse<GenericResponse, APIError>) -> Void) {

        fetch(with: resource.request, decode: { json -> GenericResponse? in
            guard let user = json as? GenericResponse else { return  nil }
            return user
        }, completion: completion)
    }
}
