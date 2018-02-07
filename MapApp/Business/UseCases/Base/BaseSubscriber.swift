//
//  BaseUseCase.swift
//  MapApp
//
//  Created by Jorge Sanmartin on 1/31/18.
//  Copyright © 2018 Jorge Sanmartin. All rights reserved.
//

import Foundation
import RxSwift

extension ObservableType{
	func bindNext(_ onNext:@escaping (E)-> Void, onError:((Swift.Error) -> Void)? = nil)-> Disposable{
		return subscribe(onNext: onNext, onError: { (error) in
			onError!(error)
		}, onCompleted: {
		}, onDisposed: {
		})
	}
}

