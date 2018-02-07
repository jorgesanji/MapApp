//
//  Save Tracks.swift
//  MapApp
//
//  Created by Jorge Sanmartin on 1/31/18.
//  Copyright © 2018 Jorge Sanmartin. All rights reserved.
//

import Foundation
import RxSwift

protocol SaveTrackUseCase {
	func setParams(_ track: Track) -> SaveTrackUseCase
	func build() -> BaseUseCase<Void>
}

class SaveTrack: BaseUseCase<Void>, SaveTrackUseCase{
	
	private var track:Track?
	
	override func buildUseCaseObservable() -> Observable<Void> {
		return (proxyService?.repository().saveTrack(track: track!))!
	}
	
	func setParams(_ track: Track) -> SaveTrackUseCase {
		self.track = track
		return self
	}
}
