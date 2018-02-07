//
//  BaseView.swift
//  MapApp
//
//  Created by Jorge Sanmartin on 1/16/17.
//  Copyright © 2017 Cronos group. All rights reserved.
//

import Foundation
import UIKit
import PureLayout
import ObjectiveC
import M13ProgressSuite

let loaderTag:Int = 2001
var xLoadernKey: UInt8 = 0
var xLoadernMarginTopKey: UInt8 = 0
var xMiddleLoaderKey: UInt8 = 1
let marginTopLoader:CGFloat = 20
let minMarginBottonIphoneX:CGFloat = 34

protocol ViewDelegate : class{
	var isIpad:Bool{get}
	var isIphoneX:Bool{get}
	var marginTop:CGFloat{get}
}

class BaseView: UIView{
	
	fileprivate var overLayView:UIView? = nil
	fileprivate var progressBar:M13ProgressViewBar?
	fileprivate var topLoaderConstraint:NSLayoutConstraint?
	
	var observerKeyboard:Bool? = false{
		didSet{
			if observerKeyboard!{
				attachKeyBoardObserver()
			}else{
				removeKeyBoardObserver()
			}
		}
	}
	
	var marginTopLoader:CGFloat?{
		didSet{
			if let topConstraint = self.topLoaderConstraint{
				topConstraint.constant = marginTopLoader!
			}
		}
	}
	
	var marginTopOverlay:CGFloat? = 0
	
	var addOverlay:Bool?{
		didSet{
			if addOverlay!{
				if self.overLayView == nil{
					self.overLayView = UIView(frame: UIScreen.main.bounds)
					self.overLayView?.backgroundColor = UIColor.primary.withAlphaComponent(0.7)
					self.overLayView?.translatesAutoresizingMaskIntoConstraints = false
					addSubview(self.overLayView!)
					bringSubview(toFront: overLayView!)
					overLayView?.autoCenterInSuperview()
					overLayView?.autoPinEdge(toSuperviewEdge: .top, withInset:marginTopOverlay!)
					overLayView?.autoPinEdge(toSuperviewEdge: .left)
					overLayView?.autoPinEdge(toSuperviewEdge: .right)
					overLayView?.autoPinEdge(toSuperviewEdge: .bottom)
					self.overLayView?.onClick = {
						self.addOverlay = false
					}
					updateConstraints()
					fadeAnimation(self.overLayView!, inOut: true)
				}
			}else if(!(addOverlay!) && overLayView != nil){
				UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to:nil, from:nil, for:nil)
				self.dissmissOverlay(false)
				fadeAnimation(self.overLayView!, inOut: false, completion: { (finished) in
					self.overLayView?.removeFromSuperview()
					self.overLayView = nil
					self.dissmissOverlay(true)
				})
			}
		}
	}
	
	//	MARK: DEFAULT VIEW CONSTRUCTORS
	
	required init(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)!
		initLoader()
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		initLoader()
	}
	
	init() {
		super.init(frame: CGRect())
		initLoader()
	}
	
	override func awakeFromNib() {
		initUI()
	}
	
	func initUI(){}
	
	fileprivate func initLoader(){
		self.progressBar = M13ProgressViewBar.newAutoLayout()
		progressBar?.primaryColor = .primary
		progressBar?.secondaryColor = .white
		progressBar?.progressBarCornerRadius = 2
		progressBar?.progressBarThickness = 4
		self.addSubview(progressBar!)
		progressBar?.autoSetDimension(.height, toSize: 7)
		self.topLoaderConstraint = progressBar?.autoPinEdge(toSuperviewEdge: .top)
		progressBar?.autoPinEdge(toSuperviewEdge: .left)
		progressBar?.autoPinEdge(toSuperviewEdge: .right, withInset:-30)
		progressBar?.isHidden = true
	}
	
	fileprivate func attachKeyBoardObserver(){
		NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(sender:)), name:NSNotification.Name.UIKeyboardWillShow, object: nil)
		NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(sender:)), name:NSNotification.Name.UIKeyboardWillHide, object: nil)
	}
	
	fileprivate func removeKeyBoardObserver(){
		NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
		NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
	}
	
	@objc fileprivate func keyboardWillShow(sender:Notification){
		var userInfo = sender.userInfo!
		var keyboardFrame:CGRect = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
		keyboardFrame = self.convert(keyboardFrame, from: nil)
		keyboardDiddAppear(keyboardFrame)
	}
	
	@objc fileprivate func keyboardWillHide(sender:Notification){
		keyboardDidDissAppear()
	}
	
	func reStartLoader(){
		if !(progressBar?.isHidden)!{
			progressBar?.indeterminate = true
		}
	}
	
	func showLoader(){
		if (progressBar?.isHidden)!{
			progressBar?.indeterminate = true
			progressBar?.isHidden = false
			self.bringSubview(toFront: progressBar!)
		}
	}
	
	func stopLoader(){
		progressBar?.isHidden = true
	}
	
	func keyboardDiddAppear(_ keyboardFrame:CGRect){}
	
	func keyboardDidDissAppear(){}
	
	func fadeAnimation(_ view:UIView, inOut:Bool,  completion: ((Bool) -> Swift.Void)? = nil){
		view.alpha = inOut ? 0 : 1
		UIView.animate(withDuration: 0.5, animations: {
			view.alpha = inOut ? 1 : 0
		}) { (finished) in
			view.isHidden = !inOut
			if let completion = completion{
				completion(finished)
			}
		}
	}
	
	func dissmissOverlay(_ finished:Bool){}
	
	func updateUIForIphoneX(){}
}

