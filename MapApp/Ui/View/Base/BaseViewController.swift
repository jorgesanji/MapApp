//
//  BaseViewController.swift
//  MapApp
//
//  Created by Jorge Sanmartin on 1/31/18.
//  Copyright © 2016 Cronos group. All rights reserved.
//

import Foundation
import UIKit
import SwiftMessages

let heigthIphoneX:CGFloat = 812.0

class BaseViewController:UIViewController{
	
	override func viewDidLoad() {
		super.viewDidLoad()
		if self.navigationController != nil {
			self.navigationItem.title = ""
		}
	}
	
	override var preferredStatusBarStyle: UIStatusBarStyle{
		return .default
	}
	
	override var prefersStatusBarHidden : Bool {
		return false
	}
	
	fileprivate func showMessage(title:String, message:String, theme:Theme){
		//SwiftMessages.hideAll()
		let view = MessageView.viewFromNib(layout: .cardView)
		var config = SwiftMessages.defaultConfig
		config.presentationStyle = .bottom
		view.configureTheme(theme)
		view.configureContent(title: R.string.localizable.app_name(), body: message)
		SwiftMessages.show(config: config, view: view)
	}
}

extension BaseViewController : ViewDelegate{
	
}

extension BaseViewController : AppTransition{
	
	func pushTrasition() -> UIViewControllerAnimatedTransitioning?{
		return nil
	}
	
	func popTrasition() -> UIViewControllerAnimatedTransitioning?{
		return nil
	}
}

extension  BaseViewController : PresenterOut{
	
	func showAlertView(title: String?, message: String, cancelBlock: ((UIAlertAction) -> Void)?, acceptBlock: ((UIAlertAction) -> Void)?, cancelTitle: String?, acceptTitle: String?) {
		let alertView = UIAlertController(title: title, message: message, preferredStyle: .alert)
		if let cancelBlock = cancelBlock{
			let cancelActionButton: UIAlertAction = UIAlertAction(title:cancelTitle?.uppercased(), style: .default, handler: cancelBlock)
			alertView.addAction(cancelActionButton)
		}
		let acceptActionButton: UIAlertAction = UIAlertAction(title: acceptTitle?.uppercased(), style: .default,  handler: acceptBlock)
		alertView.addAction(acceptActionButton)
		self.present(alertView, animated: true, completion: nil)
	}
	
	func viewController() -> BaseViewController {
		return self
	}
	
	func showLoader(){}
	
	func hideLoader(){}
	
	func dissmissKeyboard(){
		UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to:nil, from:nil, for:nil)
	}
	
	func showError(title:String, message: String) {
		showMessage(title:title, message:message, theme:.error)
	}
	
	func showError(message: String) {
		showMessage(title:R.string.localizable.app_name(), message:message, theme:.error)
	}
	
	func showConfirm(message: String) {
		showMessage(title:R.string.localizable.app_name(), message:message, theme:.success)
	}
	
	func showConfirm(title:String, message: String) {
		showMessage(title:title, message:message, theme:.success)
	}
	
	func showWarning(message: String) {
		showMessage(title:R.string.localizable.app_name(), message:message, theme:.warning)
	}
	
	func showWarning(title:String, message: String) {
		showMessage(title:title, message:message, theme:.warning)
	}
}

extension UIViewController {
	
	var isIphoneX:Bool{
		return UIScreen.main.bounds.height == heigthIphoneX
	}
	
	var marginTop:CGFloat{
		return (self.navigationController?.navigationBar.frame.height)! + UIApplication.shared.statusBarFrame.height
	}
	
	var isModal:Bool{
		return (self.presentingViewController != nil
			|| (self.navigationController?.presentingViewController != nil
				&& self.navigationController?.presentingViewController?.presentingViewController == self.navigationController)
			|| (self.tabBarController?.presentingViewController != nil
				&& (self.tabBarController?.presentingViewController?.isKind(of: UITabBarController.self))!))
			? true
			: false
	}
	
	var parentView:UIView{
		return ((isModal) ? self.navigationController != nil
			? self.navigationController?.view
			: self.view
			: AppDelegate.delegate.window?.rootViewController?.view)!
	}
	
	var isIpad:Bool{
		return UIDevice.current.userInterfaceIdiom == .pad
	}
}

