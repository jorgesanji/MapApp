//
//  AppSessionManager.swift
//  MapApp
//
//  Created by Jorge Sanmartin on 1/31/18.
//  Copyright © 2018 Jorge Sanmartin. All rights reserved.
//

import Foundation

protocol AppSessionDelegate : class{
	
	func logout()
	func updatedCredetentials()
}

extension AppSessionDelegate{
	
	func updatedCredetentials(){}
}

protocol SessionManagerInterface : class {
	
	var delegate:AppSessionDelegate?{set get}
	func login(validation:Any)
	func logout()
}

class AppSessionManager{
	
	fileprivate var restManager:RestApiManagerInterface?
	weak var delegate:AppSessionDelegate?
	
	init(restManager: RestApiManagerInterface) {
		self.restManager =  restManager
		initSession()
	}
	
	private func initSession() {
		restManager?.initOAuth(accessToken: "accessToken",
							   refreshToken: "refreshToken",
							   loginType: "sourceFacebookornormalLogin")
		restManager?.updateCredentials = self
	}
}

extension AppSessionManager :SessionManagerInterface{
	
	func login(validation:Any){
		//TODO: update access and refresh token
		restManager?.updateCredentials = self
	}
}

extension AppSessionManager : UpdateCredentials{
	
	func renewCredentials(validation: Any) {
		//TODO: update access and refresh token
		self.delegate?.updatedCredetentials()
	}
	
	func logout() {
		self.restManager?.invalidateAndCancel()
		self.restManager?.initOAuth(accessToken: "", refreshToken: "", loginType: "")
		if(self.delegate != nil){
			if Thread.isMainThread{
				self.delegate?.logout()
				self.delegate = nil
			}else{
				DispatchQueue.main.sync {
					self.delegate?.logout()
					self.delegate = nil
				}
			}
		}
	}
}
