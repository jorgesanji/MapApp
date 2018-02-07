//
//  CrossFadingAnimator.swift
//  Tinkerlink
//
//  Created by Jorge Sanmartin on 1/31/18.
//  Copyright © 2017 Cronos group. All rights reserved.
//

import Foundation
import UIKit

open class CrossFadingTransition: NSObject {
	
	/**
	The transition duration. The same value is used in both the Present or Dismiss actions
	Defaults to `0.5`
	*/
	open var duration = 0.5
	
	/**
	The transition direction. Possible values `.present`, `.dismiss` or `.pop`
	Defaults to `.Present`
	*/
	open var transitionMode: CrossFadingTransitionTransitionMode = .present
	
	/**
	The possible directions of the transition.
	
	- Present: For presenting a new modal controller
	- Dismiss: For dismissing the current controller
	- Pop: For a pop animation in a navigation controller
	*/
	@objc public enum CrossFadingTransitionTransitionMode: Int {
		case present, dismiss, pop
	}
}

extension CrossFadingTransition: UIViewControllerAnimatedTransitioning {
	
	// MARK: - UIViewControllerAnimatedTransitioning
	/**
	Required by UIViewControllerAnimatedTransitioning
	*/
	public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
		return duration
	}
	
	/**
	Required by UIViewControllerAnimatedTransitioning
	*/
	public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
		
		let containerView = transitionContext.containerView
		
		let fromViewController = transitionContext.viewController(forKey: .from)
		let toViewController = transitionContext.viewController(forKey: .to)
		
		fromViewController?.beginAppearanceTransition(false, animated: true)
		toViewController?.beginAppearanceTransition(true, animated: true)
		
		if transitionMode == .present {
			let presentedControllerView = transitionContext.view(forKey: UITransitionContextViewKey.to)!
			containerView.backgroundColor = .clear
			
			let darkBlurEffect = UIBlurEffect(style: .dark)
			let vizualEffect = UIVisualEffectView(effect: darkBlurEffect)
			vizualEffect.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: UIScreen.main.bounds.size)
			vizualEffect.alpha = 0
			vizualEffect.tag = 123
			containerView.addSubview(vizualEffect)
			
			var frame = presentedControllerView.frame
			frame.origin.y = UIScreen.main.bounds.size.height
			presentedControllerView.frame = frame
			containerView.addSubview(presentedControllerView)
			containerView.clipsToBounds = true
			
			UIView.animate(withDuration: duration, animations: {
				presentedControllerView.frame = CGRect(origin: CGPoint(x:0,y:0), size: frame.size)
				presentedControllerView.alpha = 1
				vizualEffect.alpha = 1
			}, completion: { (_) in
				transitionContext.completeTransition(true)
				
				fromViewController?.endAppearanceTransition()
				toViewController?.endAppearanceTransition()
			})
		} else {
			let key = (transitionMode == .pop) ? UITransitionContextViewKey.to : UITransitionContextViewKey.from
			let returningControllerView = transitionContext.view(forKey: key)!
			var frame = returningControllerView.frame
			frame.origin.y = UIScreen.main.bounds.size.height
			
			let	 vizualEffect =  containerView.viewWithTag(123)

			UIView.animate(withDuration: duration, animations: {
				vizualEffect?.alpha = 0
				returningControllerView.frame = frame
				returningControllerView.alpha = 0
				containerView.backgroundColor =  .clear
				if self.transitionMode == .pop {
					containerView.insertSubview(returningControllerView, belowSubview: returningControllerView)
				}
			}, completion: { (_) in
				vizualEffect?.removeFromSuperview()
				returningControllerView.removeFromSuperview()
				transitionContext.completeTransition(true)
				
				fromViewController?.endAppearanceTransition()
				toViewController?.endAppearanceTransition()
			})
		}
	}
}
