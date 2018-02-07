//
//  Map+Extension.swift
//  MapApp
//
//  Created by Jorge Sanmartin on 1/31/18.
//  Copyright © 2018 Jorge Sanmartin. All rights reserved.
//

import Foundation
import ObjectMapper

extension Map{
	
	static func mapFromJsonData<T>(_ data:Data, model:T.Type) -> T where T:Mappable{
		let json = try? JSONSerialization.jsonObject(with: data, options: [])
		let map = Map(mappingType: .fromJSON, JSON: (json as? [String: Any])!)
		return T(map:map)!
	}
}
