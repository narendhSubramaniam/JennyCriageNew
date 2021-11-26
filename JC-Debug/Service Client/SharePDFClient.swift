//  SharePDFClient.swift
//  JennyCraig
//  Created by Mobileprogrammingllc on 9/15/18.
//  Copyright © 2018 JennyCraig. All rights reserved.

import UIKit

class SharePDFClient: APIClient {

    var session: URLSession

    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }

    convenience init() {
        self.init(configuration: .default)
    }

//    func getSharePdfUrl(resource: JCAPIResource, completion: @escaping (APIResponse<SharePDFModel, APIError>) -> Void) {
//
//        fetch(with: resource.request, decode: { json -> SharePDFModel? in
//            guard let data = json as? SharePDFModel else { return  nil }
//            return data
//        }, completion: completion)
//    }

}
