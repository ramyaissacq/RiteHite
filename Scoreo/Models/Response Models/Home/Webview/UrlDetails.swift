//
//  RootClass.swift
//
//  Generated using https://jsonmaster.github.io
//  Created on October 11, 2022
//
import Foundation
import SwiftyJSON

struct UrlDetails {

    let status: Int?
    let message: String?
    let version: String?
    let buildNumber: String?
    let whatsNew: String?
    let lastUpdated: String?
    //let map: String?
    let initField:InitField?
    let prompt: Prompt?
    let banner: [Banner]?
    let region: Region?
    let mapping: [Mapping]?
    

	init(_ json: JSON) {
        status = json["status"].intValue
        message = json["message"].stringValue
        version = json["version"].stringValue
        buildNumber = json["build_number"].stringValue
        whatsNew = json["whats_new"].stringValue
        lastUpdated = json["last_updated"].stringValue
       // map = json["map"].stringValue
        prompt = Prompt(json["prompt"])
        banner = json["banner"].arrayValue.map { Banner($0) }
        region = Region(json["region"])
        mapping = json["mapping"].arrayValue.map { Mapping($0) }
        initField = InitField(json["init"])
        
       
        
	}

}
