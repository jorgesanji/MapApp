//
//  BasePresenter.swift
//  MapApp
//
//  Created by Jorge Sanmartin on 1/31/18.
//  Copyright © 2018 Jorge Sanmartin. All rights reserved.
//

import Foundation
import UIKit

class BasePresenter:PresenterIn{
	
	weak var view:PresenterOut?
	var router:AppNavigation?
	var interactor:InteractorIn?
	
	init(router:AppNavigation) {
		self.router = router
	}
	
	func viewDidLoad() {}
	
	func viewWillAppear() {}
	
	func viewDidAppear() {}
	
	func viewDidDisappear() {}
	
	func viewWillDisappear() {}
	
	func didReceiveMemoryWarning() {}
}
