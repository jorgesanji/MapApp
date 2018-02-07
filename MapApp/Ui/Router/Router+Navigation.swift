//
//  Router + Navigation.swift
//  MapApp
//
//  Created by Jorge Sanmartin on 1/31/18.
//  Copyright © 2017 Cronos group. All rights reserved.
//

import Foundation
import Swinject
import SwinjectStoryboard
import MessageUI

extension Router : AppNavigation{
	
	// MARK: CONTROLLERS
	
	func gotoSplash(){
		let splashVC = SwinjectStoryboard.controllerFromStoryBoard(SplashViewController.self)
		self.changeRootController(splashVC)
	}
	
	func gotoHome() {
		let homeVC = SwinjectStoryboard.controllerFromStoryBoard(HomeViewController.self)
		let navigationController = NavigationController()
		navigationController.navigationBar.isTranslucent = false
		navigationController.pushViewController(homeVC, animated: false)
		self.changeRootController(navigationController)
	}
	
	func gotoMapTracking(_ track: Track?) {
		let mapTrackingVC = SwinjectStoryboard.controllerFromStoryBoard(MapTrackingViewController.self)
		mapTrackingVC.presenter?.track = track
		navigateToController(mapTrackingVC, animated: true)
	}
	
	// MARK: DIALOG CONTROLLERS

}
