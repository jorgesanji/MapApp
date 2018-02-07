//
//  Track_Endpoints.swift
//  MapApp
//
//  Created by Jorge Sanmartin on 1/31/18.
//  Copyright © 2018 Jorge Sanmartin. All rights reserved.
//

import Foundation
import Alamofire

extension Endpoints{
	
	enum TrackEnd:URLRequestConvertible{
		case GetTracks(userId:String)
		case SaveTrack(track:Track)
		
		var method: Alamofire.HTTPMethod {
			switch self {
			case .GetTracks:
				return .get
			case .SaveTrack:
				return .post
			}
		}
		
		var path: String {
			switch self {
			case .GetTracks:
				return "tracks/"
			case .SaveTrack:
				return "tracks/"
			}
		}
		
		func asURLRequest() throws -> URLRequest {
			switch self {
			case .GetTracks(let userId):
				let url = API.baseUrl.appendingFormat("%@%@", path, userId)
				let originalRequest = try URLRequest(url: url, method: method, headers: nil)
				return try Endpoints.encode(originalRequest, with: nil)
			case .SaveTrack(let track):
				let url = API.baseUrl.appendingFormat("%@", path)
				let originalRequest = try URLRequest(url: url, method: method, headers: nil)
				return try Endpoints.encode(originalRequest, with: track.toJSON())
			}
		}
	}
}
