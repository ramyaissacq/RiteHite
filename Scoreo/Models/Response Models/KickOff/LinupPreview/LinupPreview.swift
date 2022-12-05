//
//  LinupPreview.swift
//
//  Generated using https://jsonmaster.github.io
//  Created on November 10, 2022
//
import Foundation
import SwiftyJSON

struct LinupPreview {

	let lineupList: [PreviewLineupList]?

	init(_ json: JSON) {
		lineupList = json["lineupList"].arrayValue.map { PreviewLineupList($0) }
	}

}
