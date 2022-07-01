//
//  MovieDetailEntity.swift
//  WatchMovies
//
//  Created by sona setiana on 30/06/22.
//

import Foundation

struct MovieDetailEntity : Decodable {
    var id: Int?
    var adult : Bool?
    var backdrop_path: String?
    var original_language: String?
    var original_title: String?
    var overview: String?
    var popularity: Double?
    var poster_path: String?
    var release_date: String?
    var title: String?
    var status: String?
    var budget: Int?
    var revenue: Int?
    var genres: [MovieGenreEntity]
    var production_companies: [MovieCompanieEntity]
    var spoken_languages: [MovieSpokenLanguageEntity]
    var production_countries: [MovieCountryEntity]
}
