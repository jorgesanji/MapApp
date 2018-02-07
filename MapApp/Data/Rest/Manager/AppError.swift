//
//  AppError.swift
//  MapApp
//
//  Created by Jorge Sanmartin on 1/31/18.
//  Copyright © 2018 Jorge Sanmartin. All rights reserved.
//

import Foundation

let unknown_error:String = "Unknown error"

class AppError : Error{
	
	var statusCode:Int?
	var code:Int?
	var message:String?
	var description:String{
		return String().appendingFormat("statusCode:%d - code:%d - message:%@", statusCode == nil ? -1 :statusCode!, code == nil ? -1 :code!,message == nil ? unknown_error :message!)
	}
	
	init(statusCode:Int? = -1, code:Int? = -1, message:String? = unknown_error) {
		self.statusCode =  statusCode
		self.code =  code
		self.message =  message
	}
	
	static func errorFromData(_ data:Data? = nil) -> AppError{
		let error = AppError()
		do{
			let json = try JSONSerialization.jsonObject(with: data!) as? [String: Any]
			Logger.log((json?.description)!)
			error.statusCode = json?["statusCode"] as? Int
			error.code = json?["code"] as? Int
			error.message = json?["message"] as? String
		}catch{
			Logger.log("Error parsing")
		}
		return error
	}
}

extension Error{
	
	var description:String{
		if let responseError:AppError = self as? AppError {
			return responseError.description
		}
		return ""
	}
	
	// Error userBlocked
	// statusCode:-1
	// code:1403
	func isUserChatBlocked() -> Bool{
		guard let responseError:AppError = self as? AppError else{
			return false
		}
		return responseError.code == HttpCodes.HTTP_USER_CHAT_BLOCKED_ERROR
	}
	
	// Error happens when user do login and he try to put a phone number but this is already exist
	// statusCode:409
	// code:219
	func isUserExistAndHasPhone() -> Bool{
		if isUserNoFoundError(){
			guard let responseError:AppError = self as? AppError else{
				return false
			}
			return responseError.code == HttpCodes.HTTP_USER_EXIST_AND_HAS_PHONE
		}
		return false
	}
	
	// Facebook Error
	// statusCode:409
	// code:242
	func isFacebooError() -> Bool{
		if isUserNoFoundError(){
			guard let responseError:AppError = self as? AppError else{
				return false
			}
			return responseError.code == HttpCodes.HTTP_FACEBOOK_ERROR
		}
		return false
	}
	
	// Password invalid Error
	// statusCode:400
	// code:251
	func isPasswordError() -> Bool{
		if isNofoundError(){
			guard let responseError:AppError = self as? AppError else{
				return false
			}
			return responseError.code == HttpCodes.HTTP_PASSWORD_INVALID_ERROR
		}
		return false
	}
	
	// User blocked Error
	// statusCode:403
	// code:251
	func isUserBlockedError() -> Bool{
		if isForbiddenError(){
			guard let responseError:AppError = self as? AppError else{
				return false
			}
			return responseError.code == HttpCodes.HTTP_USER_BLOCKED_ERROR
		}
		return false
	}
	
	// User no exist Error
	// statusCode:409
	// code:226
	func isUserNoExistError() -> Bool{
		if isUserNoFoundError(){
			guard let responseError:AppError = self as? AppError else{
				return false
			}
			return responseError.code == HttpCodes.HTTP_USER_NO_EXIST_ERROR
		}
		return false
	}
	
	// Password mismatch
	// statusCode:409
	// code:240
	func isPasswordMismatchError() -> Bool{
		if isUserNoFoundError(){
			guard let responseError:AppError = self as? AppError else{
				return false
			}
			return responseError.code == HttpCodes.HTTP_USER_PASSWORD_ERROR
		}
		return false
	}
	
	
	// 400
	func isNofoundError() -> Bool{
		guard let responseError:AppError = self as? AppError else{
			return false
		}
		return responseError.statusCode == HttpCodes.HTTP_UNDEFINED_ERROR
	}
	
	//403
	func isForbiddenError() -> Bool{
		guard let responseError:AppError = self as? AppError else{
			return false
		}
		return responseError.statusCode == HttpCodes.HTTP_FORBIDDEN_ERROR
	}
	
	//409
	func isUserNoFoundError() -> Bool{
		guard let responseError:AppError = self as? AppError else{
			return false
		}
		return responseError.statusCode == HttpCodes.HTTP_USER_NO_FOUND_ERROR
	}
}
