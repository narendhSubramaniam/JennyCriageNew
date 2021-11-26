//
//  WeightClient.swift
//  JennyCraig
//
//  Created by Mobileprogrammingllc on 7/27/18.
//  Copyright © 2018 JennyCraig. All rights reserved.
//

import Foundation

class WeightClient: APIClient {

    var session: URLSession

    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }

    convenience init() {
        self.init(configuration: .default)
    }

//    func dailyWeightList(resource: JCAPIResource, completion: @escaping (APIResponse<DailyWeight, APIError>) -> Void) {
//
//        fetch(with: resource.request, decode: { json -> DailyWeight? in
//            guard let data = json as? DailyWeight else { return  nil }
//            return data
//        }, completion: completion)
//
//    }
//    func updateGoalWeight(resource: JCAPIResource, completion: @escaping (APIResponse<UpdateGoalWeight, APIError>) -> Void) {
//
//        fetch(with: resource.request, decode: { json -> UpdateGoalWeight? in
//            guard let data = json as? UpdateGoalWeight else { return  nil }
//            return data
//        }, completion: completion)
//
//    }
//    func updateStartingWeight(resource: JCAPIResource, completion: @escaping (APIResponse<UpdateStartingWeight, APIError>) -> Void) {
//
//        fetch(with: resource.request, decode: { json -> UpdateStartingWeight? in
//            guard let data = json as? UpdateStartingWeight else { return  nil }
//            return data
//        }, completion: completion)
//
//    }
//    func editWeightEntry(resource: JCAPIResource, completion: @escaping (APIResponse<WeightUpdateEntry, APIError>) -> Void) {
//
//        fetch(with: resource.request, decode: { json -> WeightUpdateEntry? in
//            guard let data = json as? WeightUpdateEntry else { return  nil }
//            return data
//        }, completion: completion)
//
//    }
//    func deleteWeightEntry(resource: JCAPIResource, completion: @escaping (APIResponse<DeleteEditWeight, APIError>) -> Void) {
//
//          fetch(with: resource.request, decode: { json -> DeleteEditWeight? in
//              guard let data = json as? DeleteEditWeight else { return  nil }
//              return data
//          }, completion: completion)
//
//      }
}
