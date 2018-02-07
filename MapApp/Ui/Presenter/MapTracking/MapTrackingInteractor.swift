//
//  MapTrackingInteractor.swift
//  MapApp
//
//  Created by Jorge Sanmartin on 1/31/18.
//  Copyright © 2018 Jorge Sanmartin. All rights reserved.
//

import Foundation

protocol MapTrackingInteractorOut:InteractorOut{
	func didSaveTrack()
	func didObtainErrorSavingTrack()
}

protocol MapTrackingInteractorIn:InteractorIn{
	
	func saveTrack(track:Track)
}

class MapTrackingInteractor:BaseInteractor{
	
	fileprivate var saveTrackUC:SaveTrackUseCase?
	
	init(interactorOut:MapTrackingInteractorOut, saveTrack:SaveTrackUseCase) {
		super.init()
		Logger.log("MapTrackingInteractor init")
		self.interactorOut = interactorOut
		self.saveTrackUC = saveTrack
	}
}

extension MapTrackingInteractor:MapTrackingInteractorIn{
	
	func saveTrack(track: Track) {
		saveTrackUC?.setParams(track).build().subscribe({ (void) in
			(self.interactorOut as! MapTrackingInteractorOut).didSaveTrack()
		}, onError: { (error) in
			(self.interactorOut as! MapTrackingInteractorOut).didObtainErrorSavingTrack()
		})
	}
}
