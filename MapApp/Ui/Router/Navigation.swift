//
//  Navigation.swift
//  MapApp
//
//  Created by Jorge Sanmartin on 1/31/18.
//  Copyright © 2017 Cronos group. All rights reserved.
//

import Foundation
import UIKit

protocol AppNavigation {
	
	func gotoHome()
	func gotoSplash()
	func gotoMapTracking(_ track:Track?)
	
	//MARK: Dialog
	
}
