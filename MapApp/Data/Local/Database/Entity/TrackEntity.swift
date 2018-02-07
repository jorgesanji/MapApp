//
//  TrackEntity.swift
//  MapApp
//
//  Created by Jorge Sanmartin on 1/31/18.
//  Copyright © 2018 Jorge Sanmartin. All rights reserved.
//

import Foundation
import RealmSwift

class TrackEntity:Object{
	
	var locations = List<LocationEntity>()
	@objc dynamic var dateStart:Date? = nil
	@objc dynamic var dateEnd:Date? = nil

}
