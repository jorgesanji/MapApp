//
//  Location.swift
//  MapApp
//
//  Created by Jorge Sanmartin on 1/31/18.
//  Copyright © 2018 Jorge Sanmartin. All rights reserved.
//

import Foundation
import ObjectMapper

struct Location{
	
	var latitude = 0.0
	var longitude = 0.0
}

extension Location : Mappable{
	
	init?(map: Map) {
	}
	
	mutating func mapping(map: Map) {
		latitude <- map["latitude"]
		longitude <- map["longitude"]
	}
}
