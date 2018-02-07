//
//  MapTrackingPresenter.swift
//  MapApp
//
//  Created by Jorge Sanmartin on 1/31/18.
//  Copyright © 2018 Jorge Sanmartin. All rights reserved.
//

import Foundation
import UIKit
import MapKit
import CoreMotion

protocol MapTrackingPresenterOut : PresenterIn{
	var track:Track?{set get}
}

protocol MapTranckingPresenterIn : PresenterOut{
	func addPolyline(_ polyline:MKPolyline)
	func zoomPolyline(_ polyline:MKPolyline)
	func addPin(_ annotation:MKPointAnnotation)
}

class MapTrackingPresenter: BasePresenter {
	
	let minutesForLaunchCancelAlert:Double = 1 * 60
	
	fileprivate var locationManager:AppLocationManagerInterface?
	fileprivate let motionManager:CMMotionActivityManager = CMMotionActivityManager()
	fileprivate var lastDate:Date = Date()
	var track: Track?
	
	init(router:AppNavigation, view:MapTranckingPresenterIn, locationManager:AppLocationManagerInterface) {
		super.init(router: router)
		Logger.log("MapTrackingPresenter init")
		self.view = view
		self.locationManager = locationManager
	}
	
	fileprivate func addPolylineIfNeeded(){
		if self.track?.locations.count == 1{
			return
		}
		let sourceIndex = (self.track?.locations.count)! - 1
		let destinationIndex = (self.track?.locations.count)! - 2
		let location1 = self.track?.locations[sourceIndex]
		let location2 = self.track?.locations[destinationIndex]
		let coordinate1 = CLLocationCoordinate2D(latitude:(location1?.latitude)!, longitude:(location1?.longitude)!)
		let coordinate2 = CLLocationCoordinate2D(latitude:(location2?.latitude)!, longitude:(location2?.longitude)!)
		var coordinates = [coordinate1, coordinate2]
		let polyline = MKPolyline(coordinates: &coordinates, count:coordinates.count)
		(view as? MapTranckingPresenterIn )?.addPolyline(polyline)
	}
	
	fileprivate func startLocationUpdates(){
		self.track = Track()
		track?.dateStart = Date()
		initMotion()
		locationManager?.fetchWithCompletion({ (location, error) in
			if error == nil{
				var locationUser = Location()
				locationUser.latitude = (location?.coordinate.latitude)!
				locationUser.longitude = (location?.coordinate.longitude)!
				self.track?.locations.append(locationUser)
				self.addPolylineIfNeeded()
			}
		})
	}
	
	fileprivate func startMotionUpdates(){
		motionManager.stopActivityUpdates()
		motionManager.startActivityUpdates(to: OperationQueue.main) { (activity) in
			if (activity?.stationary)! {
				Logger.log("User is standing")
				let interval = Date().timeIntervalSince(self.lastDate)
				if interval >= self.minutesForLaunchCancelAlert{
					self.cancelTracking()
				}else{
					self.view?.showWarning(message: R.string.localizable.message_tracking_standing())
				}
			}else{
				self.lastDate = Date()
			}
		}
	}
	
	fileprivate func initMotion(){
		let today = Date()
		motionManager.queryActivityStarting(from: today, to: today, to: OperationQueue.main) { (activity, error) in
			if error != nil {
				let errorCode = (error! as NSError).code
				if errorCode == Int(CMErrorMotionActivityNotAuthorized.rawValue) {
					Logger.log("NotAuthorized")
					self.view?.showError(message: R.string.localizable.message_motion_disabled())
				}
			} else {
				Logger.log("Authorized")
				self.startMotionUpdates()
			}
		}
	}
	
	override func viewDidLoad() {
		view?.viewController().navigationItem.title = R.string.localizable.tracking_title()
		if track == nil{
			let stopTrackingView = HolderView.create(title: R.string.localizable.stop_tracking(), titleColor: .white, backgroundColor: .primary, target: self, selector: #selector(MapTrackingPresenter.stopTracking))
			view?.viewController().navigationItem.rightBarButtonItem = UIBarButtonItem(customView: stopTrackingView)
			let cancelTrackingView = HolderView.create(title: R.string.localizable.cancel_action(), titleColor: .white, backgroundColor: .red, target: self, selector: #selector(MapTrackingPresenter.cancelTracking))
			cancelTrackingView.width = 80
			view?.viewController().navigationItem.leftBarButtonItem = UIBarButtonItem(customView: cancelTrackingView)
			startLocationUpdates()
		}else{
			//TODO: Create polyline
			var coordinates:[CLLocationCoordinate2D] = []
			for location in (track?.locations)!{
				coordinates.append(CLLocationCoordinate2D(latitude:location.latitude, longitude:location.longitude))
			}
			let polyline = MKPolyline(coordinates: &coordinates, count:coordinates.count)
			(view as? MapTranckingPresenterIn )?.addPolyline(polyline)
			(view as? MapTranckingPresenterIn )?.zoomPolyline(polyline)
			
			//TODO:Create end and start annotation
			let coordinateStart = track?.locations.first
			let coordinateEnd = track?.locations.last
			let annotationStart = MKPointAnnotation()
			annotationStart.coordinate = CLLocationCoordinate2D(latitude: (coordinateStart?.latitude)!, longitude: (coordinateStart?.longitude)!)
			let annotationEnd = MKPointAnnotation()
			annotationEnd.coordinate = CLLocationCoordinate2D(latitude: (coordinateEnd?.latitude)!, longitude: (coordinateEnd?.longitude)!)
			(view as? MapTranckingPresenterIn )?.addPin(annotationStart)
			(view as? MapTranckingPresenterIn )?.addPin(annotationEnd)
		}
	}
	
	fileprivate func showAlert(message:String, acceptAction:((UIAlertAction) -> Void)? , cancelAction:((UIAlertAction) -> Void)?){
		view?.showAlertView(title: R.string.localizable.title_stop_tracking(), message: message, cancelBlock: cancelAction, acceptBlock: acceptAction, cancelTitle: R.string.localizable.cancel_action(), acceptTitle: R.string.localizable.ok_action())
	}
	
	@objc func stopTracking() {
		showAlert(message: R.string.localizable.message_stop_tracking(), acceptAction: { (action) in
			self.locationManager?.stopLocationManager()
			self.motionManager.stopActivityUpdates()
			self.track?.dateEnd = Date()
			(self.interactor as! MapTrackingInteractorIn).saveTrack(track: self.track!)
		}) { (action) in }
	}
	
	@objc func cancelTracking() {
		showAlert(message: R.string.localizable.message_cancel_tracking(), acceptAction: { (action) in
			self.locationManager?.stopLocationManager()
			self.motionManager.stopActivityUpdates()
			self.view?.viewController().navigationController?.popViewController(animated: true)
		}) { (action) in }
	}
}

extension MapTrackingPresenter: MapTrackingPresenterOut{
	
}

extension MapTrackingPresenter: MapTrackingInteractorOut{
	
	func didObtainErrorSavingTrack() {
		Logger.log("didObtainErrorSavingTrack")
	}
	
	func didSaveTrack() {
		view?.viewController().navigationController?.popViewController(animated: true)
	}
}
