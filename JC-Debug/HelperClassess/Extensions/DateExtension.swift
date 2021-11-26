//  DateExtension.swift
//  JennyCraig
//  Created by Mobileprogrammingllc on 7/16/18.
//  Copyright © 2018 JennyCraig. All rights reserved.

import Foundation

extension Date {

    // returns month in string
    func monthAsString() -> String {
        let dateformatter = DateFormatter()
        dateformatter.setLocalizedDateFormatFromTemplate("MMM")
        return dateformatter.string(from: self)
    }

    func dayNameAsString() -> String {
        let dateformatter = DateFormatter()
        dateformatter.setLocalizedDateFormatFromTemplate("EEEEEE")
        return dateformatter.string(from: self)
    }

    func monthAsNumeric() -> String {
        let dateformatter = DateFormatter()
        dateformatter.setLocalizedDateFormatFromTemplate("mmm")
        return dateformatter.string(from: self)
    }

    func yearAsString() -> String? {
        let dateformatter = DateFormatter()
        dateformatter.setLocalizedDateFormatFromTemplate("YYYY")
        return dateformatter.string(from: self)
    }

    func dayNumberAsString() -> String {
        let dateformatter = DateFormatter()
        dateformatter.setLocalizedDateFormatFromTemplate("dd")
        let day = dateformatter.string(from: self)

        switch day {
        case "01":
            return "1"
        case "02":
            return "2"
        case "03":
            return "3"
        case "04":
            return "4"
        case "05":
            return "5"
        case "06":
            return "6"
        case "07":
            return "7"
        case "08":
            return "8"
        case "09":
            return "9"
        default:
            return day
        }
    }

    /// Returns a Date with the specified days added to the one it is called with
    func addDate(years: Int = 0, months: Int = 0, days: Int = 0, hours: Int = 0, minutes: Int = 0, seconds: Int = 0) -> Date {
        var targetDay: Date
        targetDay = Calendar.current.date(byAdding: .day, value: days, to: self)!
        return targetDay
    }

    func addYearsToDate(years: Int = 0) -> Date {
        var targetDay: Date
        targetDay = Calendar.current.date(byAdding: .year, value: years, to: self)!
        return targetDay
    }

    /// Returns a Date with the specified days subtracted from the one it is called with
    func subtract(years: Int = 0, months: Int = 0, days: Int = 0, hours: Int = 0, minutes: Int = 0, seconds: Int = 0) -> Date {
        let inverseYears = -1 * years
        let inverseMonths = -1 * months
        let inverseDays = -1 * days
        let inverseHours = -1 * hours
        let inverseMinutes = -1 * minutes
        let inverseSeconds = -1 * seconds
        return addDate(years: inverseYears, months: inverseMonths, days: inverseDays, hours: inverseHours, minutes: inverseMinutes, seconds: inverseSeconds)
    }

    /// Returns a string from date with specfic format
    func stringFromDate(with format: String) -> String {

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }

    func offsetMinutesFrom(date: Date) -> Int {

        let dayHourMinuteSecond: Set<Calendar.Component> = [.day, .hour, .minute, .second]
        let difference = NSCalendar.current.dateComponents(dayHourMinuteSecond, from: date, to: self)

        //        let seconds = "\(difference.second ?? 0)s"
        //        let minutes = "\(difference.minute ?? 0)m" + " " + seconds
        //        let hours = "\(difference.hour ?? 0)h" + " " + minutes
        //        let days = "\(difference.day ?? 0)d" + " " + hours

        //        if let day = difference.day, day          > 0 { return days }
        //        if let hour = difference.hour, hour       > 0 { return hours }
        return  difference.minute!

        //        if let second = difference.second, second > 0 { return seconds }
    }

    /// Returns the amount of years from another date
    func years(from date: Date) -> Int {
        return Calendar.current.dateComponents([.year], from: date, to: self).year ?? 0
    }

    /// Returns the amount of months from another date
    func months(from date: Date) -> Int {
        return Calendar.current.dateComponents([.month], from: date, to: self).month ?? 0
    }

    /// Returns the amount of weeks from another date
    func weeks(from date: Date) -> Int {
        return Calendar.current.dateComponents([.weekOfMonth], from: date, to: self).weekOfMonth ?? 0
    }

    /// Returns the amount of days from another date
    func days(from date: Date) -> Int {
        return Calendar.current.dateComponents([.day], from: date, to: self).day ?? 0
    }
    /// Returns the amount of hours from another date
    func hours(from date: Date) -> Int {
        return Calendar.current.dateComponents([.hour], from: date, to: self).hour ?? 0
    }

    /// Returns the amount of minutes from another date
    func minutes(from date: Date) -> Int {
        return Calendar.current.dateComponents([.minute], from: date, to: self).minute ?? 0
    }

