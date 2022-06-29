//
//  MovieEntity.swift
//  WatchMovies
//
//  Created by sona setiana on 29/06/22.
//

import Foundation

struct MovieEntity : Decodable {
    var id: Int?
    var adult : Bool?
    var backdrop_path: String?
    var genre_ids: [Int]?
    var original_language: String?
    var original_title: String?
    var overview: String?
    var popularity: Double?
    var poster_path: String?
    var release_date: String?
    var title: String?
    var video: Bool?
    var vote_average: Double?
    var vote_count: Int
    var status: String?
    var tagline: String?
    var budget: Int?
    var revenue: Int?
    var imdb_id: String?
    var genres: [MovieGenre]
    var production_companies: [MovieCompanie]
    var spoken_languages: [MovieSpokenLanguage]
    var production_countries: [MovieCountry]
}


struct MovieGenre : Decodable{
    var id: Int?
    var name: String?
}

struct MovieCompanie : Decodable {
    var id: Int?
    var name: String?
    var logo_path: String?
    var origin_country: String?
}

struct MovieSpokenLanguage : Decodable{
    var iso_639_1: Int?
    var name: String?
    var english_name: String?
}

struct MovieCountry : Decodable{
    var iso_639_1: Int?
    var name: String?
    var english_name: String?
}
