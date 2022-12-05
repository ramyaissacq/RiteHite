//
//  InitField.swift
//
//  Generated using https://jsonmaster.github.io
//  Created on November 18, 2022
//
import Foundation
import SwiftyJSON

struct InitField {

	let openType: String?
	let redirectUrl: String?

	init(_ json: JSON) {
		openType = json["open_type"].stringValue
		redirectUrl = json["redirect_url"].stringValue
	}

}