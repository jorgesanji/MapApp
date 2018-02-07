//
//  AppTableDataSource.swift
//  MapApp
//
//  Created by Jorge Sanmartin on 1/31/18.
//  Copyright © 2018 Jorge Sanmartin. All rights reserved.
//

import Foundation
import UIKit
import ObjectMapper

class AppTableDatasource <T : UITableViewCell> : NSObject, UITableViewDataSource {
	
	typealias createCellBlock = (_ cell:T, _ indexPath:IndexPath?) -> T
	typealias sectionsCountBlock = () -> Int
	typealias sectionCountBlock = (_ section:Int) -> Int
	typealias editCellBlock = (_ indexPath:IndexPath?) -> Bool
	
	fileprivate var createBlock:createCellBlock?
	fileprivate var editBlock:editCellBlock?
	fileprivate var sectionsBlock:sectionsCountBlock?
	fileprivate var sectionBlock:sectionCountBlock?
	
	fileprivate var tableView:UITableView?
	fileprivate var cellClass:String?
	fileprivate var isCustomCell:Bool? = false
	fileprivate var cellStyle:UITableViewCellStyle?
	
	init(tableView:UITableView,
		 createBlock:@escaping createCellBlock,
		 sectionsBlock:@escaping sectionsCountBlock,
		 sectionBlock:@escaping sectionCountBlock,
		 editBlock:editCellBlock? = nil,
		 useCustomCell:Bool? = true,
		 style:UITableViewCellStyle? = .default,
		 reuseIdentifier:String? = nil){
		super.init()
		self.tableView = tableView
		self.createBlock = createBlock
		self.sectionBlock = sectionBlock
		self.sectionsBlock = sectionsBlock
		self.editBlock = editBlock
		self.isCustomCell = useCustomCell
		self.cellClass = isCustomCell! ? String(describing: T.self) : reuseIdentifier!
		self.cellStyle = style
		if isCustomCell!{
			self.tableView!.register(UINib(nibName:cellClass!, bundle: nil),
									 forCellReuseIdentifier: cellClass!)
		}
		
		self.tableView!.dataSource = self
	}
	
	// MARK:- UITableViewDataSource
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return sectionsBlock!()
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int)-> Int {
		return sectionBlock!(section)
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)-> UITableViewCell {
		var cell = tableView.dequeueReusableCell(withIdentifier: self.cellClass!)
		if !isCustomCell!{
			if cell == nil{
				cell = UITableViewCell(style: self.cellStyle!, reuseIdentifier: self.cellClass!)
			}
		}
		
		return createBlock!(cell! as! T, indexPath) as T
	}
	
	func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
		if let editBlock = self.editBlock{
			return editBlock(indexPath)
		}
		
		return false
	}
}
