//
//  PreviewLineupList.swift
//
//  Generated using https://jsonmaster.github.io
//  Created on November 10, 2022
//
import Foundation
import SwiftyJSON

struct PreviewLineupList {

	let matchId: Int?
	let homeArray: String?
	let awayArray: String?
	let homeLineup: [PreviewLineup]?
	let awayLineup: [PreviewLineup]?
	

	init(_ json: JSON) {
		matchId = json["matchId"].intValue
		homeArray = json["homeArray"].stringValue
		awayArray = json["awayArray"].stringValue
		homeLineup = json["homeLineup"].arrayValue.map { PreviewLineup($0) }
		awayLineup = json["awayLineup"].arrayValue.map { PreviewLineup($0) }
		
	}

}
