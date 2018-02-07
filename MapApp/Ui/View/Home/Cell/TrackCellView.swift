//
//  TrackCellView.swift
//  MapApp
//
//  Created by Jorge Sanmartin on 1/31/18.
//  Copyright © 2018 Jorge Sanmartin. All rights reserved.
//

import Foundation
import UIKit

class TrackCellView : UITableViewCell {
	
	@IBOutlet fileprivate var trackTitleLabel:UILabel?
	@IBOutlet fileprivate var trackDateStartLabel:UILabel?
	@IBOutlet fileprivate var trackDateEndLabel:UILabel?
	
	var title:String = ""{
		didSet{
			trackTitleLabel?.text = title
		}
	}
	
	var dateStart:String = ""{
		didSet{
			trackDateStartLabel?.text = dateStart
		}
	}
	
	var dateEnd:String = ""{
		didSet{
			trackDateEndLabel?.text = dateEnd
		}
	}
}
