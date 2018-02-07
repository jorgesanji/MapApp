//
//  HomePresenter.swift
//  MapApp
//
//  Created by Jorge Sanmartin on 1/31/18.
//  Copyright © 2018 Jorge Sanmartin. All rights reserved.
//

import Foundation
import UIKit

protocol HomePresenterOut : PresenterIn{
	func gotoMapTracking()
	func getTrack(at:Int) -> Track
	func getTrackCount() -> Int
	func didSelectTrack(at:Int)
}

protocol HomePresenterIn : PresenterOut{
	func reloadTrackList()
}

class HomePresenter: BasePresenter {
	
	fileprivate var tracks:[Track] = []
	fileprivate var accountManager:AccountManagerInterface?
	
	init(router:AppNavigation, view:HomePresenterIn, accountManager:AccountManagerInterface) {
		super.init(router: router)
		Logger.log("HomePresenter init")
		self.view = view
		self.accountManager = accountManager
	}
	
	override func viewDidAppear() {
		view?.showLoader()
		(interactor as! HomeInteractorIn).getTracks(userId: "")
	}
	
	override func viewDidLoad() {
		if (accountManager?.existUUID())!{
			view?.showAlertView(title: R.string.localizable.app_name(), message: R.string.localizable.message_user_already_register(), cancelBlock: nil, acceptBlock: { (action) in
				
			}, cancelTitle: nil, acceptTitle: R.string.localizable.ok_action())
		}else{
			accountManager?.saveUUID(UUID().uuidString)
		}
	}
}

extension HomePresenter: HomePresenterOut{
	
	func gotoMapTracking() {
		router?.gotoMapTracking(nil)
	}
	
	func getTrack(at: Int) -> Track {
		return tracks[at]
	}
	
	func getTrackCount() -> Int {
		return tracks.count
	}
	
	func didSelectTrack(at: Int) {
		router?.gotoMapTracking(tracks[at])
	}
}

extension HomePresenter: HomeInteractorOut{
	
	func didObtainError(_ error: Error) {
		Logger.log("didObtainError")
	}
	
	func didObtainTracks(_ tracks: [Track]) {
		Logger.log("didObtainTracks")
		self.tracks = tracks
		view?.hideLoader()
		(view as! HomePresenterIn).reloadTrackList()
	}
}
