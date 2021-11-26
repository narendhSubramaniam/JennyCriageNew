//
//  SelfMonitorClient.swift
//  JennyCraig
//
//  Created by Mobileprogrammingllc on 7/11/18.
//  Copyright © 2018 JennyCraig. All rights reserved.
//

import Foundation

class SelfMonitorClient: APIClient {

    var session: URLSession

    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }

    convenience init() {
        self.init(configuration: .default)
    }

//    func fetchFoodItemsMenuData(resource: JCAPIResource, completion: @escaping (APIResponse<MenuFoodItems, APIError>) -> Void) {
//
//        fetch(with: resource.request, decode: { json -> MenuFoodItems? in
//
//            guard let data = json as? MenuFoodItems else { return  nil }
//
//            return data
//
//        }, completion: completion)
//
//    }
//
//    func fetchDietPlanSubMenuData(resource: JCAPIResource, completion: @escaping (APIResponse<DietPlanSubMenu, APIError>) -> Void) {
//
//        fetch(with: resource.request, decode: { json -> DietPlanSubMenu? in
//            guard let data = json as? DietPlanSubMenu else { return  nil }
//            return data
//        }, completion: completion)
//
//    }
//
//    func fetchDietPlanMenuData(resource: JCAPIResource, completion: @escaping (APIResponse<DietPlanMenu, APIError>) -> Void) {
//
//            fetch(with: resource.request, decode: { json -> DietPlanMenu? in
//                guard let data = json as? DietPlanMenu else { return  nil }
//                return data
//            }, completion: completion)
//
//    }
//
//    func addFoodItems(resource: JCAPIResource, completion: @escaping (APIResponse<SaveFoodMenu, APIError>) -> Void) {
//
//        fetch(with: resource.request, decode: { json -> SaveFoodMenu? in
//            guard let data = json as? SaveFoodMenu else { return  nil }
//            return data
//        }, completion: completion)
//
//    }
//
//    func saveUserCalendar(resource: JCAPIResource, completion: @escaping (APIResponse<UserCalendarModel, APIError>) -> Void) {
//
//        fetch(with: resource.request, decode: { json -> UserCalendarModel? in
//            guard let data = json as? UserCalendarModel else { return  nil }
//            return data
//        }, completion: completion)
//    }
}
