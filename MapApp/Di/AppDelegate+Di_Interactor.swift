//
//  AppDelegate+Di_Interactor.swift
//  MapApp
//
//  Created by Jorge Sanmartin on 1/31/18.
//  Copyright © 2018 Jorge Sanmartin. All rights reserved.
//

import Foundation

extension AppDelegate{
	
	func injectInteractors(){
		
		//TODO: SplashInteractor
		container?.register(SplashInteractorIn.self) {(r, presenter:SplashPresenter)in
			return SplashInteractor(interactorOut:presenter)
		}
		
		//TODO: HomeInteractor
		container?.register(HomeInteractorIn.self) {(r, presenter:HomePresenter)in
			return HomeInteractor(interactorOut:presenter, getTracks:r.resolve(GetTracksUseCase.self)!)
		}
		
		//TODO: MapTrackingInteractor
		container?.register(MapTrackingInteractorIn.self) {(r, presenter:MapTrackingPresenter)in
			return MapTrackingInteractor(interactorOut:presenter, saveTrack:r.resolve(SaveTrackUseCase.self)!)
		}
	}
}
