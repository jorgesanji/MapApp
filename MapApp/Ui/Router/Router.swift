//
//  Router.swift
//  MapApp
//
//  Created by Jorge Sanmartin on 1/31/18.
//  Copyright © 2016 Cronos group. All rights reserved.
//

import Foundation
import UIKit
import MessageUI

var dialogControllers:[UIViewController] = []

class Router : NSObject{
	
	let SIZE_DIALOG_DEFAULT = CGSize(width: 400, height: 400)
	
	// MARK: Properties
	
	weak var viewController: UIViewController?
	
	// MARK: PRIVATE METHODS
	
	fileprivate func removeController( _ viewController:UIViewController){
		if let index = dialogControllers.index(where: { (viewControllerIn) -> Bool in
			return viewController ==  viewControllerIn
		}){
			dialogControllers.remove(at: index)
		}
	}
	
	fileprivate func removeAllModalControllers(){
		for (_, controller) in dialogControllers.enumerated(){
			controller.dismiss(animated: true, completion: nil)
		}
		dialogControllers.removeAll()
	}
	
	required override init(){
		super.init()
	}
	
	init(_ view:UIViewController) {
		self.viewController = view
	}
	
	func popViewController(){
		_ = viewController?.navigationController?.popViewController(animated: true)
	}
	
	func removeAllControllers() {
		self.viewController?.navigationController?.popToRootViewController(animated: true)
		_ = AppDelegate.delegate.window?.rootViewController?.navigationController?.popToRootViewController(animated: true)
		self.removeAllModalControllers()
	}
	
	func dissmissViewController(){
		removeController(viewController!)
		viewController?.dismiss(animated:true, completion: nil)
	}
	
	func presentController(_ controller:UIViewController, modalPresentationStyle:UIModalPresentationStyle? = .none, showOnTop:Bool? = false){
		controller.transitioningDelegate = self
		if modalPresentationStyle != nil{
			if modalPresentationStyle! != .none{
				controller.modalPresentationStyle = modalPresentationStyle!
			}
		}
		if showOnTop!{
			if dialogControllers.isEmpty{
				AppDelegate.delegate.window?.rootViewController?.present(controller, animated: true, completion: nil)
			}else{
				dialogControllers.last?.present(controller, animated: true, completion: nil)
			}
		}else{
			self.viewController?.present(controller, animated: true, completion: nil)
		}
		dialogControllers.append(controller)
	}
	
	func navigateToController(_ viewController:UIViewController, animated:Bool){
		self.viewController?.navigationController?.delegate = self
		self.viewController?.navigationController?.pushViewController(viewController, animated: animated)
	}
	
	internal func changeRootController(_ viewController:UIViewController, completion: (() -> Swift.Void)? = nil){
		self.removeAllModalControllers()
		var transitionOptions = UIWindow.TransitionOptions()
		transitionOptions.style = .easeInOut
		transitionOptions.direction = .fade
		if AppDelegate.delegate.window == nil{
			AppDelegate.delegate.window = UIWindow(frame: UIScreen.main.bounds)
		}
		AppDelegate.delegate.window?.setRootViewController(viewController, options: transitionOptions)
	}
	
	internal func showDialogArrowUp(anchorView:UIView,
									controller:UIViewController,
									preferredContentSize:CGSize,
									sourceRect:CGRect ){
		showDialogArrowDirection(anchorView: anchorView, controller: controller,
								 preferredContentSize: preferredContentSize,
								 sourceRect: sourceRect, arrowDirection: .up)
	}
	
	internal func showDialogArrowDirection(anchorView:UIView,
										   controller:UIViewController,
										   preferredContentSize:CGSize,
										   sourceRect:CGRect,
										   arrowDirection:UIPopoverArrowDirection){
		controller.modalPresentationStyle = .popover
		controller.preferredContentSize = preferredContentSize
		controller.transitioningDelegate = self
		let popController = controller.popoverPresentationController
		popController?.backgroundColor = UIColor.white
		popController?.permittedArrowDirections = arrowDirection
		popController?.sourceView = anchorView
		popController?.sourceRect = sourceRect
		popController?.delegate = self
		viewController?.present(controller, animated: true, completion: nil)
		dialogControllers.append(controller)
	}
}

extension Router : UIPopoverPresentationControllerDelegate{
	
	func popoverPresentationControllerDidDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) {
		Logger.log("popoverPresentationControllerDidDismissPopover")
	}
	
	func popoverPresentationControllerShouldDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) -> Bool {
		return true
	}
	
	func popoverPresentationController(_ popoverPresentationController: UIPopoverPresentationController, willRepositionPopoverTo rect: UnsafeMutablePointer<CGRect>, in view: AutoreleasingUnsafeMutablePointer<UIView>) {
		Logger.log("popoverPresentationControllerDidDismissPopover")
	}
	
	func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
		return .none
	}
}

extension Router: UINavigationControllerDelegate{
	
	func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
		var animator:UIViewControllerAnimatedTransitioning? = nil
		if operation == .pop{
			let popController = fromVC as! BaseViewController
			animator = popController.popTrasition()
		}else{
			let pushController = toVC as! BaseViewController
			animator = pushController.pushTrasition()
		}
		return animator
	}
}

extension Router : MFMailComposeViewControllerDelegate{
	
	func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
		self.viewController?.dismiss(animated: true, completion: nil)
	}
}

extension Router : UIViewControllerTransitioningDelegate{
	
	public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
		if presented is AppTransition{
			let viewController = presented as! AppTransition
			return viewController.pushTrasition()
		}
		return nil
	}
	
	public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
		removeController(dismissed)
		if dismissed is AppTransition{
			let viewController = dismissed as! AppTransition
			return viewController.popTrasition()
		}
		return nil
	}
}
