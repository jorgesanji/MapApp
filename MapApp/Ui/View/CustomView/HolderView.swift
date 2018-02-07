//
//  HolderView.swift
//  Tinkerlink
//
//  Created by Jorge Sanmartin on 9/5/17.
//  Copyright © 2017 Cronos group. All rights reserved.
//

import Foundation
import UIKit

let defaultHeight:CGFloat = 30
let defaultWidth:CGFloat = 140

class HolderView : UIView {
	
	static var `default`:HolderView{
		let filterView = HolderView(frame:CGRect(x: 0, y: 0, width: defaultWidth, height: defaultHeight))
		return filterView
	}
	
	static func create(title:String, titleColor:UIColor, backgroundColor:UIColor, target:Any, selector:Selector) -> HolderView{
		let holderView = HolderView.default
		holderView.titleText = title
		holderView.titleColor = titleColor
		holderView.colorBacground = backgroundColor
		holderView.setSelector(selector, target: target)
		return holderView
	}
	
	fileprivate var titleLabel:UILabel?
	
	var width:CGFloat = defaultWidth
	
	var colorBacground:UIColor = .white{
		didSet{
			addBackgroundColor(colorBacground, radius: defaultHeight/2)
		}
	}
	
	var titleColor:UIColor = .primary{
		didSet{
			titleLabel?.textColor = titleColor
		}
	}
	
	var titleText:String = ""{
		didSet{
			titleLabel?.text = titleText
		}
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		initViews()
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		initViews()
	}
	
	private func initViews(){
		self.titleLabel = UILabel.newAutoLayout()
		titleLabel?.backgroundColor = .clear
		titleLabel?.textAlignment = .center
		titleLabel?.font = UIFont.boldSystemFont(ofSize: AppDimentions.SIZE_TEXT_TITLE)
		self.addSubview(titleLabel!)
		titleLabel?.autoPinEdge(toSuperviewEdge: .top, withInset: 0.5)
		titleLabel?.autoPinEdge(toSuperviewEdge: .bottom, withInset: 0.5)
		titleLabel?.autoPinEdge(toSuperviewEdge: .left, withInset: 0.5)
		titleLabel?.autoPinEdge(toSuperviewEdge: .right, withInset: 0.5)
	}
	
	override var intrinsicContentSize: CGSize{
		get{
			return CGSize(width: width, height: defaultHeight)
		}
	}
	
	func setSelector(_ selector:Selector?, target:Any){
		if let selector = selector{
			self.isUserInteractionEnabled = true
			if self.gestureRecognizers != nil{
				for gesture in self.gestureRecognizers!{
					self.removeGestureRecognizer(gesture)
				}
			}
			let tapGesture = UITapGestureRecognizer(target: target, action: selector)
			addGestureRecognizer(tapGesture)
		}
	}
}

