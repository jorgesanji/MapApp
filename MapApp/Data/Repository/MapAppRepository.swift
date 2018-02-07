//
//  MapAppRepository.swift
//  MapApp
//
//  Created by Jorge Sanmartin on 1/31/18.
//  Copyright © 2018 Jorge Sanmartin. All rights reserved.
//

import Foundation
import RxSwift

protocol MapAppRepository : class{
	
	func getTracks(userId:String) -> Observable<[Track]>
	func saveTrack(track:Track) -> Observable<Void>
}

protocol MapAppRestRepository : MapAppRepository{}

protocol MapAppLocalRepository : MapAppRepository {}
