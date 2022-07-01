//
//  MovieCompanieEntity.swift
//  WatchMovies
//
//  Created by sona setiana on 30/06/22.
//

import Foundation

struct MovieCompanieEntity : Decodable {
    var id: Int?
    var name: String?
    var logo_path: String?
    var origin_country: String?
}
