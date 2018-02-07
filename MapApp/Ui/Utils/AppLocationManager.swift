//
//  AppLocationManager.swift
//  MapApp
//
//  Created by Jorge Sanmartin on 1/31/18.
//  Copyright © 2018 Jorge Sanmartin. All rights reserved.
//

import Foundation
import CoreLocation

//possible errors
enum TLLocationManagerErrors: Int {
	case AuthorizationDenied
	case AuthorizationNotDetermined
	case InvalidLocation
}

protocol AppLocationManagerInterface : class {
	var currentLocation:CLLocation?{set get}
	func fetchWithCompletion(_ completion:LocationClosure?)
	func stopLocationManager()
}

typealias LocationClosure = ((_ location: CLLocation?, _ error: NSError?)->())

class AppLocationManager:NSObject{
	
	//location manager
	fileprivate var locationManager: CLLocationManager?
	fileprivate var didComplete: LocationClosure?
	var currentLocation:CLLocation?
	
	//destroy the manager
	deinit {
		locationManager?.delegate = nil
		locationManager = nil
	}
	
	//location manager returned, call didcomplete closure
	fileprivate func _didComplete(location: CLLocation?, error: NSError?) {
		didComplete?(location, error)
	}
}

// MARK: LocationManagerDelegate

extension AppLocationManager : CLLocationManagerDelegate{
	
	func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
		switch status {
		case .authorizedAlways:
			self.locationManager!.startUpdatingLocation()
			break
		case .authorizedWhenInUse:
			self.locationManager!.startUpdatingLocation()
			break
		case .denied:
			_didComplete(location: nil, error: NSError(domain: self.classForCoder.description(),
													   code: TLLocationManagerErrors.AuthorizationDenied.rawValue,
													   userInfo: nil))
			break
		default:
			break
		}
	}
	
	func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
		_didComplete(location: nil, error: error as NSError?)
	}
	
	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		self.currentLocation = locations[0]
		_didComplete(location: currentLocation!, error: nil)
	}
}

extension AppLocationManager : AppLocationManagerInterface{
	
	func fetchWithCompletion(_ completion:LocationClosure?) {
		self.didComplete = completion
		//fire the location manager
		self.locationManager?.delegate = nil
		self.locationManager = nil
		self.locationManager = CLLocationManager()
		locationManager!.delegate = self
		locationManager?.allowsBackgroundLocationUpdates = true
		locationManager!.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
		//check for description key and ask permissions
		if (CLLocationManager.authorizationStatus() == .authorizedAlways
			|| CLLocationManager.authorizationStatus() == .authorizedWhenInUse){
			locationManager?.startUpdatingLocation()
			return
		}
		if (Bundle.main.object(forInfoDictionaryKey: "NSLocationWhenInUseUsageDescription") != nil) {
			locationManager!.requestWhenInUseAuthorization()
		} else if (Bundle.main.object(forInfoDictionaryKey: "NSLocationAlwaysUsageDescription")  != nil) {
			locationManager!.requestAlwaysAuthorization()
		} else {
			fatalError("To use location in iOS8 you need to define either NSLocationWhenInUseUsageDescription or NSLocationAlwaysUsageDescription in the app bundle's Info.plist file")
		}
	}
	
	func stopLocationManager() {
		if locationManager != nil{
			locationManager?.stopUpdatingLocation()
		}
	}
}
