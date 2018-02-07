//
//  RestApiServices.swift
//  MapApp
//
//  Created by Jorge Sanmartin on 1/31/18.
//  Copyright © 2018 Jorge Sanmartin. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper
import RxSwift
import ObjectMapper

class RestApiServices: MapAppRestRepository {
	
	fileprivate var manager: RestApiManagerInterface?
	
	init(manager:RestApiManagerInterface) {
		self.manager = manager
	}
	
	func getTracks(userId: String) -> Observable<[Track]> {
		return (manager?.request(urlRequest: Endpoints.TrackEnd.GetTracks(userId: userId)))!
	}
	
	func saveTrack(track:Track) -> Observable<Void> {
		return (manager?.request(urlRequest: Endpoints.TrackEnd.SaveTrack(track: track)))!
	}
}
