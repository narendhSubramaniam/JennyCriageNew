//
//  MockServices.swift
//  Jenny Craig
//
//  Created by Mobileprogrammingllc on 6/28/18.
//  Copyright © 2018 JennyCraig. All rights reserved.
//

import Foundation

struct MockService {

  static func request< T: Codable>(fileName: String, completion: (APIResponse<T, APIError>) -> Void) {

        jcPrint("Loading Mock CarePlan Data")

        let resource = GenericResource(path: fileName, method: .get, headers: nil, parameters: nil)

        if let url = Bundle.main.url(forResource: resource.path, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let value = try decoder.decode(T.self, from: data)
                 completion(.success(value))
            } catch {
               completion(APIResponse.failure(.requestFailed))
            }
        }
        return  completion(APIResponse.failure(.couldNotDecodeJSON))

    }

}
