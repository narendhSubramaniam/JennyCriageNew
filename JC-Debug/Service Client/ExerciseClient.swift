//
//  ExerciseClient.swift
//  JennyCraig
//
//  Created by Mobileprogrammingllc on 7/17/18.
//  Copyright © 2018 JennyCraig. All rights reserved.
//

import Foundation

class ExerciseClient: APIClient {

    var session: URLSession

    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }

    convenience init() {
        self.init(configuration: .default)
    }

//    func updateExercise(resource: JCAPIResource, completion: @escaping (APIResponse<ExerciseResponse, APIError>) -> Void) {
//
//        fetch(with: resource.request, decode: { json -> ExerciseResponse? in
//            guard let data = json as? ExerciseResponse else { return  nil }
//            return data
//        }, completion: completion)
//
//    }
//
//    func favoriteExercise(resource: JCAPIResource, completion: @escaping (APIResponse<ExerciseResponse, APIError>) -> Void) {
//
//        fetch(with: resource.request, decode: { json -> ExerciseResponse? in
//            guard let data = json as? ExerciseResponse else { return  nil }
//            return data
//        }, completion: completion)
//
//    }
//
//    func fetchExerciseList(resource: JCAPIResource, completion: @escaping (APIResponse<ExerciseResponse, APIError>) -> Void) {
//
//        fetch(with: resource.request, decode: { json -> ExerciseResponse? in
//            guard let data = json as? ExerciseResponse else { return  nil }
//            return data
//        }, completion: completion)
//
//    }
}
