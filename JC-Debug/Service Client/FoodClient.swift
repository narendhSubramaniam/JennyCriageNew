//
//  FoodClient.swift
//  JennyCraig
//
//  Created by Mobileprogrammingllc on 8/3/18.
//  Copyright © 2018 JennyCraig. All rights reserved.
//

import Foundation

class FoodClient: APIClient {

    var session: URLSession

    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }

    convenience init() {
        self.init(configuration: .default)
    }

//    func addFood(resource: JCAPIResource, completion: @escaping (APIResponse<AddFood, APIError>) -> Void) {
//
//        fetch(with: resource.request, decode: { json -> AddFood? in
//            guard let data = json as? AddFood else { return  nil }
//            return data
//        }, completion: completion)
//    }
//    //updateFood
//    func updateFood(resource: JCAPIResource, completion: @escaping (APIResponse<UpdateFood, APIError>) -> Void) {
//
//        fetch(with: resource.request, decode: { json -> UpdateFood? in
//            guard let data = json as? UpdateFood else { return  nil }
//            return data
//        }, completion: completion)
//    }
//
//    func getFoodList(resource: JCAPIResource, completion: @escaping (APIResponse<FoodList, APIError>) -> Void) {
//
//        fetch(with: resource.request, decode: { json -> FoodList? in
//            guard let data = json as? FoodList else { return  nil }
//            return data
//        }, completion: completion)
//    }
//
//    func listallfood(resource: JCAPIResource, completion: @escaping (APIResponse<FoodList, APIError>) -> Void) {
//
//        fetch(with: resource.request, decode: { json -> FoodList? in
//            guard let data = json as? FoodList else { return  nil }
//            return data
//        }, completion: completion)
//    }
//
//    func searchfooddb(resource: JCAPIResource, completion: @escaping (APIResponse<Searchfooddb, APIError>) -> Void) {
//
//        fetch(with: resource.request, decode: { json -> Searchfooddb? in
//            guard let data = json as? Searchfooddb else { return  nil }
//            return data
//        }, completion: completion)
//    }
//
//    func getFoodServing(resource: JCAPIResource, completion: @escaping (APIResponse<FoodServing, APIError>) -> Void) {
//
//        fetch(with: resource.request, decode: { json -> FoodServing? in
//            guard let data = json as? FoodServing else { return  nil }
//            return data
//        }, completion: completion)
//    }
//
//    func getFoodInfoViaUPCCode(resource: JCAPIResource, completion: @escaping (APIResponse<FoodServing, APIError>) -> Void) {
//
//        fetch(with: resource.request, decode: { json -> FoodServing? in
//            guard let data = json as? FoodServing else { return  nil }
//            return data
//        }, completion: completion)
//    }
//
//    func addSubstitution(resource: JCAPIResource, completion: @escaping (APIResponse<AddSubstitution, APIError>) -> Void) {
//
//        fetch(with: resource.request, decode: { json -> AddSubstitution? in
//            guard let data = json as? AddSubstitution else { return  nil }
//            return data
//        }, completion: completion)
//    }
//
//    func addFoodToLog(resource: JCAPIResource, completion: @escaping (APIResponse<FoodLog, APIError>) -> Void) {
//
//        fetch(with: resource.request, decode: { json -> FoodLog? in
//            guard let data = json as? FoodLog else { return  nil }
//            return data
//        }, completion: completion)
//    }
//
//    func addGroceryFoodToLog(resource: JCAPIResource, completion: @escaping (APIResponse<FoodLog, APIError>) -> Void) {
//
//           fetch(with: resource.request, decode: { json -> FoodLog? in
//               guard let data = json as? FoodLog else { return  nil }
//               return data
//           }, completion: completion)
//       }
//
//    func deleteFood(resource: JCAPIResource, completion: @escaping (APIResponse<DeleteFood, APIError>) -> Void) {
//
//        fetch(with: resource.request, decode: { json -> DeleteFood? in
//            guard let data = json as? DeleteFood else { return  nil }
//            return data
//        }, completion: completion)
//    }

}
