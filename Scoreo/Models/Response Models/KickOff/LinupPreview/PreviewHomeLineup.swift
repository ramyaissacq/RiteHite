//
//  PreviewHomeLineup.swift
//
//  Generated using https://jsonmaster.github.io
//  Created on November 10, 2022
//
import Foundation
import SwiftyJSON

struct PreviewLineup {

	let playerId: Int?
	let nameEn: String?
	let nameChs: String?
	let nameCht: String?
	let number: String?
	let positionId: String?

	init(_ json: JSON) {
		playerId = json["playerId"].intValue
		nameEn = json["nameEn"].stringValue
		nameChs = json["nameChs"].stringValue
		nameCht = json["nameCht"].stringValue
		number = json["number"].stringValue
		positionId = json["positionId"].stringValue
	}

}
