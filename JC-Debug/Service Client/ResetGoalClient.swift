//  ResetGoalClient.swift
//  JennyCraig
//  Created by Mobileprogrammingllc on 23/04/19.
//  Copyright © 2019 JennyCraig. All rights reserved.

import UIKit

class ResetGoalClient: APIClient {

    var session: URLSession

    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }

    convenience init() {
        self.init(configuration: .default)
    }

    func getResetGoal(resource: JCAPIResource, completion: @escaping (APIResponse<ResetGoalModel, APIError>) -> Void) {

        fetch(with: resource.request, decode: { json -> ResetGoalModel? in
            guard let data = json as? ResetGoalModel else { return  nil }
            return data
        }, completion: completion)
    }
}
