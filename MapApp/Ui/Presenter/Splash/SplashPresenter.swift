//
//  SplashPresenter.swift
//  MapApp
//
//  Created by Jorge Sanmartin on 1/31/18.
//  Copyright © 2018 Jorge Sanmartin. All rights reserved.
//

import Foundation

protocol SplashPresenterOut : PresenterIn{
}

protocol SplashPresenterIn : PresenterOut{
}

class SplashPresenter: BasePresenter{
	
	let secondsToDissapear:Double = 2
	
	init(router:AppNavigation, view:SplashPresenterIn) {
		super.init(router: router)
		Logger.log("SplashPresenter init")
		self.view = view
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		Logger.log("viewDidLoad")
		let when = DispatchTime.now() + secondsToDissapear
		DispatchQueue.main.asyncAfter(deadline: when) {
			self.router?.gotoHome()
		}
	}
}

extension SplashPresenter: SplashPresenterOut{
	
}

extension SplashPresenter: SplashInteractorOut{
	
}
