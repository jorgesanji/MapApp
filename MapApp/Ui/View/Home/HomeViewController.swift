//
//  HomeViewController.swift
//  MapApp
//
//  Created by Jorge Sanmartin on 1/31/18.
//  Copyright © 2018 Jorge Sanmartin. All rights reserved.
//

import UIKit

class HomeViewController: MVPViewController<HomeView, HomePresenter>{
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		rootView.delegate = self
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.navigationItem.title = R.string.localizable.app_name()
		self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: R.string.localizable.start_tracking(), style: .plain, target: self, action:#selector(HomeViewController.startTracking))
	}
	
	@objc func startTracking(){
		presenter?.gotoMapTracking()
	}
}

extension HomeViewController : HomePresenterIn{
	
	func reloadTrackList() {
		rootView.reloadTrackList()
	}
}

extension HomeViewController : HomeViewDelegate{
	
	func getTrackCount() -> Int {
		return (presenter?.getTrackCount())!
	}
	
	func getTrack(at: Int) -> Track {
		return (presenter?.getTrack(at:at))!
	}
	
	func didSelectTrack(at: Int) {
		presenter?.didSelectTrack(at: at)
	}
}
