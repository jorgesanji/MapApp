//
//  Rest+Extentions.swift
//  MapApp
//
//  Created by Jorge Sanmartin on 1/31/18.
//  Copyright © 2018 Jorge Sanmartin. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper
import ObjectMapper
import RxSwift

extension SessionManager{
	
	static let REQUEST_TIME_OUT:TimeInterval = 120.0
	static let RESOURCE_TIME_OUT:TimeInterval = 120.0
	static let DELAY_TIME_TO_RETRY:TimeInterval = 5.0
	
	static func manager(useSSL:Bool? = false)-> SessionManager{
		let configuration = URLSessionConfiguration.default
		configuration.timeoutIntervalForRequest = SessionManager.REQUEST_TIME_OUT
		configuration.timeoutIntervalForResource = SessionManager.RESOURCE_TIME_OUT
		if useSSL!{
			let serverTrustPolicies: [String: ServerTrustPolicy] = [
				API.baseUrl: .disableEvaluation
			]
			let serverTrustManager = ServerTrustPolicyManager(policies: serverTrustPolicies)
			return SessionManager(configuration: configuration,
			                      serverTrustPolicyManager: serverTrustManager)
		}
		return SessionManager(configuration: configuration)
	}
	
	func request<T>(urlRequest:URLRequestConvertible) -> Observable<T> where  T:Mappable  {
		return Observable<T>.create { observer -> Disposable in
			let request = self.createRequest(urlRequest)
				.responseObject(completionHandler: { (response:DataResponse<T>) in
					self.validateData(observer, response: response)
				})
			return self.createDisposable(request)
		}
	}
	
	func request(urlRequest:URLRequestConvertible) -> Observable<String> {
		return Observable<String>.create { observer -> Disposable in
			let request = self.createRequest(urlRequest)
				.responseString(completionHandler: { (response:DataResponse<String>) in
					self.validateData(observer, response: response)
				})
			return self.createDisposable(request)
		}
	}
	
	func request(urlRequest:URLRequestConvertible) -> Observable<[String]> {
		return Observable<[String]>.create { observer -> Disposable in
			let request = self.createRequest(urlRequest).response(completionHandler: { (response) in
				if response.error == nil{
					let json = try? JSONSerialization.jsonObject(with: response.data!, options: [])
					observer.onNext(json as! [String])
				}else{
					observer.onError(AppError.errorFromData(response.data))
				}
				DispatchQueue.main.async {
					UIApplication.shared.isNetworkActivityIndicatorVisible = false
				}
			})
			return self.createDisposable(request)
		}
	}
	
	func request(urlRequest:URLRequestConvertible) -> Observable<Void> {
		return Observable<Void>.create { observer -> Disposable in
			let request = self.createRequest(urlRequest)
				.response(completionHandler: { (response) in
					self.validateData(observer, response: response)
				})
			return self.createDisposable(request)
		}
	}
	
	func request(urlRequest:URLRequestConvertible) -> Observable<DefaultDataResponse> {
		return Observable<DefaultDataResponse>.create { observer -> Disposable in
			let request = self.createRequest(urlRequest)
				.response(completionHandler: { (response) in
					self.validateData(observer, response: response)
				})
			return self.createDisposable(request)
		}
	}
	
	func request<T>(urlRequest:URLRequestConvertible) -> Observable<[T]> where  T:Mappable  {
		return Observable<[T]>.create { observer -> Disposable in
			let request = self.createRequest(urlRequest)
				.responseArray(completionHandler: { (response:DataResponse<[T]>) in
					self.validateData(observer, response: response)
				})
			return self.createDisposable(request)
		}
	}
	
	func request(urlRequest:URLRequestConvertible) -> (response:String?, error:Error?){
		let semaphore = DispatchSemaphore(value: 0)
		var value:String? = nil
		var errorRequest:Error? = nil
		_ = self.createRequest(urlRequest).responseString(completionHandler: { (response:DataResponse<String>) in
			switch response.result {
			case .success(let object):
				value = object.replacingOccurrences(of: "\\", with: "").replacingOccurrences(of: "\"", with: "")
			case .failure(_):
				errorRequest = AppError.errorFromData(response.data)
			}
			semaphore.signal()
		})
		_ = semaphore.wait(timeout: .distantFuture)
		DispatchQueue.main.async {
			UIApplication.shared.isNetworkActivityIndicatorVisible = false
		}
		return (value, errorRequest)
	}
	
	func request<T>(urlRequest:URLRequestConvertible) -> (response:T, error:Error )where  T:Mappable  {
		let semaphore = DispatchSemaphore(value: 0)
		var value:T? = nil
		var errorRequest:Error? = nil
		_ = self.createRequest(urlRequest)
			.responseObject(completionHandler: { (response:DataResponse<T>) in
				switch response.result {
				case .success(let object):
					value = object
				case .failure(_):
					errorRequest = AppError.errorFromData(response.data)
				}
				semaphore.signal()
			})
		_ = semaphore.wait(timeout: .distantFuture)
		DispatchQueue.main.async {
			UIApplication.shared.isNetworkActivityIndicatorVisible = false
		}
		return (value!, errorRequest!)
	}
	
