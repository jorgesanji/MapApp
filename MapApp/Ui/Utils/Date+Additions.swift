//
//  Date+Additions.swift
//  MapApp
//
//  Created by Jorge Sanmartin on 1/31/18.
//  Copyright © 2018 Jorge Sanmartin. All rights reserved.
//

import Foundation

let ALL_DATE_FORMAT :String = "MMMM dd, yyyy - HH:mm:ss"
let MEDIUN_DATE_FORMAT :String = "mm/dd/yyyy" // 01/14/1985
let SMALL_DATE_FORMAT :String = "MMM yyyy"

extension Date{
	
	var calendar:Calendar {
		return Calendar.current
	}
	
	var ticks: UInt64 {
		return UInt64((self.timeIntervalSince1970 + 62_135_596_800) * 10_000_000)
	}
	
	var timeStamp: Int64 {
		return Int64(self.timeIntervalSince1970 * 1000)
	}
	
	func years(from date: Date) -> Int {
		return calendar.dateComponents([.year], from: date, to: self).year ?? 0
	}
	
	func months(from date: Date) -> Int {
		return calendar.dateComponents([.month], from: date, to: self).month ?? 0
	}
	
	func weeks(from date: Date) -> Int {
		return calendar.dateComponents([.weekOfYear], from: date, to: self).weekOfYear ?? 0
	}
	
	func days(from date: Date) -> Int {
		return calendar.dateComponents([.day], from: date, to: self).day ?? 0
	}
	
	func hours(from date: Date) -> Int {
		return calendar.dateComponents([.hour], from: date, to: self).hour ?? 0
	}
	
	func minutes(from date: Date) -> Int {
		return calendar.dateComponents([.minute], from: date, to: self).minute ?? 0
	}
	
	func seconds(from date: Date) -> Int {
		return calendar.dateComponents([.second], from: date, to: self).second ?? 0
	}
	
	var messageTime: String {
		let now = Date()
		if now.years(from: self)   > 0 {
			return now.years(from: self).description  + " year"  + { return now.years(from: self)   > 1 ? "s" : "" }() + " ago"
		}
		if now.months(from: self)  > 0 {
			return now.months(from: self).description + " month" + { return now.months(from: self)  > 1 ? "s" : "" }() + " ago"
		}
		if now.weeks(from:self)   > 0 {
			return now.weeks(from: self).description  + " week"  + { return now.weeks(from: self)   > 1 ? "s" : "" }() + " ago"
		}
		if now.days(from: self)    > 0 {
			if now.days(from:self) == 1 { return "Yesterday" }
			return now.days(from: self).description + " days ago"
		}
		if now.hours(from: self)   > 0 {
			return "\(now.hours(from: self)) hour"     + { return now.hours(from: self)   > 1 ? "s" : "" }() + " ago"
		}
		if now.minutes(from: self) > 0 {
			return "\(now.minutes(from: self)) minute" + { return now.minutes(from: self) > 1 ? "s" : "" }() + " ago"
		}
		if now.seconds(from: self) >= 0 {
			if now.seconds(from: self) < 15 { return "Just now"  }
			return "\(now.seconds(from: self)) second" + { return now.seconds(from: self) > 1 ? "s" : "" }() + " ago"
		}
		return ""
	}
	
	var trackTime: String {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "MMMM yyyy"
		let now = Date()
		if now.years(from: self)   > 0 {
			dateFormatter.dateFormat = "MMMM dd, yyyy"
			return dateFormatter.string(from: self)
		}
		if now.months(from: self)  > 0 {
			return dateFormatter.string(from: self)
		}
		if now.weeks(from:self)   > 0 {
			return dateFormatter.string(from: self)
		}
		if now.days(from: self)    > 0 {
			if now.days(from:self) == 1 { return "Yesterday" }
			return now.days(from: self).description + " days ago"
		}
		if now.hours(from: self)   > 0 {
			return "\(now.hours(from: self)) hour"     + { return now.hours(from: self)   > 1 ? "s" : "" }() + " ago"
		}
		if now.minutes(from: self) > 0 {
			return "\(now.minutes(from: self)) minute" + { return now.minutes(from: self) > 1 ? "s" : "" }() + " ago"
		}
		if now.seconds(from: self) >= 0 {
			if now.seconds(from: self) < 15 { return "Just now"  }
			return "\(now.seconds(from: self)) second" + { return now.seconds(from: self) > 1 ? "s" : "" }() + " ago"
		}
		return ""
	}
	
	var long:String{
		let dateFormatter = DateFormatter()
		dateFormatter.dateStyle = .long
		return dateFormatter.string(from: self)
	}
	
	var full:String{
		let dateFormatter = DateFormatter()
		dateFormatter.dateStyle = .full
		return dateFormatter.string(from: self)
	}
	
	var small:String{
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = SMALL_DATE_FORMAT
		return dateFormatter.string(from: self)
	}
	
	var trackDate:String{
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = ALL_DATE_FORMAT
		return dateFormatter.string(from: self)
	}
	
	static func fromMillis(millis: Int64?) -> Date? {
		return millis.map() { number in Date(timeIntervalSince1970: Double(number) / 1000)}
	}
}

