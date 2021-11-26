//
//  SignInClient.swift
//  JennyCraig
//
//  Created by Mobileprogrammingllc on 12.11.19.
//  Copyright © 2019 JennyCraig. All rights reserved.
//

import Foundation

class SignInClient: APIClient {

    var session: URLSession

    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }

    convenience init() {
        self.init(configuration: .default)
    }

    func callUserSignIn(resource: JCAPIResource, completion: @escaping (APIResponse<SignInModel, APIError>) -> Void) {

        fetch(with: resource.request, decode: { json -> SignInModel? in
            guard let user = json as? SignInModel else { return  nil }
            return user
        }, completion: completion)
    }
}
