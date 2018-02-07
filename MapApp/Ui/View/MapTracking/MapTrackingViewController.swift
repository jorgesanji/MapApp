//
//  MapTrackingViewController.swift
//  MapApp
//
//  Created by Jorge Sanmartin on 1/31/18.
//  Copyright © 2018 Jorge Sanmartin. All rights reserved.
//

import UIKit
import MapKit

class MapTrackingViewController: MVPViewController<MapTrackingView, MapTrackingPresenter>{
	
}

extension MapTrackingViewController : MapTranckingPresenterIn{
	
	func addPolyline(_ polyline:MKPolyline){
		rootView.addPolyline(polyline)
	}
	
	func zoomPolyline(_ polyline:MKPolyline){
		rootView.zoomPolyline(polyline)
	}
	
	func addPin(_ annotation: MKPointAnnotation) {
		rootView.addPin(annotation)
	}
}
