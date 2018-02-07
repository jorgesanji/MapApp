//
//  PushAnimator.swift
//  Tinkerlink
//
//  Created by Jorge Sanmartin on 1/31/18.
//  Copyright © 2017 Cronos group. All rights reserved.
//

import Foundation
import UIKit

class PushAnimator:NSObject, UIViewControllerAnimatedTransitioning{
	
	func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
		return 0.25
	}
	
	func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
		let toViewController = transitionContext.viewController(forKey: .to)
		transitionContext.containerView.addSubview((toViewController?.view)!)
		toViewController?.view.alpha = 0.0
		toViewController?.view.frame = CGRect(x:0, y:UIScreen.main.bounds.size.height,
		                                      width:UIScreen.main.bounds.size.width,
		                                      height:UIScreen.main.bounds.size.height)
		
		let statusBarplusNavigationBar = (toViewController?.navigationController?.navigationBar.bounds.size.height)! +
			UIApplication.shared.statusBarFrame.size.height
		
		UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 3, options: .curveEaseInOut, animations: {
			toViewController?.view.alpha = 1.0
			toViewController?.view.frame = CGRect(x:0,
			                                      y:statusBarplusNavigationBar,
			                                      width:UIScreen.main.bounds.size.width,
			                                      height:UIScreen.main.bounds.size.height -
				statusBarplusNavigationBar)
		}) { _ in
			transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
			toViewController?.endAnimation()
		}
	}
}

extension UIViewController{
	
	func endAnimation(){
	}
}
