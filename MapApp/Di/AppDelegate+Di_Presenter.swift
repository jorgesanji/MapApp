//
//  AppDelegate+Di_Presenter.swift
//  MapApp
//
//  Created by Jorge Sanmartin on 1/31/18.
//  Copyright © 2018 Jorge Sanmartin. All rights reserved.
//

import Foundation

extension AppDelegate{
	
	func injectPresenters(){
		
		//TODO: SplashViewController
		container?.register(SplashPresenterOut.self) { (r, view: SplashViewController) in
			let router = r.resolve(AppNavigation.self, argument: view as BaseViewController)
			let presenter = SplashPresenter(router:router!, view:view)
			presenter.interactor = r.resolve(SplashInteractorIn.self, argument:presenter)
			return presenter
		}
		
		//TODO: HomeViewController
		container?.register(HomePresenterOut.self) { (r, view: HomeViewController) in
			let router = r.resolve(AppNavigation.self, argument: view as BaseViewController)
			let presenter = HomePresenter(router:router!, view:view, accountManager:r.resolve(AccountManagerInterface.self)!)
			presenter.interactor = r.resolve(HomeInteractorIn.self, argument:presenter)
			return presenter
		}
		
		//TODO: MapTrackingViewController
		container?.register(MapTrackingPresenterOut.self) { (r, view: MapTrackingViewController) in
			let router = r.resolve(AppNavigation.self, argument: view as BaseViewController)
			let locationManager = r.resolve(AppLocationManagerInterface.self)
			let presenter = MapTrackingPresenter(router:router!, view:view, locationManager:locationManager!)
			presenter.interactor = r.resolve(MapTrackingInteractorIn.self, argument:presenter)
			return presenter
		}		
	}
}
