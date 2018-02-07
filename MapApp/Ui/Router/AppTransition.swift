//
//  AppTransition.swift
//  MapApp
//
//  Created by Jorge Sanmartin on 1/31/18.
//  Copyright © 2017 Cronos group. All rights reserved.
//

import Foundation
import UIKit

protocol AppTransition :class {
	func pushTrasition() -> UIViewControllerAnimatedTransitioning?
	func popTrasition() -> UIViewControllerAnimatedTransitioning?
}
