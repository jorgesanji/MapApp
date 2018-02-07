//
//  Endpoints.swift
//  MapApp
//
//  Created by Jorge Sanmartin on 1/31/18.
//  Copyright © 2018 Jorge Sanmartin. All rights reserved.
//

import Foundation
import Alamofire

struct Endpoints {
	
	static func jsoEncode(_ urlRequest:URLRequestConvertible, with:Parameters? = nil) throws -> URLRequest{
		return try JSONEncoding.default.customEncode(urlRequest, with: with)
	}
	
	static func urlEncode(_ urlRequest:URLRequestConvertible, with:Parameters? = nil) throws -> URLRequest{
		return try URLEncoding.default.customEncode(urlRequest, with: with)
	}
	
	static func encode(_ urlRequest:URLRequestConvertible, with:Parameters? = nil) throws -> URLRequest{
		let request = try urlRequest.asURLRequest()
		if request.httpMethod  == "GET" {
			return try urlEncode(urlRequest, with: with)
		}
		return try jsoEncode(urlRequest, with: with)
	}
}

