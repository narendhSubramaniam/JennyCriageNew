//
//  LoginClient.swift
//  JennyCraig
//
//  Created by Mobileprogrammingllc on 7/2/18.
//  Copyright © 2018 JennyCraig. All rights reserved.
//

import Foundation

class LoginClient: APIClient {

    var session: URLSession

    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }

    convenience init() {
        self.init(configuration: .default)
    }

    func fetchLoginData(resource: JCAPIResource, completion: @escaping (APIResponse<UserInfo, APIError>) -> Void) {

        fetch(with: resource.request, decode: { json -> UserInfo? in
            guard let user = json as? UserInfo else { return  nil }
            return user
        }, completion: completion)
    }

    //r
    func fetchCheckRegisterdUserTypeData(resource: JCAPIResource, completion: @escaping (APIResponse<UserRegistered, APIError>) -> Void) {

        fetch(with: resource.request, decode: { json -> UserRegistered? in
            guard let user = json as? UserRegistered else { return  nil }
            return user
        }, completion: completion)
    }
}
