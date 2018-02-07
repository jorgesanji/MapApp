//
//  AppStyles.swift
//  MapApp
//
//  Created by Jorge Sanmartin on 2/4/18.
//  Copyright © 2018 Jorge Sanmartin. All rights reserved.
//

import Foundation
import UIKit

class AppStyles {
	
	static let textAtributes = [
		NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: AppDimentions.SIZE_FONT_TITLE_NAME_APP) ,
		NSAttributedStringKey.foregroundColor:UIColor.primary
	]
	
	static func applyGlobalStyle(){
		// Set navigation bar apparence
		UINavigationBar.appearance().titleTextAttributes = textAtributes
		UINavigationBar.appearance().tintColor = .primary
		UINavigationBar.appearance().barTintColor = .white
		
		// Set status bar styyle default
		UIApplication.shared.statusBarStyle = .lightContent
		
		// Set tint color on tab bar
		UITabBar.appearance().tintColor = .primary
		
		// Set selection color on cells
		let bgColorView = UIView()
		bgColorView.backgroundColor = UIColor.gray.withAlphaComponent(0.3)
		UITableViewCell.appearance().selectedBackgroundView = bgColorView
		// Set tint color on UITextView
		UITextView.appearance().tintColor = .primary
		
		// Set tint color on UITextField
		UITextField.appearance().tintColor = .primary
		
		// Set selected tint color on UITabBar
		UITabBar.appearance().tintColor = .primary
	}
	
	static func holderView(title:String, textColor:UIColor,
					  backgroundColor:UIColor, selector:Selector) -> UIView{
		let holderView = UIView()
		holderView.frame = CGRect(x: 0, y: 0, width: CGFloat.greatestFiniteMagnitude, height: AppDimentions.SIZE_TITLE)
		holderView.addBackgroundColor(backgroundColor, radius: AppDimentions.SIZE_TITLE)
		let label = UILabel.newAutoLayout()
		label.backgroundColor = .clear
		label.textColor = textColor
		label.font = UIFont.boldSystemFont(ofSize: AppDimentions.SIZE_TEXT_TITLE)
		label.text = title
		holderView.addSubview(label)
		label.autoPinEdge(toSuperviewEdge: .top, withInset: 0.5)
		label.autoPinEdge(toSuperviewEdge: .bottom, withInset: 0.5)
		label.autoPinEdge(toSuperviewEdge: .left, withInset: 0.5)
		label.autoPinEdge(toSuperviewEdge: .right, withInset: 0.5)
		return holderView
	}

}

extension UIView{
	
	func buildBorderAndRound(borderColor:UIColor){
		buildBorderAndRound(borderColor, borderWidth:2)
	}
	
	func buildBorderAndRound(_ borderColor:UIColor, borderWidth:CGFloat){
		buildRound()
		self.layer.masksToBounds = true
		self.layer.borderColor = borderColor.cgColor
		self.layer.borderWidth = borderWidth
	}
	
	func buildRound(_ height:CGFloat? = nil){
		var realheight = self.frame.size.height
		if height != nil {
			realheight = height!
		}
		self.layer.cornerRadius = realheight/2
		self.clipsToBounds = true
	}
	
	func buildBorder(backgroundColor:UIColor? = .clear){
		self.backgroundColor = backgroundColor
		self.layer.masksToBounds = true
		self.layer.borderColor = UIColor.white.cgColor
		self.layer.borderWidth = 2
	}
	
	func buildBorderAndRound(height:CGFloat? = nil){
		buildRound(height)
		buildBorder()
		self.layer.shouldRasterize = true
		self.layer.rasterizationScale = UIScreen.main.scale
	}
	
	func addBackgroundColor(_ color:UIColor, radius:CGFloat){
		self.backgroundColor = .clear
		self.layer.masksToBounds = false
		self.layer.backgroundColor = color.cgColor
		self.layer.cornerRadius = radius
		self.layer.shouldRasterize = true
		self.layer.borderColor = UIColor.clear.cgColor
		self.layer.borderWidth = 0
		self.layer.rasterizationScale = UIScreen.main.scale
	}
}
