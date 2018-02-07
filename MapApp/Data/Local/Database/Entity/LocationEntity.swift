//
//  LocationEntity.swift
//  MapApp
//
//  Created by Jorge Sanmartin on 1/31/18.
//  Copyright © 2018 Jorge Sanmartin. All rights reserved.
//

import Foundation
import RealmSwift
import MapKit

class LocationEntity:Object{
	
	@objc dynamic var latitude = 0.0
	@objc dynamic var longitude = 0.0
}

extension LocationEntity{
	
	var coordinate:CLLocation{
		return CLLocation(latitude:latitude, longitude:longitude)
	}
}
