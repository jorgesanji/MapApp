//
//  HomeView.swift
//  MapApp
//
//  Created by Jorge Sanmartin on 1/31/18.
//  Copyright © 2018 Jorge Sanmartin. All rights reserved.
//

import UIKit

protocol HomeViewDelegate : ViewDelegate{
	func getTrack(at:Int) -> Track
	func getTrackCount() -> Int
	func didSelectTrack(at: Int)
}

class HomeView : BaseView {
	
	fileprivate var datasource:AppTableDatasource<TrackCellView>?
	
	weak var delegate:HomeViewDelegate?
	
	@IBOutlet fileprivate var tableView:UITableView?
	@IBOutlet fileprivate var emptyLabel:AppLabel?
	
	override func initUI() {
		tableView?.delegate = self
		tableView?.isHidden = true
		tableView?.rowHeight = AppDimentions.SIZE_ROW
		initDatasource()
	}
	
	fileprivate func initDatasource(){
		self.datasource = AppTableDatasource(tableView: tableView!, createBlock: { (cell, indexpath) -> TrackCellView in
			let track = self.delegate?.getTrack(at: (indexpath?.row)!)
			cell.title = R.string.localizable.track_number((indexpath?.row)!)
			cell.dateStart = R.string.localizable.start_date((track?.dateStart?.trackDate)!)
			cell.dateEnd = R.string.localizable.end_date((track?.dateEnd?.trackDate)!)
			return cell
		}, sectionsBlock: { () -> Int in
			return 1
		}, sectionBlock: { (section) -> Int in
			if let delegate = self.delegate{
				return delegate.getTrackCount()
			}
			return 0
		})
	}
	
	func reloadTrackList() {
		tableView?.reloadData()
		if let delegate = self.delegate{
			let emptyView = delegate.getTrackCount() > 0
			tableView?.isHidden = !emptyView
			emptyLabel?.isHidden = emptyView
		}
	}
}

extension HomeView : UITableViewDelegate{
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		delegate?.didSelectTrack(at: indexPath.row)
	}
}

