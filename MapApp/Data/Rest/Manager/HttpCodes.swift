//
//  ErrorCodes.swift
//  MapApp
//
//  Created by Jorge Sanmartin on 1/31/18.
//  Copyright © 2018 Jorge Sanmartin. All rights reserved.
//

import Foundation

struct HttpCodes {
	static let HTTP_UNDEFINED_ERROR = 400
	static let HTTP_UNAUTHORIZED = 401
	static let HTTP_CREATED = 201
	static let HTTP_USER_EXIST_AND_HAS_PHONE = 219
	static let HTTP_USER_NO_FOUND_ERROR = 409
	static let HTTP_FORBIDDEN_ERROR = 403
	static let HTTP_USER_CHAT_BLOCKED_ERROR = 1403
	
	static let HTTP_FACEBOOK_ERROR = 242 // 409
	static let HTTP_PASSWORD_INVALID_ERROR = 251 // 400
	static let HTTP_USER_BLOCKED_ERROR = 252 // 403
	static let HTTP_USER_NO_EXIST_ERROR = 226 // 409
	static let HTTP_USER_NO_AUTHORIZED = 105 // 401
	static let HTTP_USER_PASSWORD_ERROR = 240 // 409
	static let HTTP_INVALID_REFRESH_TOKEN_ERROR = 245 // 401
}
