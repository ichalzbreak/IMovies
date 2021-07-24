//
//  MovieDetailModel.swift
//  IMovies
//
//  Created by Amrizal on 24/07/21.
//

import SwiftyJSON

struct MovieDetailModel {
    
    var id:Int?
    var title:String?
    var vote_count:Int?
    var original_language:String?
    var poster_path:String?
    var adult:Bool?
    var original_title:String?
    var backdrop_path:String?
    var overview:String?
    var release_date:String?
    var video:Bool?
    var genre_ids:[Int]?
    var vote_average:Float?
    var popularity:Float?
    
    init() {}
    
    init(fromMovieModel model:MovieModel) {
        id = model.id
        title = model.title
        vote_count = model.vote_count
        
    }
    
    init(fromJson json:JSON) {
        id = json["id"].int
        title = json["title"].string
        vote_count = json["vote_count"].int
        original_language = json["original_language"].string
        poster_path = json["poster_path"].string
        adult = json["adult"].bool
        original_title = json["original_title"].string
        backdrop_path = json["backdrop_path"].string
        overview = json["overview"].string
        release_date = json["release_date"].string
        video = json["video"].bool
        genre_ids = json["genre_ids"].arrayObject as? [Int]
        vote_average = json["vote_average"].float
        popularity = json["popularity"].float
        
    }
}

