//
//  AwayBackup.swift
//
//  Generated using https://jsonmaster.github.io
//  Created on November 10, 2022
//
import Foundation
import SwiftyJSON

struct AwayBackup {

	let playerId: Int?
	let nameEn: String?
	let nameChs: String?
	let nameCht: String?
	let number: String?
	let positionId: String?
	let playerName: String?
	let playerNameChs: String?
	let playerNameEn: String?
	let playerPhoto: String?
	let playerBirthday: String?
	let playerHeight: String?
	let playerWeight: String?
	let playerCountry: String?
	let playerValue: String?

	init(_ json: JSON) {
		playerId = json["playerId"].intValue
		nameEn = json["nameEn"].stringValue
		nameChs = json["nameChs"].stringValue
		nameCht = json["nameCht"].stringValue
		number = json["number"].stringValue
		positionId = json["positionId"].stringValue
		playerName = json["playerName"].stringValue
		playerNameChs = json["playerNameChs"].stringValue
		playerNameEn = json["playerNameEn"].stringValue
		playerPhoto = json["playerPhoto"].stringValue
		playerBirthday = json["playerBirthday"].stringValue
		playerHeight = json["playerHeight"].stringValue
		playerWeight = json["playerWeight"].stringValue
		playerCountry = json["playerCountry"].stringValue
		playerValue = json["playerValue"].stringValue
	}

}