//
//  BaseUsecase.swift
//  MapApp
//
//  Created by Jorge Sanmartin on 1/31/18.
//  Copyright © 2018 Jorge Sanmartin. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

class BaseUseCase<K>{
	
	internal var subscriberScheduler:SchedulerType?
	internal var observableScheduler:SerialDispatchQueueScheduler?
	fileprivate var disposable:Disposable?
	var proxyService: ProxyServiceInterface?
	
	init(proxyService:ProxyServiceInterface) {
		self.proxyService = proxyService
		initRx()
	}
	
	init() {
		initRx()
	}
	
	private func initRx(){
		self.subscriberScheduler = ConcurrentDispatchQueueScheduler(qos: .default)
		self.observableScheduler = MainScheduler.instance
	}
	
	func subscribe(_ onNext:@escaping (K)-> Void, onError:((Swift.Error) -> Void)? = nil){
		self.disposable = buildUseCaseObservable().retry(2).subscribeOn(subscriberScheduler!)
			.observeOn(observableScheduler!).bindNext(onNext, onError: onError)
	}
	
	func buildUseCaseObservable() -> Observable<K> {
		preconditionFailure("please override this method and build your observable")
	}
	
	func unsubscribe(){
		if (disposable != nil){
			disposable?.dispose()
		}
		disposable = nil
	}
	
	func isUnsubscribe()->Bool{
		return (disposable != nil)
	}
	
	func build() -> BaseUseCase<K> {
		return self
	}
}

