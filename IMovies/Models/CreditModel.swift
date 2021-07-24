//
//  CreditModel.swift
//  IMovies
//
//  Created by Amrizal on 24/07/21.
//

import SwiftyJSON

struct CreditModel {
    
    var id:Int?
    var gender:Int?
    var adult:Bool?
    var known_for_department:String?
    var name:String?
    var original_name:String?
    var popularity:Float?
    var profile_path:String?
    var cast_id:Int?
    var character:String?
    var credit_id:String?
    var order:Int?
    var department:String?
    var job:String?
    
    init() {}
    
    init(fromJson json:JSON) {
        id = json["id"].int
        gender = json["title"].int
        adult = json["adult"].bool
        known_for_department = json["known_for_department"].string
        name = json["name"].string
        original_name = json["original_name"].string
        popularity = json["popularity"].float
        profile_path = json["profile_path"].string
        cast_id = json["cast_id"].int
        character = json["character"].string
        credit_id = json["credit_id"].string
        order = json["order"].int
        department = json["department"].string
        job = json["job"].string
    }
}

struct CreditListModel {
    var cast:[CreditModel] = [CreditModel]()
    var crew:[CreditModel] = [CreditModel]()
    
    init() { }
    
    init(fromJson json:JSON) {
        cast = json["cast"].arrayValue.compactMap{return CreditModel(fromJson: $0)}
        crew = json["crew"].arrayValue.compactMap{return CreditModel(fromJson: $0)}
    }
}
