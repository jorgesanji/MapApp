//
//  AppDelegate+Di.swift
//  MapApp
//
//  Created by Jorge Sanmartin on 1/31/18.
//  Copyright © 2018 Jorge Sanmartin. All rights reserved.
//

import Foundation
import Swinject
import SwinjectStoryboard

extension AppDelegate{
	
	func initDI(){
		self.container = Container()
		// Instances
		injectInstances()
		//Use Cases
		injectUseCases()
		//Controllers
		injectControllers()
		//Interactors
		injectInteractors()
		// Presenters
		injectPresenters()
	}
}

extension SwinjectStoryboard{
	
	static func controllerFromStoryBoard<C:BaseViewController>(_ controllerClass:C.Type) -> C{
		let storyBoard = SwinjectStoryboard.create(name: "DiStoryboard", bundle: nil, container: AppDelegate.delegate.container!)
		return storyBoard.instantiateViewController(withIdentifier:String(describing: C.self)) as! C
	}
}
