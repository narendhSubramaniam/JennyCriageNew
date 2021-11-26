//
//  SettingClient.swift
//  JennyCraig
//
//  Created by Mobileprogrammingllc on 8/24/18.
//  Copyright © 2018 JennyCraig. All rights reserved.
//

import UIKit

class SettingClient: APIClient {
    var session: URLSession

    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }

    convenience init() {
        self.init(configuration: .default)
    }

//    func getSettingList(resource: JCAPIResource, completion: @escaping (APIResponse<SettingModel, APIError>) -> Void) {
//
//        fetch(with: resource.request, decode: { json -> SettingModel? in
//            guard let data = json as? SettingModel else { return  nil }
//            return data
//        }, completion: completion)
//    }

    func setSettingList(resource: JCAPIResource, completion: @escaping (APIResponse<GenericResponse, APIError>) -> Void) {

        fetch(with: resource.request, decode: { json -> GenericResponse? in
            guard let data = json as? GenericResponse else { return  nil }
            return data
        }, completion: completion)
    }

}
