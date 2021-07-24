//
//  UrlConstant.swift
//  IMovies
//
//  Created by Amrizal on 23/07/21.
//

struct UrlConstant {
    
    static let baseUrl = "https://api.themoviedb.org/3/"
    static let imageUrl = "https://image.tmdb.org/t/p/"
    
    static let pathConfiguration = baseUrl + "configuration"
    static let pathGenreList = baseUrl + "genre/movie/list"
    static let pathMovieList = baseUrl + "discover/movie"
    static let pathMovieDetail = baseUrl + "movie/"
    
}