extension UIView{
	
	var marginSafeAreaBotton:CGFloat{
		if #available(iOS 11.0, *) {
			return self.safeAreaInsets.bottom == 0 ? minMarginBottonIphoneX : self.safeAreaInsets.bottom
		}
		
		return 0
	}
	
	var marinTopConstraint:NSLayoutConstraint?{
		get{
			return objc_getAssociatedObject(self, &xLoadernMarginTopKey) as? NSLayoutConstraint
		}
		
		set{
			objc_setAssociatedObject(self, &xLoadernMarginTopKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
		}
	}
	
	var hasLoader:Bool?{
		get {
			return objc_getAssociatedObject(self, &xLoadernKey) as? Bool
		}
		
		set(newValue) {
			objc_setAssociatedObject(self, &xLoadernKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
			var loaderView:UIActivityIndicatorView? = nil
			if let loader:UIActivityIndicatorView = viewWithTag(loaderTag) as? UIActivityIndicatorView{
				loaderView = loader
			}else{
				loaderView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
				loaderView?.translatesAutoresizingMaskIntoConstraints = false
				loaderView?.hidesWhenStopped = true
				loaderView?.tag = loaderTag
				loaderView?.color = .primary
				addSubview(loaderView!)
				bringSubview(toFront: loaderView!)
				self.marinTopConstraint = loaderView?.autoPinEdge(toSuperviewEdge: .top, withInset:-marginTopLoader)
				loaderView?.autoAlignAxis(toSuperviewAxis: .vertical)
			}
			
			if newValue!{
				loaderView?.startAnimating()
				self.marinTopConstraint?.constant = marginTopLoader
				animateConstraints()
			}else{
				self.marinTopConstraint?.constant = -marginTopLoader
				animateConstraints(completion: { (finished) in
					loaderView?.stopAnimating()
				})
			}
		}
	}
	
	func animateConstraints(completion: ((Bool) -> Swift.Void)? = nil){
		UIView.animate(withDuration: 2,
		               delay: 0,
		               usingSpringWithDamping: 10,
		               initialSpringVelocity: 5,
		               options: [.allowUserInteraction, .curveEaseInOut],
		               animations: {
						self.layoutIfNeeded()
		},completion: completion)
	}
}
