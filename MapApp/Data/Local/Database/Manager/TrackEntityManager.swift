//
//  TrackEntityManager.swift
//  MapApp
//
//  Created by Jorge Sanmartin on 1/31/18.
//  Copyright © 2018 Jorge Sanmartin. All rights reserved.
//

import Foundation
import RealmSwift
import MapKit

protocol TrackEntityManagerInterface{
	func getTraks()-> [TrackEntity]
	func saveTrack(_ track:Track)
}

class TrackEntityManager:TrackEntityManagerInterface{
	
	func getTraks()-> [TrackEntity]{
		let realm = try! Realm()
		let result = realm.objects(TrackEntity.self).sorted(byKeyPath: "dateStart", ascending: false)
		var tracks:[TrackEntity]=[]
		for track in result{
			tracks.append(track)
		}
		return tracks
	}
	
	func saveTrack(_ track:Track){
		let realm = try! Realm()
		realm.beginWrite()
		let locationsEnt = List<LocationEntity>()
		for location in track.locations{
			let locationEntity = LocationEntity()
			locationEntity.latitude = location.latitude
			locationEntity.longitude = location.longitude
			locationsEnt.append(locationEntity)
		}
		let trackEntity = TrackEntity()
		trackEntity.dateEnd = track.dateEnd
		trackEntity.dateStart = track.dateStart
		trackEntity.locations = locationsEnt
		realm.add(trackEntity)
		try! realm.commitWrite()
	}
}
