//
//  UpdateCredentials.swift
//  MapApp
//
//  Created by Jorge Sanmartin on 1/31/18.
//  Copyright © 2018 Jorge Sanmartin. All rights reserved.
//

import Foundation

protocol UpdateCredentials : class {
	func renewCredentials(validation:Any)
	func logout()
}
