//
//  MapAppLocalRepository.swift
//  MapApp
//
//  Created by Jorge Sanmartin on 1/31/18.
//  Copyright © 2018 Jorge Sanmartin. All rights reserved.
//

import Foundation
import RxSwift
import MapKit

let deflocalError = AppError(statusCode: -1, code: -1, message: unknown_error)

class LocalRepository : MapAppLocalRepository{
	
	fileprivate var manager: TrackEntityManagerInterface?
	
	init(manager:TrackEntityManagerInterface) {
		self.manager = manager
	}
	
	func getTracks(userId:String) ->  Observable<[Track]> {
		return Observable<[Track]>.create({ (observer) -> Disposable in
			let trackEntities = self.manager?.getTraks()
			var tracks:[Track] = []
			for trackEntity in trackEntities!{
				var track = Track()
				track.dateStart = trackEntity.dateStart
				track.dateEnd = trackEntity.dateEnd
				var locations:[Location]=[]
				for locationEntity in trackEntity.locations{
					var location = Location()
					location.latitude = locationEntity.latitude
					location.longitude = locationEntity.longitude
					locations.append(location)
				}
				track.locations = locations
				tracks.append(track)
			}
			observer.onNext(tracks)
			return Disposables.create()
		})
	}
	
	func saveTrack(track:Track) -> Observable<Void> {
		return Observable<Void>.create({ (observer) -> Disposable in
			self.manager?.saveTrack(track)
			observer.onNext(())
			return Disposables.create()
		})
	}
}
