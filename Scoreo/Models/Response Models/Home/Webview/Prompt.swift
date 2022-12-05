//
//  Prompt.swift
//
//  Generated using https://jsonmaster.github.io
//  Created on November 04, 2022
//
import Foundation
import SwiftyJSON

struct Prompt {

	let frequency: Int?
	let title: String?
	let message: String?
    let open_type:String?
    let redirect_url:String?
    let repeat_status: Int?
    let repeat_time: Int?
    let button:String?

	init(_ json: JSON) {
		frequency = json["frequency"].intValue
		title = json["title"].stringValue
		message = json["message"].stringValue
        open_type = json["open_type"].stringValue
        redirect_url = json["redirect_url"].stringValue
        repeat_status = json["repeat_status"].intValue
        repeat_time = json["repeat_time"].intValue
        button = json["button"].stringValue
	}

}
