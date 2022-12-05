//
//  RootClass.swift
//
//  Generated using https://jsonmaster.github.io
//  Created on November 10, 2022
//
import Foundation
import SwiftyJSON

struct LinupResponse {

	let lineupList: [LineupList]?

	init(_ json: JSON) {
		lineupList = json["lineupList"].arrayValue.map { LineupList($0) }
	}

}
