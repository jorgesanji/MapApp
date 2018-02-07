//
//  UIView+Click.swift
//  MapApp
//
//  Created by Jorge Sanmartin on 1/31/18.
//  Copyright © 2018 Jorge Sanmartin. All rights reserved.
//

import Foundation
import Foundation
import UIKit
import ObjectiveC

typealias OnClick = () -> Void
private var onClickKey: UInt8 = 0

extension UIView{
	
	// MARK: ON CLICK HANDLER
	
	var onClick: OnClick {
		get {
			return objc_getAssociatedObject(self, &onClickKey) as! OnClick
		}
		set {
			objc_setAssociatedObject(self, &onClickKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
			initGesture()
		}
	}
	
	func initGesture(){
		removeGestures()
		self.isUserInteractionEnabled = true
		if self.gestureRecognizers != nil{
			for gesture in self.gestureRecognizers!{
				self.removeGestureRecognizer(gesture)
			}
		}
		let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
		addGestureRecognizer(tapGesture)
	}
	
	@objc func handleTap(sender: UITapGestureRecognizer) {
		self.onClick()
	}
	
	func removeGestures(){
		if self.gestureRecognizers != nil{
			for gesture in self.gestureRecognizers!{
				self.removeGestureRecognizer(gesture)
			}
		}
	}
}
