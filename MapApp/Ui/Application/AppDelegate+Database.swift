//
//  AppDelegate+Database.swift
//  MapApp
//
//  Created by Jorge Sanmartin on 1/31/18.
//  Copyright © 2018 Jorge Sanmartin. All rights reserved.
//

import Foundation
import RealmSwift

extension AppDelegate{
	
	func initDatabase(){
		Realm.Configuration.defaultConfiguration = Realm.Configuration(schemaVersion: 1, migrationBlock: nil)
	}
}
