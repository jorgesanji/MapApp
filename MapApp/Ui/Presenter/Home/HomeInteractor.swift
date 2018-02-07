//
//  SplashInteractor.swift
//  MapApp
//
//  Created by Jorge Sanmartin on 1/31/18.
//  Copyright © 2018 Jorge Sanmartin. All rights reserved.
//

import Foundation

protocol HomeInteractorOut:InteractorOut{
	func didObtainTracks(_ tracks:[Track])
	func didObtainError(_ error:Error)
}

protocol HomeInteractorIn:InteractorIn{
	func getTracks(userId:String)
}

class HomeInteractor:BaseInteractor{
	
	private var getTracksUC:GetTracksUseCase?
	
	init(interactorOut:HomeInteractorOut, getTracks:GetTracksUseCase) {
		super.init()
		Logger.log("HomeInteractor init")
		self.interactorOut = interactorOut
		self.getTracksUC = getTracks
	}
}

extension HomeInteractor:HomeInteractorIn{
	
	func getTracks(userId:String) {
		getTracksUC?.setParams(userId).build().subscribe({ (tracks) in
			(self.interactorOut as! HomeInteractorOut).didObtainTracks(tracks)
		}, onError: { (error) in
			(self.interactorOut as! HomeInteractorOut).didObtainError(error)
		})
	}
}
