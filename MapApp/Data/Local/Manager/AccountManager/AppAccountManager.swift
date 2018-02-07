//
//  AppAccountManager.swift
//  MapApp
//
//  Created by Jorge Sanmartin on 1/31/18.
//  Copyright © 2018 Jorge Sanmartin. All rights reserved.
//

import Foundation
import UIKit
import KeychainSwift

protocol AccountManagerInterface : class {
	func saveUUID(_ uuid:String)
	func existUUID() -> Bool
	func removeAccount()
}

class AppAccountManager:AccountManagerInterface {
	
	private let USER_ID:String = "userId"
	
	fileprivate var keychain:KeychainSwift?
	
	init() {
		self.keychain = KeychainSwift()
	}
	
	func removeAccount(){
		keychain?.delete(USER_ID)
	}
	
	func saveUUID(_ uuid: String) {
		keychain?.set(uuid, forKey: USER_ID, withAccess: .accessibleWhenPasscodeSetThisDeviceOnly)
	}
	
	func existUUID() -> Bool{
		return keychain?.get(USER_ID) != nil
	}
}

