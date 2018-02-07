//
//  SplashInteractor.swift
//  MapApp
//
//  Created by Jorge Sanmartin on 1/31/18.
//  Copyright © 2018 Jorge Sanmartin. All rights reserved.
//

import Foundation

protocol SplashInteractorOut:InteractorOut{
	
}

protocol SplashInteractorIn:InteractorIn{
	
}

class SplashInteractor:BaseInteractor{
	
	init(interactorOut:SplashInteractorOut) {
		super.init()
		Logger.log("SplasInteractor init")
		self.interactorOut = interactorOut
	}
}

extension SplashInteractor:SplashInteractorIn{
	
}
