//
//  RestApiManager.swift
//  MapApp
//
//  Created by Jorge Sanmartin on 1/31/18.
//  Copyright © 2018 Jorge Sanmartin. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper
import RxSwift
import ObjectMapper

protocol RestApiManagerInterface : class{
	var updateCredentials:UpdateCredentials?{set get}
	func initOAuth(accessToken:String, refreshToken:String, loginType:String)
	func request<T>(urlRequest:URLRequestConvertible) -> Observable<T> where  T:Mappable
	func request(urlRequest:URLRequestConvertible) -> Observable<Void>
	func request(urlRequest:URLRequestConvertible) -> Observable<DefaultDataResponse>
	func request<T>(urlRequest:URLRequestConvertible) -> Observable<[T]> where  T:Mappable
	func request(urlRequest:URLRequestConvertible) -> (response:String?, error:Error?)
	func request(urlRequest:URLRequestConvertible) -> Observable<String>
	func request(urlRequest:URLRequestConvertible) -> Observable<[String]>
	func request<T>(urlRequest:URLRequestConvertible) -> (response:T, error:Error )where  T:Mappable
	func request<T>(urlRequest:URLRequestConvertible) -> (response:[T], error:Error )where  T:Mappable
	func invalidateAndCancel()
}

class RestApiManager{
	
	fileprivate var sessionManger:SessionManager!
	fileprivate var retrier:AppRequestRetrier?
	weak var updateCredentials: UpdateCredentials?{
		didSet{
			self.retrier?.updateCredentials = updateCredentials!
		}
	}
	
	init() {
		self.sessionManger = SessionManager.manager(useSSL: false)
		self.retrier = AppRequestRetrier()
		sessionManger.retrier = retrier
		sessionManger.adapter = retrier
	}
}

extension RestApiManager: RestApiManagerInterface{
	
	func invalidateAndCancel() {
		sessionManger.session.getAllTasks { (tasks) in
			for task in tasks{
				task.cancel()
			}
		}
	}
	func initOAuth(accessToken:String, refreshToken:String, loginType:String) {
		retrier?.updateCredentials(accessToken: accessToken, refreshToken: refreshToken, loginType: loginType)
	}
	
	func request<T>(urlRequest:URLRequestConvertible) -> Observable<T> where  T:Mappable  {
		return sessionManger.request(urlRequest: urlRequest)
	}
	
	func request(urlRequest:URLRequestConvertible) -> Observable<Void> {
		return sessionManger.request(urlRequest: urlRequest)
	}
	
	func request(urlRequest:URLRequestConvertible) -> Observable<DefaultDataResponse> {
		return sessionManger.request(urlRequest: urlRequest)
	}
	
	func request<T>(urlRequest:URLRequestConvertible) -> Observable<[T]> where  T:Mappable  {
		return sessionManger.request(urlRequest: urlRequest)
	}
	
	func request(urlRequest:URLRequestConvertible) -> (response:String?, error:Error? ){
		return sessionManger.request(urlRequest: urlRequest)
	}
	
	func request<T>(urlRequest:URLRequestConvertible) -> (response:T, error:Error )where  T:Mappable{
		return sessionManger.request(urlRequest: urlRequest)
	}
	
	func request<T>(urlRequest:URLRequestConvertible) -> (response:[T], error:Error )where  T:Mappable{
		return sessionManger.request(urlRequest: urlRequest)
	}
	
	func request(urlRequest: URLRequestConvertible) -> Observable<String> {
		return sessionManger.request(urlRequest: urlRequest)
	}
	
	func request(urlRequest: URLRequestConvertible) -> Observable<[String]> {
		return sessionManger.request(urlRequest: urlRequest)
	}
}
