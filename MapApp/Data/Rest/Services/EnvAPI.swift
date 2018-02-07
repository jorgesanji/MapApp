//
//  EnvAPI.swift
//  MapApp
//
//  Created by Jorge Sanmartin on 1/31/18.
//  Copyright © 2018 Jorge Sanmartin. All rights reserved.
//

import Foundation

#if DEBUG
let enviroment:Enviroment = .test
#else
let enviroment:Enviroment = .prod
#endif

struct API {
	static let baseUrl = enviroment.baseUrl
	static let imagesUrl = enviroment.imageBaseUrl
}
