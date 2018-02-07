//
//  NavigationController.swift
//  MapApp
//
//  Created by Jorge Sanmartin on 1/31/18.
//  Copyright © 2017 Cronos group. All rights reserved.
//

import Foundation
import UIKit

class NavigationController: UINavigationController {
	
	weak var mainController:UIViewController?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.modalPresentationCapturesStatusBarAppearance = true
	}
	
	override var preferredStatusBarStyle: UIStatusBarStyle{
		return (topViewController?.preferredStatusBarStyle)!
	}

	override var prefersStatusBarHidden: Bool{
		return false
	}
}

extension UINavigationController : UIGestureRecognizerDelegate {

	override open func viewDidLoad() {
		super.viewDidLoad()
		interactivePopGestureRecognizer?.delegate = self
	}
	
	public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
		guard gestureRecognizer is UIScreenEdgePanGestureRecognizer else { return true }
		return viewControllers.count > 1
	}
}

extension UINavigationBar {
	
	func removeUserInfo(){
		if let userInfoView = viewWithTag(1002){
			userInfoView.removeFromSuperview()
		}
	}
	
	func hideBottomHairline(){
		hairlineImageViewInNavigationBar(view: self)?.isHidden = true
	}
	
	func showBottomHairline(){
		hairlineImageViewInNavigationBar(view: self)?.isHidden = false
	}
	
	private func hairlineImageViewInNavigationBar(view: UIView) -> UIImageView?{
		if let imageView = view as? UIImageView, imageView.bounds.height <= 1{
			return imageView
		}
		for subview: UIView in view.subviews{
			if let imageView = hairlineImageViewInNavigationBar(view: subview){
				return imageView
			}
		}
		return nil
	}
}

import UIKit.UINavigationController

public typealias VoidBlock = (() -> Void)

public extension UINavigationController
{
	public func pushViewController(viewController: UIViewController, animated: Bool, completion: @escaping VoidBlock) {
		CATransaction.begin()
		CATransaction.setCompletionBlock(completion)
		self.pushViewController(viewController, animated: animated)
		CATransaction.commit()
	}
}
