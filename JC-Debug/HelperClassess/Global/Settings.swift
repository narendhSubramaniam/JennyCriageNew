//  Settings.swift
//  JennyCraig
//  Created by Mobileprogrammingllc on 7/8/18.
//  Copyright © 2018 JennyCraig. All rights reserved.

import Foundation

final class Settings {

  private enum Keys: String {
    case user = "current_user"
  }

  static var currentUser: UserInfo? {
    get {
      guard let data = UserDefaults.standard.data(forKey: Keys.user.rawValue) else {
        return nil
      }
      return try? JSONDecoder().decode(UserInfo.self, from: data)
    }
    set {
      if let data = try? JSONEncoder().encode(newValue) {
        UserDefaults.standard.set(data, forKey: Keys.user.rawValue)
      } else {
        UserDefaults.standard.removeObject(forKey: Keys.user.rawValue)
      }
      UserDefaults.standard.synchronize()
    }
  }

}
