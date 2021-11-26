//
//  SonicClient.swift
//  JennyCraig
//
//  Created by Mobileprogrammingllc on 24/02/21.
//  Copyright © 2021 JennyCraig. All rights reserved.
//

import UIKit

class SonicClient: APIClient {

    var session: URLSession

    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }

    convenience init() {
        self.init(configuration: .default)
    }

    func updateSonicData(resource: JCAPIResource, completion: @escaping (APIResponse<SonicModel, APIError>) -> Void) {

        fetch(with: resource.request, decode: { json -> SonicModel? in
            guard let data = json as? SonicModel else { return  nil }
            return data
        }, completion: completion)
    }

}
