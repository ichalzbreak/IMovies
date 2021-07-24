//
//  GenreModel.swift
//  IMovies
//
//  Created by Amrizal on 23/07/21.
//

import SwiftyJSON

struct GenreModel {
    
    var id:String
    var title:String?
    
    init(fromJson json:JSON) {
        id = json["id"].stringValue
        title = json["name"].string
    }
    
}