	func request<T>(urlRequest:URLRequestConvertible) -> (response:[T], error:Error )where  T:Mappable  {
		let semaphore = DispatchSemaphore(value: 0)
		var value:[T]? = nil
		var errorRequest:Error? = nil
		_ = self.createRequest(urlRequest)
			.responseArray(completionHandler: { (response:DataResponse<[T]>) in
				switch response.result {
				case .success(let objects):
					value = objects
				case .failure(_):
					errorRequest = AppError.errorFromData(response.data)
				}
				semaphore.signal()
			})
		_ = semaphore.wait(timeout: .distantFuture)
		DispatchQueue.main.async {
			UIApplication.shared.isNetworkActivityIndicatorVisible = false
		}
		return (value!, errorRequest!)
	}
}

extension SessionManager{
	
	fileprivate func validateData<T:Mappable>(_ observer:AnyObserver<T>, response:DataResponse<T>){
		DispatchQueue.main.async {
			UIApplication.shared.isNetworkActivityIndicatorVisible = false
		}
		switch response.result {
		case .success(let objects):
			observer.onNext(objects)
			observer.onCompleted()
		case .failure(_):
			observer.onError(AppError.errorFromData(response.data))
		}
	}
	
	fileprivate func validateData(_ observer:AnyObserver<String>, response:DataResponse<String>){
		DispatchQueue.main.async {
			UIApplication.shared.isNetworkActivityIndicatorVisible = false
		}
		switch response.result {
		case .success(let objects):
			observer.onNext(objects)
			observer.onCompleted()
		case .failure(_):
			observer.onError(AppError.errorFromData(response.data))
		}
	}
	
	fileprivate func validateData<T:Mappable>(_ observer:AnyObserver<[T]>, response:DataResponse<[T]>){
		DispatchQueue.main.async {
			UIApplication.shared.isNetworkActivityIndicatorVisible = false
		}
		switch response.result {
		case .success(let objects):
			observer.onNext(objects)
			observer.onCompleted()
		case .failure(_):
			observer.onError(AppError.errorFromData(response.data))
		}
	}
	
	fileprivate func validateData(_ observer:AnyObserver<Void>, response:DefaultDataResponse){
		DispatchQueue.main.async {
			UIApplication.shared.isNetworkActivityIndicatorVisible = false
		}
		if response.error == nil{
			observer.onNext(())
		}else{
			observer.onError(AppError.errorFromData(response.data))
		}
	}
	
	fileprivate func validateData(_ observer:AnyObserver<DefaultDataResponse>, response:DefaultDataResponse){
		DispatchQueue.main.async {
			UIApplication.shared.isNetworkActivityIndicatorVisible = false
		}
		if response.error == nil{
			observer.onNext(response)
		}else{
			observer.onError(AppError.errorFromData(response.data))
		}
	}
	
	fileprivate func createRequest(_ urlRequest: URLRequestConvertible) -> DataRequest{
		DispatchQueue.main.async {
			UIApplication.shared.isNetworkActivityIndicatorVisible = true
		}
		return request(urlRequest)
			.validate()
			.logg()
	}
	
	fileprivate func createDisposable(_ request:DataRequest) -> Disposable{
		return Disposables.create(with: {
			request.cancel()
		})
	}
}

extension DataRequest{
	
	func logg()-> Self{
		return responseData(completionHandler: { (response) in
			if response.result.isSuccess{
				let datastring = NSString(data:response.data!, encoding:String.Encoding.utf8.rawValue)! as String
				Logger.log(datastring)
			}else{
				Logger.log(AppError.errorFromData(response.data).description)
			}
		})
	}
}

extension URLRequest{
	
	func mutableCopy() ->NSMutableURLRequest{
		return((self as NSURLRequest).mutableCopy() as? NSMutableURLRequest)!
	}
	
	func setHeaders(_ headers:[String:String]) -> URLRequest {
		Logger.log(headers.description)
		let request = mutableCopy()
		request.allHTTPHeaderFields = headers
		return request as URLRequest
	}
}

extension JSONEncoding{
	
	func customEncode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest{
		if parameters != nil{
			Logger.log((parameters?.description)!)
		}
		let request = try self.encode(urlRequest, with: parameters)
		Logger.log((request.url?.absoluteString)!)
		return request
	}
}

extension URLEncoding{
	
	func customEncode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest{
		if parameters != nil{
			Logger.log((parameters?.description)!)
		}
		
		let request = try self.encode(urlRequest, with: parameters)
		Logger.log((request.url?.absoluteString)!)
		return request
	}
}

extension URLSession{
	
	func syncRequest(_ urlRequest:URLRequest) ->(data:Data?, code:HTTPURLResponse?){
		var data:Data? = nil
		var responseCode:HTTPURLResponse? = nil
		let semaphore = DispatchSemaphore(value: 0)
		dataTask(with:urlRequest) {(responseData, response, error) -> Void in
			data = responseData
			responseCode = response as! HTTPURLResponse?
			semaphore.signal()
			}.resume()
		_ = semaphore.wait(timeout: .distantFuture)
		return (data,responseCode)
	}
	
	func syncRequest<T>(_ urlRequest:URLRequest, model:T.Type) -> T where T:Mappable{
		let data: Data? = syncRequest(urlRequest).data
		let json = try? JSONSerialization.jsonObject(with: data!, options: [])
		let map = Map(mappingType: .fromJSON, JSON: (json as? [String: Any])!)
		return T(map:map)!
	}
}


