//
//  ProxyService.swift
//  MapApp
//
//  Created by Jorge Sanmartin on 1/31/18.
//  Copyright © 2018 Jorge Sanmartin. All rights reserved.
//

import Foundation
import Alamofire

class ProxyService : ProxyServiceInterface {
	
	fileprivate let reachabilityManager = Alamofire.NetworkReachabilityManager(host: "www.apple.com")
	fileprivate var localRepository:MapAppLocalRepository!
	fileprivate var restRepository:MapAppRestRepository!
	fileprivate var isReachable:Bool? = true
	
	init(localRepository:MapAppLocalRepository, restRepository:MapAppRestRepository) {
		self.localRepository = localRepository
		self.restRepository = restRepository
		initReachability()
	}
	
	private func initReachability(){
		self.reachabilityManager?.listener = { status in
			self.isReachable = status != NetworkReachabilityManager.NetworkReachabilityStatus.notReachable
		}
		self.reachabilityManager?.startListening()
	}
	
	func repository() -> MapAppRepository{
		return localRepository
//		return isReachable! ? restRepository : localRepository
	}
}

