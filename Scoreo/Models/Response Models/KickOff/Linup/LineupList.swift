//
//  LineupList.swift
//
//  Generated using https://jsonmaster.github.io
//  Created on November 10, 2022
//
import Foundation
import SwiftyJSON

struct LineupList {

	let matchId: Int?
	let homeArray: String?
	let awayArray: String?
	let homeLineup: [Lineup]?
	let awayLineup: [Lineup]?
	let homeBackup: [HomeBackup]?
	let awayBackup: [AwayBackup]?

	init(_ json: JSON) {
		matchId = json["matchId"].intValue
		homeArray = json["homeArray"].stringValue
		awayArray = json["awayArray"].stringValue
		homeLineup = json["homeLineup"].arrayValue.map { Lineup($0) }
		awayLineup = json["awayLineup"].arrayValue.map { Lineup($0) }
		homeBackup = json["homeBackup"].arrayValue.map { HomeBackup($0) }
		awayBackup = json["awayBackup"].arrayValue.map { AwayBackup($0) }
	}

}
