//
//  Enviroment.swift
//  MapApp
//
//  Created by Jorge Sanmartin on 1/31/18.
//  Copyright © 2018 Jorge Sanmartin. All rights reserved.
//

import Foundation

enum Enviroment:Int{
	
	case test, dev, prod, stage
	
	var baseUrl:String{
		switch self {
		case .prod:
			return "https://api.mapapp.com" + version
		case .stage:
			return "http://stage.mapapp.com" + version
		default:
			return "http://test.mapapp.com" + version
		}
	}
	
	var imageBaseUrl:String{
		let versionImage = version.replacingOccurrences(of: "/", with: "")
		switch self {
		case .prod:
			return "https://s3-us-west-2.amazonaws.com/mapapp-"+versionImage+"-images-prod/"
		case .stage:
			return "https://s3-us-west-2.amazonaws.com/mapapp-"+versionImage+"-images-stage-env/"
		default:
			return "https://s3-us-west-2.amazonaws.com/mapapp-"+versionImage+"-images-test-env/"

		}
	}
	
	var backendVersion:Int{
		return 1
	}
	
	var version:String {
		return String().appendingFormat("/v%i/", backendVersion)
	}
	
	var loogerEnable:Bool{
		switch self {
		case .test:
			return true
		case .prod:
			return false
		case .stage:
			return true
		default:
			return false
		}
	}
}

