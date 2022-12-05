//
//  LinupPlayer.swift
//  Scoreo
//
//  Created by Remya on 11/10/22.
//

import Foundation

struct LinupPlayer{
    var id:Int?
    var name:String
    var image:String
    
    init(id:Int,name:String,image:String){
        self.id = id
        self.name = name
        self.image = image
    }
    
    init(obj:PreviewLineup?){
        if Utility.getCurrentLang() == "cn"{
        self.name = obj?.nameChs ?? ""
        }
        else{
            self.name = obj?.nameEn ?? ""
        }
        self.image = ""
        self.id = obj?.playerId
    }
    
    init(obj:Lineup?){
        if Utility.getCurrentLang() == "cn"{
        self.name = obj?.nameChs ?? ""
        }
        else{
            self.name = obj?.nameEn ?? ""
        }
        self.image = obj?.playerPhoto ?? ""
        self.id = obj?.playerId
    }
}
