//
//  MVPController.swift
//  MapApp
//
//  Created by Jorge Sanmartin on 1/31/18.
//  Copyright © 2018 Jorge Sanmartin. All rights reserved.
//

import Foundation
import UIKit

class MVPViewController<V:BaseView, P:BasePresenter> : BaseViewController{

	/// override root view
	var rootView:V! { return self.view as! V }
	
	override func loadView() {
		let view = V.fromNib()
		view.frame = UIScreen.main.bounds
		self.view = view
		self.view.layoutIfNeeded()
	}
	
	var presenter:P?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		presenter?.viewDidLoad()
		rootView.reStartLoader()
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		presenter?.viewDidAppear()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		presenter?.viewWillAppear()
	}
	
	override func viewDidDisappear(_ animated: Bool) {
		super.viewDidDisappear(animated)
		presenter?.viewDidDisappear()
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		presenter?.viewDidDisappear()
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		presenter?.didReceiveMemoryWarning()
	}
}
