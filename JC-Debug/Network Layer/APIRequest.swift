//
//  NetworkService.swift
//  Jenny Craig
//
//  Created by Mobileprogrammingllc on 6/27/18.
//  Copyright © 2018 JennyCraig. All rights reserved.
//

import Foundation

public enum ServiceType: String {
    case mock = "Mock"
    case realServer = "RealServer"
    //Others
    public static let allCases = [ mock, realServer]
}

//http method type
enum RESTMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

//Defines the encoding of data is from url or from existing json
enum ParameterEncodingType {

    case URL
    case JSON
}

//defines the service request configuration

protocol JCAPIResource {

    init(path: String, method: RESTMethod, headers: [String: String]?, parameters: [String: Any]?, encoding: ParameterEncodingType)

    var serviceType: ServiceType { get }

    var basePath: String { get set}

    var path: String { get }

    var method: RESTMethod { get }
    /**
     Authorization is usually set in the headers. You can set this to `[:]` if you don't have any
     headers to set. You can also create an extention on Endpoint to also have
     this default to a value.
     */
    var headers: [String: String]? { get }
    /**
     By default this will be set to empty - body()
     */
    var parameters: [String: Any]? { get }

    //By default, encoding will be set to URLEncoding for GET requests
    //and JSONEncoding for everything else.
    var encoding: ParameterEncodingType { get }

    // sending username for ConfirmSighnup
    var usernameForSignUp: String? { get }

    // sending username for changeUsername
    var usernameForSetting: String? { get }

}

extension JCAPIResource {

    var serviceType: ServiceType {

        return .mock
    }

    var basePath: String {

        return JCConfigEndPoints.shared.appMode.baseEndPoint()!
    }
    var basePathDNA: String {

           return JCConfigEndPoints.shared.appMode.baseEndPointDNA()!
       }

    var basePathFitbit: String {

        return "https://api.fitbit.com/"
    }
    var baseHeader: String {

        return JCConfigEndPoints.shared.appMode.baseHeader()!
    }

    var encoding: ParameterEncodingType {

        return method == .get ? .URL : .JSON
    }

    var urlComponents: URLComponents {

        var finalPath = basePath + path

        if path == "oauth2/token" {
            finalPath = basePathFitbit + path
        }
        let urlString: String = finalPath.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
        let components = URLComponents(string: urlString)!
        //components.path = finalPath
        return components
    }

    func body() -> Data? {
        guard parameters != nil else { return nil }
        switch (encoding) {
        case .JSON:
            return try? JSONSerialization.data(withJSONObject: parameters!)
        default:
            return nil
        }
    }

    var request: URLRequest {
        let url = urlComponents.url!
        var request = URLRequest(url: url)
        request.httpMethod = self.method.rawValue

        let token = AuthController.getToken()
        if token.count > 0 {

            //default headerField for token
            request.allHTTPHeaderFields = ["Content-Type": "application/json; charset=utf-8", "x-api-key": baseHeader, "Authorization": token ]

            if path == "oauth2/token" {

                let fitbitClientID = JCConfigEndPoints.shared.appMode.fitBitClientID()!
                let fitbitClientSecretKey = JCConfigEndPoints.shared.appMode.fitBitClientSecret()
                let concatenatedClientIDAndSecretKey = fitbitClientID + ":" + fitbitClientSecretKey!
                request.setValue(nil, forHTTPHeaderField: "x-api-key")
                request.allHTTPHeaderFields = ["Content-Type": "application/x-www-form-urlencoded", "Authorization": "Basic " + concatenatedClientIDAndSecretKey.toBase64()!]

            } else if path == "newuser/sonicregistrationnew" || path == "newuser/signinnew" {
                request.allHTTPHeaderFields = ["Content-Type": "application/json; charset=utf-8", "x-api-key": baseHeader, "Authorization": token, "x-mp-new-email": AuthController.getUserName()! ]
            } else if path == "newuser/updatesetting" {
                if let username = usernameForSetting {
                    request.allHTTPHeaderFields = ["Content-Type": "application/json; charset=utf-8", "x-api-key": baseHeader, "x-mp-new-email": username, "Authorization": token ]
                }
            } else if let username = usernameForSignUp {
                request.allHTTPHeaderFields = ["Content-Type": "application/json; charset=utf-8", "x-api-key": baseHeader, "x-mp-user-email": username, "Authorization": token ]
            }

        }
        request.httpBody = self.body()
        //request.allHTTPHeaderFields = self.headers
        jcPrint("url :: \(url)")

        jcPrint("Parameters :: \(String(describing: self.parameters))")
        jcPrint("Method :: \(self.method)")

        return request
    }
}

struct GenericResource: JCAPIResource {

    var usernameForSignUp: String?
    var usernameForSetting: String?

    var basePath: String = JCConfigEndPoints.shared.appMode.baseEndPoint()!

    var basePathDNA: String = JCConfigEndPoints.shared.appMode.baseEndPointDNA()!

    init(path: String, method: RESTMethod, headers: [String: String]?, parameters: [String: Any]?, encoding: ParameterEncodingType) {
        self.path = path
        self.method = method
        self.headers = headers
        self.parameters = parameters
        self.encoding = encoding
    }

    var path: String

    let method: RESTMethod
    let headers: [String: String]?
    let parameters: [String: Any]?
    let encoding: ParameterEncodingType

    init(path: String,
         method: RESTMethod = .post,
         headers: [String: String]? = nil,
         parameters: [String: Any]? = nil, encoding: ParameterEncodingType = .JSON, basePat: String? = nil) {

        self.path = path
        self.method = method
        self.headers = headers
        self.parameters = parameters
        self.encoding = encoding
        if basePat != nil {
            basePath = basePat!
        }

    }
}

// MARK: - Equatable
extension GenericResource: Equatable {}

func == (lhs: GenericResource, rhs: GenericResource) -> Bool {
    return lhs.path == rhs.path &&
        lhs.method == rhs.method &&
        lhs.headers! == rhs.headers! &&
        lhs.encoding == rhs.encoding
}
