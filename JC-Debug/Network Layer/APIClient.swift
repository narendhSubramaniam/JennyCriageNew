//
//  APIClient.swift
//  JennyCraig
//
//  Created by Mobileprogrammingllc on 6/27/18.
//  Copyright © 2018 JennyCraig. All rights reserved.
//

import Foundation
import UIKit
protocol APIClient {

    var session: URLSession { get }
    func fetch<T: Codable>(with request: URLRequest, decode: @escaping (Codable) -> T?, completion: @escaping (APIResponse<T, APIError>) -> Void)
}

extension APIClient {

    typealias JSONTaskCompletionHandler = (Codable?, APIError?) -> Void
//    typealias FitbitJSONTaskCompletionHandler = (Codable?, FitBitError?) -> Void

    private func decodingTask<T: Codable>(with request: URLRequest, decodingType: T.Type, completionHandler completion: @escaping JSONTaskCompletionHandler) -> URLSessionDataTask {

        let task = session.dataTask(with: request) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse else {
                isSessionLoggedOut = true

                if let errorr = error as NSError? {
                    jcPrint("error is:", errorr)
                    jcPrint(errorr.code)

                    if errorr.code == NSURLErrorNotConnectedToInternet || errorr.code == NSURLErrorNetworkConnectionLost {
                        UIViewController.removeSpinner()
                        return
                    }
                }
                completion(nil, .requestFailed)
                return
            }

            switch httpResponse.statusCode {

            case 500, 501, 502, 503, 504, 505, 506, 507, 508, 509, 510, 511:
                let errorMsg = HTTPURLResponse.localizedString(forStatusCode: httpResponse.statusCode)
                //internal server error part is commented
                //showMaintenanceController(message: errorMsg)
                //completion(nil, nil)
               // completion(nil, .customMessageError(message: errorMsg))
                jcPrint("failed request is:", request)

                DispatchQueue.main.async {

                  showMaintenanceController(message: errorMsg)
                }
            case 401:
                isSessionLoggedOut = true
                completion(nil, nil)
            case 404:
                completion(nil, nil)
            case 200:
                if let data = data {
                    do {

                        let obj  = try? JSONSerialization.jsonObject(with: data, options: [])
                        jcPrint("response from service is:", obj as Any)

                        if let object = obj as? [String: AnyObject] {
                            // do stuff
                            if let error = object["error"] as? Int {
                                if error == 1 {
                                if let message = object["message"] as? String {
                                   completion(nil, .customMessageError(message: message))
                                }
                            }
                        }
                    }

                        let genericModel = try JSONDecoder().decode(decodingType, from: data)
                        completion(genericModel, nil)
                    } catch {
                        completion(nil, .couldNotDecodeJSON)
                    }
                } else {
                    completion(nil, nil)
                }

            default:
                isSessionLoggedOut = true
                completion(nil, .responseUnsuccessful)
            }

        }
        return task
    }

//    private func decodingFitbitTask<T: Codable>(with request: URLRequest, decodingType: T.Type, completionHandler completion: @escaping FitbitJSONTaskCompletionHandler) -> URLSessionDataTask {
//
//        let task = session.dataTask(with: request) { data, response, error in
//            guard let httpResponse = response as? HTTPURLResponse else {
//
//                if let xyz = error as NSError? {
//                    jcPrint("error is:", xyz)
//                    jcPrint(xyz.code)
//                }
//                completion(nil, error as? FitBitError)
//                return
//            }
//
//            if httpResponse.statusCode == 200 {
//                if let data = data {
//                    do {
//
//                        let obj  = try? JSONSerialization.jsonObject(with: data, options: [])
//                        jcPrint("response is:", obj as Any)
//
//                        let genericModel = try JSONDecoder().decode(decodingType, from: data)
//                        completion(genericModel, nil)
//                    } catch {
//                        completion(nil, error as? FitBitError)
//                    }
//                } else {
//                    completion(nil, nil)
//                }
//
//            } else {
//                if let data = data {
//                    do {
//
//                        let obj  = try? JSONSerialization.jsonObject(with: data, options: [])
//                        jcPrint("error response is:", obj as Any)
//
//                        let genericModel = try JSONDecoder().decode(FitBitError.self, from: data)
//                        completion(genericModel, nil)
//                    } catch {
//                        completion(nil, error as? FitBitError)
//                    }
//                } else {
//                    completion(nil, nil)
//                }
//
//            }
//
//        }
//        return task
//    }

    func fetch<T: Codable>(with request: URLRequest, decode: @escaping (Codable) -> T?, completion: @escaping (APIResponse<T, APIError>) -> Void) {

        let task = decodingTask(with: request, decodingType: T.self) { (json, error) in
            // MARK: change to main queue
            DispatchQueue.main.async {
                guard let json = json else {
                    if let error = error {
                        completion(.failure(error))
                    } else {
                        completion(.failure(.invalidData))

                    }
                    return
                }
                if let value = decode(json) {
                    completion(.success(value))
                } else {
                    completion(.failure(.couldNotDecodeJSON))
                }
            }

        }
        task.resume()
    }

//    func fetchFitbit<T: Codable>(with request: URLRequest, decode: @escaping (Codable) -> T?, completion: @escaping (APIResponse<T, FitBitError>) -> Void) {
//
//        let task = decodingFitbitTask(with: request, decodingType: T.self) { (json, error) in
//            // MARK: change to main queue
//            DispatchQueue.main.async {
//                guard let json = json else {
//                    completion(.failure(error!))
//                    return
//                }
//                if let value = decode(json) {
//                    completion(.success(value))
//                } else {
//                    completion(.failure(error!))
//                }
//            }
//
//        }
//        task.resume()
//    }

    func mockRequest< T: Codable>(fileName: String, completion: (APIResponse<T, APIError>) -> Void) {

        jcPrint("Loading Mock CarePlan Data")

        let resource = GenericResource(path: fileName, method: .get, headers: nil, parameters: nil)

        if let url = Bundle.main.url(forResource: resource.path, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                // decoder.keyDecodingStrategy = .convertFromSnakeCase
                let value = try decoder.decode(T.self, from: data)
                completion(.success(value))
            } catch {
                isSessionLoggedOut = true
                completion(.failure(.requestFailed))
            }
        }
        return  completion(.failure(.couldNotDecodeJSON))

    }
}
