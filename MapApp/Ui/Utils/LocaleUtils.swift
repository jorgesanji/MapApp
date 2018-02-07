//
//  LocaleUtils.swift
//  MapApp
//
//  Created by Jorge Sanmartin on 1/31/18.
//  Copyright © 2018 Jorge Sanmartin. All rights reserved.
//

import Foundation
import CoreTelephony

extension NSLocale{
	static let CountryCode = NSLocale.current.regionCode
	
	static let CurrentLanguage = NSLocale.preferredLanguages[0].substring(to: NSLocale.preferredLanguages[0].index(NSLocale.preferredLanguages[0].startIndex, offsetBy: 2))
}
