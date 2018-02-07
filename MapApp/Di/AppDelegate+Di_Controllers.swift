//
//  AppDelegate+Di_Controllers.swift
//  MapApp
//
//  Created by Jorge Sanmartin on 1/31/18.
//  Copyright © 2018 Jorge Sanmartin. All rights reserved.
//

import Foundation

extension AppDelegate{
	
	func injectControllers(){
		
		//TODO: SplashViewController
		container?.storyboardInitCompleted(SplashViewController.self) {r, c in
			c.presenter = r.resolve(SplashPresenterOut.self, argument: c) as? SplashPresenter
		}
		
		//TODO: HomeViewController
		container?.storyboardInitCompleted(HomeViewController.self) {r, c in
			c.presenter = r.resolve(HomePresenterOut.self, argument: c) as? HomePresenter
		}
		
		//TODO: MapTrackingViewController
		container?.storyboardInitCompleted(MapTrackingViewController.self) {r, c in
			c.presenter = r.resolve(MapTrackingPresenterOut.self, argument: c) as? MapTrackingPresenter
		}
	}
}
