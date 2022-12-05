//
//  TodayHotLeague.swift
//
//  Generated using https://jsonmaster.github.io
//  Created on September 19, 2022
//
import Foundation
import SwiftyJSON

struct TodayHotLeague {

	var leagueId: Int?
	let leagueEn: String?
	let leagueEnShort: String?
	let leagueChsShort: String?
	var leagueName: String?
	let leagueNameShort: String?
    
    init(){
        leagueId = nil
        leagueEn = ""
        leagueEnShort = ""
        leagueChsShort = ""
        leagueName = ""
        leagueNameShort = ""
    }

	init(_ json: JSON) {
		leagueId = json["leagueId"].intValue
		leagueEn = json["leagueEn"].stringValue
		leagueEnShort = json["leagueEnShort"].stringValue
		leagueChsShort = json["leagueChsShort"].stringValue
		leagueName = json["leagueName"].stringValue
		leagueNameShort = json["leagueNameShort"].stringValue
	}

}
