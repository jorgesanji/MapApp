//
//  GetTracks.swift
//  MapApp
//
//  Created by Jorge Sanmartin on 1/31/18.
//  Copyright © 2018 Jorge Sanmartin. All rights reserved.
//

import Foundation
import RxSwift

protocol GetTracksUseCase {
	func setParams(_ userId:String) -> GetTracksUseCase
	func build() -> BaseUseCase<[Track]>
}

class GetTracks: BaseUseCase<[Track]>, GetTracksUseCase{
	
	private var userId:String = ""
	
	override func buildUseCaseObservable() -> Observable<[Track]> {
		return (proxyService?.repository().getTracks(userId: userId))!
	}

	func setParams(_ userId: String) -> GetTracksUseCase {
		self.userId = userId
		return self
	}
}
