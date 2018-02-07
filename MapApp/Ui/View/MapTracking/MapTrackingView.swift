//
//  MapTrackingView.swift
//  MapApp
//
//  Created by Jorge Sanmartin on 1/31/18.
//  Copyright © 2018 Jorge Sanmartin. All rights reserved.
//

import UIKit
import MapKit

class MapTrackingView : BaseView {
	
	let spanX = 0.007
	let spanY = 0.007
	let lineWidth:CGFloat = 2.0
	
	@IBOutlet fileprivate var mapView:MKMapView?
	
	override func initUI() {
		mapView?.delegate = self
		mapView?.mapType = .standard
		mapView?.showsUserLocation = true
	}
	
	func addPolyline(_ polyline:MKPolyline){
		let newRegin = MKCoordinateRegion(center: (mapView?.userLocation.coordinate)!, span:MKCoordinateSpanMake(spanX, spanY))
		mapView?.setRegion(newRegin, animated: true)
		mapView?.add(polyline)
	}
	
	func zoomPolyline(_ polyline:MKPolyline){
		let polygon = MKPolygon(points: polyline.points(), count: polyline.pointCount)
		mapView?.setRegion(MKCoordinateRegionForMapRect(polygon.boundingMapRect), animated: true)
	}
	
	func addPin(_ annotation: MKPointAnnotation) {
		mapView?.addAnnotation(annotation)
	}
}

extension MapTrackingView : MKMapViewDelegate{
	
	func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
		guard overlay is MKPolyline else {
			return MKPolylineRenderer()
		}
		let polylineRenderer = MKPolylineRenderer(overlay: overlay)
		polylineRenderer.strokeColor = UIColor.blue
		polylineRenderer.lineWidth = lineWidth
		return polylineRenderer
	}
}
