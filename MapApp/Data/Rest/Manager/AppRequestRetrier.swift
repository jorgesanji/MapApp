//
//  RequestRetrier.swift
//  MapApp
//
//  Created by Jorge Sanmartin on 1/31/18.
//  Copyright © 2018 Jorge Sanmartin. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

let HEADER_ACCESS_TOKEN = "x_access_token"
let HEADER_REFRESH_TOKEN = "x_refresh_token"
let HEADER_ACCEPT_LANGUAGE = "accept-language"
let HEADER_TYPE = "x_token_type"
let HEADER_CONTENT_TYPE = "Content-Type"
let HEADER_ACCEPT = "Accept"
let CONTENT_TYPE = "application/json"
let HEADER_TOKEN_TYPE = "type"
let HEADER_TOKEN_TYPE_VALUE = "apn"

enum Status : Int{
	case UPDATING = 1
	case WORKING = 2
}

class AppRequestRetrier: RequestRetrier{
	
	fileprivate var status:Status!
	var allHTTPHeaderFields:[String:String]?
	weak var updateCredentials:UpdateCredentials?
	var defaulHeaders:[String:String]{
		var headers = [String:String]()
		headers[HEADER_ACCEPT_LANGUAGE] = NSLocale.CurrentLanguage
		headers[HEADER_CONTENT_TYPE] = CONTENT_TYPE
		headers[HEADER_TOKEN_TYPE] = HEADER_TOKEN_TYPE_VALUE
		return headers
	}
	
	init() {
		self.status = Status.WORKING
		self.allHTTPHeaderFields = defaulHeaders
	}
	
	private func renewCredentials(){
		// Do request to backen in order to renew acces and refresh tokens
	}
	
	private func updateToken(){
		if self.updateCredentials != nil
			&& self.status == Status.WORKING {
			objc_sync_enter(self)
			self.status = Status.UPDATING
			renewCredentials()
			self.status = Status.WORKING
			objc_sync_exit(self)
		}
	}
	
	func should(_ manager: SessionManager, retry request: Request, with error: Error,
	            completion: @escaping RequestRetryCompletion) {
		if  error is AFError{
			if (error as! AFError).responseCode == HttpCodes.HTTP_UNAUTHORIZED{
				updateToken()
				completion(true,SessionManager.DELAY_TIME_TO_RETRY)
			}else{
				completion(false,0)
			}
		}else{
			completion(false,0)
		}
	}
}

extension AppRequestRetrier:RequestAdapter{
	
	func updateCredentials(accessToken:String, refreshToken:String, loginType:String){
		var headers = defaulHeaders
		headers[HEADER_ACCESS_TOKEN] = accessToken
		headers[HEADER_REFRESH_TOKEN] = refreshToken
		headers[HEADER_TYPE] = loginType
		self.allHTTPHeaderFields = headers
	}
	
	func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
		var headers = allHTTPHeaderFields!
		if let contentType = urlRequest.allHTTPHeaderFields?[HEADER_CONTENT_TYPE]{
			headers[HEADER_CONTENT_TYPE] = contentType
		}
		
		if urlRequest.allHTTPHeaderFields?[HEADER_TYPE] != nil{
			headers[HEADER_TYPE] = urlRequest.allHTTPHeaderFields?[HEADER_TYPE]
		}
		
		return urlRequest.setHeaders(headers)
	}
}