    /// Returns the amount of seconds from another date
    func seconds(from date: Date) -> Int {
        return Calendar.current.dateComponents([.second], from: date, to: self).second ?? 0
    }

    /// Returns the amount of nanoseconds from another date
    func nanoseconds(from date: Date) -> Int {
        return Calendar.current.dateComponents([.nanosecond], from: date, to: self).nanosecond ?? 0
    }

    /// Returns the a custom time interval description from another date
    func offset(from date: Date) -> String {
        //            if years(from: date)   > 0 { return "\(years(from: date))y"   }
        //            if months(from: date)  > 0 { return "\(months(from: date))M"  }
        //            if weeks(from: date)   > 0 { return "\(weeks(from: date))w"   }
        if days(from: date)    > 0 { return "\(days(from: date))d"    }
        //            if hours(from: date)   > 0 { return "\(hours(from: date))h"   }
        //            if minutes(from: date) > 0 { return "\(minutes(from: date))m" }
        //            if seconds(from: date) > 0 { return "\(seconds(from: date))s" }
        //            if nanoseconds(from: date) > 0 { return "\(nanoseconds(from: date))ns" }
        return "0"
    }

    var dayOfWeek: String {
        let calendar = Calendar.current
        return calendar.shortWeekdaySymbols[calendar.component(.weekday, from: self) - 1]
    }

    func compareDate(date2: Date) -> Bool {
        let order = Calendar.current.compare(self, to: date2, toGranularity: .day)
        switch order {
        case .orderedSame:
            return true
        default:
            return false
        }
    }

    func isGreaterThan(date2: Date, granularity: Calendar.Component) -> Bool {
        let order = Calendar.current.compare(self, to: date2, toGranularity: granularity)
        switch order {

        case .orderedDescending:
            return true
        case .orderedAscending:
            return false
        case .orderedSame:
            return false
        }
    }

    init(dateString: String) {
        let dateStringFormatter = DateFormatter()
        dateStringFormatter.dateFormat = "yyyy-MM-dd"
        dateStringFormatter.locale = Locale(identifier: "en_US_POSIX")
        let date = dateStringFormatter.date(from: dateString)!
        self.init(timeInterval: 0, since: date)
    }

    func isBetween(_ date1: Date, and date2: Date) -> Bool {
        return (min(date1, date2) ... max(date1, date2)).contains(self)
    }

    func removeTimeStamp() -> Date {
        guard let date = Calendar.current.date(from: Calendar.current.dateComponents([.year, .month, .day], from: self)) else {
            fatalError("Failed to strip time from Date object")
        }
        return date
    }

    func getDaysInMonth() -> Int {
        let calendar = Calendar.current

        let dateComponents = DateComponents(year: calendar.component(.year, from: self), month: calendar.component(.month, from: self))
        let date = calendar.date(from: dateComponents)!

        let range = calendar.range(of: .day, in: .month, for: date)!
        let numDays = range.count

        return numDays
    }

    func getFormattedCurrentDateString() -> String {
        let dateString = (self.stringFromDate(with: Identifiers.yyyyMMddHHmmssFormatter))
        let dateArray = dateString.components(separatedBy: " ")
        let date = dateArray[0]
        let time = dateArray[1]
        let timeComponent = time.components(separatedBy: ":")
        let timeComponent1 = timeComponent[0]
        let timeComponent2 = timeComponent[1]
        return date + " " + timeComponent1 + ":" + timeComponent2 + ":" + "00"
    }

    func getFormattedCalorieDateString(with format: String) -> String {

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale?
        let calorieDateString = dateFormatter.string(from: self)
        //let calorieDateString = dateFormatter.string(from: self.viewPickerView.isHidden ? Date() : date)
        let firstCaloriedateArray = calorieDateString.components(separatedBy: " ")
        let firstCaloriedate = firstCaloriedateArray[0]
        let firstCalorietime = firstCaloriedateArray[1]
        let firstCalorietimeComponent = firstCalorietime.components(separatedBy: ":")
        let firstCalorietimeComponent1 = firstCalorietimeComponent[0]
        let firstCalorietimeComponent2 = firstCalorietimeComponent[1]
        let formattedString = firstCaloriedate + " " + firstCalorietimeComponent1 + ":" + firstCalorietimeComponent2 + ":" + "00"

        return formattedString
    }

    func startOfDay() -> Date {
        return Calendar.current.startOfDay(for: self)
    }

    func endOfDay() -> Date {
        var components = DateComponents()
        components.day = 1
        components.second = -1
        return Calendar.current.date(byAdding: components, to: self)!
    }

    func pickerDate() -> Date {

        return Calendar.current.date(bySettingHour: Calendar.current.component(.hour, from: Date()), minute: Calendar.current.component(.minute, from: Date()), second: Calendar.current.component(.second, from: Date()), of: self)!
    }

}
