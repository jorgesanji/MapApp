//
//  Localization.swift
//  MapApp
//
//  Created by Jorge Sanmartin on 1/31/18.
//  Copyright © 2018 Jorge Sanmartin. All rights reserved.
//

import Foundation
import UIKit
import ObjectiveC

private var labelCapitalizingKey: UInt8 = 19
private var buttonCapitalizingKey: UInt8 = 20

@IBDesignable
extension UITextField {
	
	@IBInspectable var localizedPlaceholder: String {
		get { return "" }
		set {
			self.placeholder = NSLocalizedString(newValue, comment: "")
		}
	}
}

@IBDesignable
extension UIBarItem {
	
	@IBInspectable var localizedTitle: String {
		get { return "" }
		set {
			self.title = NSLocalizedString(newValue, comment: "")
		}
	}
}

@IBDesignable
extension UINavigationItem {
	
	@IBInspectable var localizedTitle: String {
		get { return "" }
		set {
			self.title = NSLocalizedString(newValue, comment: "")
		}
	}
}

@IBDesignable
extension UITextView {
	
	@IBInspectable var localizedText: String {
		get { return self.text!  }
		set {
			self.text = NSLocalizedString(newValue, comment: "")
		}
	}
}

@IBDesignable
class AppLabel:UILabel {
	
	@IBInspectable var localizedText: String {
		get { return "" }
		set {
			let newText = NSLocalizedString(newValue, comment: "")
			self.text = capitalize ? newText.uppercased() : newText
		}
	}
	
	@IBInspectable var capitalize: Bool = false{
		didSet{
			self.text = capitalize ? self.text?.uppercased() : self.text
		}
	}
	
	open override func setValue(_ value: Any?, forKey key: String) {
		if let value = value as? String?, key == "localizedText" {
			self.localizedText = value!
		}else if let value = value as? Bool?, key == "capitalize" {
			self.capitalize = value!
		}else{
			super.setValue(value, forKey: key)
		}
	}
}

@IBDesignable
class AppButton:UIButton {
	
	@IBInspectable var localizedTitle: String = "" {
		didSet {
			let newText = NSLocalizedString(localizedTitle, comment: "")
			self.setTitle(NSLocalizedString(capitalize ? newText.uppercased() : newText , comment: ""), for: UIControlState.normal)
		}
	}
	
	@IBInspectable var capitalize: Bool = false{
		didSet{
			self.setTitle(capitalize ? self.currentTitle?.uppercased() : self.currentTitle, for: UIControlState.normal)
		}
	}
	
	open override func setValue(_ value: Any?, forKey key: String) {
		if let value = value as? String?, key == "localizedTitle" {
			self.localizedTitle = value!
		}else if let value = value as? Bool?, key == "capitalize" {
			self.capitalize = value!
		}else{
			super.setValue(value, forKey: key)
		}
	}
}

@IBDesignable
extension UISearchBar {
	
	@IBInspectable var localizedPrompt: String {
		get { return "" }
		set {
			self.prompt = NSLocalizedString(newValue, comment: "")
		}
	}
	
	@IBInspectable var localizedPlaceholder: String {
		get { return "" }
		set {
			self.placeholder = NSLocalizedString(newValue, comment: "")
		}
	}
}

@IBDesignable
extension UISegmentedControl {
	
	@IBInspectable var localized: Bool {
		get { return true }
		set {
			for index in 0..<numberOfSegments {
				let title = NSLocalizedString(titleForSegment(at: index)!, comment: "")
				setTitle(title, forSegmentAt: index)
			}
		}
	}
}
