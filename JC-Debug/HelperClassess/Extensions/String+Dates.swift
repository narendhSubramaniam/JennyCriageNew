//AuthenticationController.swift
//  JennyCraig
//  Created by Mobileprogrammingllc on 3/17/20.
//  Copyright © 2018 JennyCraig. All rights reserved.

import UIKit

extension String {
	func date(withFormat format: String = "yyyy-MM-dd") -> Date? {
		let formatter = DateFormatter()
		formatter.dateFormat = format
		return formatter.date(from: self)
	}

	func dateComponents(withFormat format: String = "yyyy-MM-dd", components: Set<Calendar.Component> = [.day, .month, .year]) -> DateComponents? {
		return self.date(withFormat: format)?.dateComponents(components: components)
	}
}

extension Date {
	func dateComponents(components: Set<Calendar.Component> = [.day, .month, .year]) -> DateComponents {
		let calendar = Calendar.current
		return calendar.dateComponents(components, from: self)
	}

	func dateString(withFormat format: String = "yyyy-MM-dd") -> String {
		let formatter = DateFormatter()
		formatter.dateFormat = format
		return formatter.string(from: self)
	}
}
