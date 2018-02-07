//
//  AppDelegate+Di_instances.swift
//  MapApp
//
//  Created by Jorge Sanmartin on 1/31/18.
//  Copyright © 2018 Jorge Sanmartin. All rights reserved.
//

import Foundation

extension AppDelegate{
	
	func injectInstances(){
		container?.register(AppNavigation.self){(r, view: BaseViewController) in Router(view)}
		injectSingleInstances()
		dataBaseInstances()
		restInstances()
	}
	
	fileprivate func injectSingleInstances(){
		container?.register(AppLocationManagerInterface.self){_ in AppLocationManager()}.inObjectScope(.container)
		container?.register(AccountManagerInterface.self){_ in AppAccountManager()}.inObjectScope(.container)
	}
	
	fileprivate func dataBaseInstances (){
		container?.register(TrackEntityManagerInterface.self){_ in TrackEntityManager()}
	}
	
	fileprivate func restInstances(){
		container?.register(RestApiManagerInterface.self){ _ in RestApiManager()}.inObjectScope(.container)
		container?.register(MapAppRestRepository.self){ r in
			RestApiServices(manager: r.resolve(RestApiManagerInterface.self)!)
		}
		container?.register(MapAppLocalRepository.self){ r in LocalRepository(manager:r.resolve(TrackEntityManagerInterface.self)!)}
		container?.register(ProxyServiceInterface.self){ r in
			ProxyService(localRepository:r.resolve(MapAppLocalRepository.self)!,
						 restRepository:r.resolve(MapAppRestRepository.self)!)
			}.inObjectScope(.container)
		container?.register(SessionManagerInterface.self){ r
			in AppSessionManager(restManager:r.resolve(RestApiManagerInterface.self)!)
			}.inObjectScope(.container)
	}
}
