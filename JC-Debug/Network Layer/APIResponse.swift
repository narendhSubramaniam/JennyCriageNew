//
//  APIResponse.swift
//  Jenny Craig
//
//  Created by Mobileprogrammingllc on 6/27/18.
//  Copyright © 2018 JennyCraig. All rights reserved.
//

import Foundation

internal enum APIResponse<T, U> where U: Error {

    case success(T?)
    case failure(U)
    case uninitialize

    /// Returns `true` if the result is a success, `false` otherwise.
    public var isSuccess: Bool {
        switch self {
        case .success:
            return true
        case .failure:
            return false
        case .uninitialize:
            return false
        }
    }

    /// Returns `true` if the result is a failure, `false` otherwise.
    public var isFailure: Bool {
        return !isSuccess
    }

    /// Returns the associated value if the result is a success, `nil` otherwise.
    public var value: T? {
        switch self {
        case .success(let T):
            return T
        case .failure:
            return nil
        case .uninitialize:
            return nil
        }
    }

    /// Returns the associated error value if the result is a failure, `nil` otherwise.
    public var error: U? {
        switch self {
        case .success:
            return nil
        case .failure(let error):
            return error
        case .uninitialize:
            return nil
        }
    }
}

enum APIError: Error {

    case couldNotDecodeJSON
    case badStatus(status: Int)
    case other(Error)
    case customMessageError(message: String)
    case requestFailed
    case invalidData
    case responseUnsuccessful
    case notFound
    case notFound500
    case sessionLoggedOut

}

/*
 extension APIError: CustomDebugStringConvertible {
 var debugDescription: String {
 switch self {
 case .CouldNotDecodeJSON:
 return "Could not decode JSON"
 case let .BadStatus(status):
 return "Bad status \(status)"
 case .RequestFailed :
 return "Request Failed"
 case .InvalidData :
 return "Invalid Data"
 case .ResponseUnsuccessful :
 return "Could not connect to server"
 case let .Other(error):
 return "\(error)"
 case let .CustomMessageError(message):
 return "\(message)"
 }
 }
 }
 */

extension APIError: CustomDebugStringConvertible {

    var debugDescription: String {

        //return "" /* Why is this required ? */

        switch self {

        case .couldNotDecodeJSON:

            return "Something went wrong on our end. Please try back in a bit."

        case let .badStatus(status):

            return "Bad status \(status)"

        case .requestFailed:

            return Identifiers.Message.NoInternetConnectivity

        case .responseUnsuccessful:

            return "Something went wrong on our end. Please try back in a bit"

        case .invalidData :

            //return "Invalid Data"
            return "Something went wrong on our end. Please try back in a bit"

        case .notFound:

            return "Not Found"

        case .notFound500:

            return "Not Found."

        case .sessionLoggedOut:

            return ""

        case let .other(error):

            return "\(error)"

        case let .customMessageError(message):

            return "\(message)"

        }

    }

}

protocol ResponseData {

    var error: Int? {get set}
    var message: String? {get set}
    var messageType: String? {get set}
    var successful: Int? {get set}
}

extension ResponseData {

    var isSuccess: Bool {

        return successful == 0 ? false : true
    }

}
