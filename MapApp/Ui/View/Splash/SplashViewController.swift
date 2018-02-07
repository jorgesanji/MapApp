//
//  SplashViewController.swift
//  MapApp
//
//  Created by Jorge Sanmartin on 1/31/18.
//  Copyright © 2018 Jorge Sanmartin. All rights reserved.
//

import UIKit

class SplashViewController: MVPViewController<SplashView, SplashPresenter>{
	
	override var prefersStatusBarHidden : Bool {
		return true
	}
}

extension SplashViewController : SplashPresenterIn{
	
	
}
