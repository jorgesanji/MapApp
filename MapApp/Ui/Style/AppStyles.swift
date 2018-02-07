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
	
	func buildShadow(){
		self.layer.shadowColor = UIColor.black.cgColor
		self.layer.shadowRadius = 4.0
		self.layer.shadowOffset = CGSize(width: 3, height: 3)
		self.layer.shadowOpacity = 0.7
	}
	
	func putShadowOnView(_ heightShadow:CGFloat? = 4){
		self.layer.masksToBounds = false
		self.layer.shadowOffset = CGSize(width:0, height:heightShadow!)
		self.layer.shadowRadius = 1
		self.layer.shadowOpacity = 0.25
	}
	
	func buildCardStyle(viewTop:UIView) {
		buildCardStyle(viewBottom:self, viewTop:viewTop)
	}
	
	func buildCardStyle(viewBottom:UIView, viewTop:UIView) {
		viewBottom.putShadow()
		viewTop.layer.masksToBounds = false
		viewTop.layer.cornerRadius = 8.0
		viewTop.clipsToBounds = true
	}
	
	func putShadow(){
		self.layer.masksToBounds = false
		self.layer.backgroundColor = UIColor.white.cgColor
		self.layer.cornerRadius = 8.0
		self.layer.shadowOffset = CGSize(width: -0.5, height: -0.5)
		self.layer.shadowOpacity = 0.55
		self.layer.shadowRadius = 2.0
	}
}

