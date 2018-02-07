//
//  Track.swift
//  MapApp
//
//  Created by Jorge Sanmartin on 1/31/18.
//  Copyright © 2018 Jorge Sanmartin. All rights reserved.
//

import Foundation
import ObjectMapper

struct Track{
	var locations:[Location] = []
	var dateStart:Date? = nil
	var dateEnd:Date? = nil
}

extension Track : Mappable{
	
	init?(map: Map) {
	}
	
	mutating func mapping(map: Map) {
		locations <- map["location"]
		dateStart <- map["dateStart"]
		dateEnd <- map["dateEnd"]
	}
}
