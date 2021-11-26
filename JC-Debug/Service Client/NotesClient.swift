//
//  NotesClient.swift
//  JennyCraig
//
//  Created by Mobileprogrammingllc on 15/02/21.
//  Copyright © 2021 JennyCraig. All rights reserved.
//

import UIKit

class NotesClient: APIClient {

    var session: URLSession

    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }

    convenience init() {
        self.init(configuration: .default)
    }

//    func updateNotes(resource: JCAPIResource, completion: @escaping (APIResponse<NotesModel, APIError>) -> Void) {
//
//        fetch(with: resource.request, decode: { json -> NotesModel? in
//            guard let data = json as? NotesModel else { return  nil }
//            return data
//        }, completion: completion)
//    }

}
