//
//  PopAnimator.swift
//  Tinkerlink
//
//  Created by Jorge Sanmartin on 1/31/18.
//  Copyright © 2017 Cronos group. All rights reserved.
//

import Foundation
import UIKit

class PopAnimator:NSObject, UIViewControllerAnimatedTransitioning{
	
	func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
		return 0.25
	}
	
	func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
		let toViewController = transitionContext.viewController(forKey: .to)
		let fromViewController = transitionContext.viewController(forKey: .from)
		transitionContext.containerView.insertSubview((toViewController?.view)!, belowSubview: (fromViewController?.view)!)
		UIView.animate(withDuration: self.transitionDuration(using: transitionContext), animations: {
			toViewController?.view.alpha = 1.0
			fromViewController?.view.alpha = 0.0
			fromViewController?.view.frame = CGRect(x:0,
			                                      y:UIScreen.main.bounds.size.height,
			                                      width:UIScreen.main.bounds.size.width,
			                                      height:UIScreen.main.bounds.size.height)
		}) { (finished) in
			transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
		}
	}
}
