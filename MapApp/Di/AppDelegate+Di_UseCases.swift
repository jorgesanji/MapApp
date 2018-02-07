//
//  AppDelegate+Di_UseCases.swift
//  MapApp
//
//  Created by Jorge Sanmartin on 1/31/18.
//  Copyright © 2018 Jorge Sanmartin. All rights reserved.
//

import Foundation

extension AppDelegate{
	
	func injectUseCases(){
		container?.register(GetTracksUseCase.self){ r in GetTracks(proxyService: r.resolve(ProxyServiceInterface.self)!)}
		container?.register(SaveTrackUseCase.self){ r in SaveTrack(proxyService: r.resolve(ProxyServiceInterface.self)!)}
	}
}


