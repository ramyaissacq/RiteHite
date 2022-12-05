//
//  Mapping.swift
//
//  Generated using https://jsonmaster.github.io
//  Created on November 15, 2022
//
import Foundation
import SwiftyJSON

struct Mapping {

	var keyword: String?
	var redirectUrl: String?
	var openType: String?

    
    init(){
        keyword = ""
        redirectUrl = ""
        openType = ""
    }
    
	init(_ json: JSON) {
		keyword = json["keyword"].stringValue
		redirectUrl = json["redirect_url"].stringValue
		openType = json["open_type"].stringValue
	}
    
    func toDictionary() -> [String:Any]{
        var dict = [String:Any]()
        dict["keyword"] = keyword ?? ""
        dict["redirect_url"] = redirectUrl ?? ""
        dict["open_type"] = openType ?? ""
        return dict
    }

}
