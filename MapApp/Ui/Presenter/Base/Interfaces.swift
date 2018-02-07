//
//  Interfaces.swift
//  MapApp
//
//  Created by Jorge Sanmartin on 1/31/18.
//  Copyright © 2018 Jorge Sanmartin. All rights reserved.
//

import Foundation
import UIKit

protocol PresenterIn:class{
	func viewDidLoad()
	func viewDidAppear()
	func viewWillAppear()
	func viewDidDisappear()
	func viewWillDisappear()
	func didReceiveMemoryWarning()
}

protocol PresenterOut:class{
	func viewController() -> BaseViewController
	func showLoader()
	func hideLoader()
	func dissmissKeyboard()
	func showAlertView(title:String?, message:String, cancelBlock:((UIAlertAction) -> Void)?,
		acceptBlock:((UIAlertAction) -> Void)?, cancelTitle:String?, acceptTitle:String?)
	func showError(title:String, message: String)
	func showError(message: String)
	func showConfirm(message: String)
	func showConfirm(title:String, message: String)
	func showWarning(message: String)
	func showWarning(title:String, message: String)
}

protocol InteractorIn:class{
	
}

protocol InteractorOut:class{
	
}
