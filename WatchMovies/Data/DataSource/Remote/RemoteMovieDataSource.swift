//
//  MovieDataSource.swift
//  WatchMovies
//
//  Created by sona setiana on 29/06/22.
//

import Foundation
import Combine
import Alamofire

protocol RemoteMovieDataSource {
    func getListMovie() -> DataRequest
    func getDetailMovie(movieId: Int) -> DataRequest
    func searchMovie(keyword: String) -> DataRequest
}

class RemoteMovieDataSourceImpl : RemoteMovieDataSource {
    
    func getListMovie() -> DataRequest {
        return AF.request("\(AppConfigs.BASE_URL)/movie/popular?api_key=\(AppConfigs.API_KEY)&language=id-ID", method: .get)
    }
    
    func getDetailMovie(movieId: Int) -> DataRequest {
        return AF.request("\(AppConfigs.BASE_URL)/movie/\(movieId))?api_key=\(AppConfigs.API_KEY)&language=id-ID", method: .get)
    }
    
    func searchMovie(keyword: String) -> DataRequest {
        return AF.request("\(AppConfigs.BASE_URL)/search/movie?api_key=\(AppConfigs.API_KEY)&language=id-ID&query=\(keyword)", method: .get)
    }
}
