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
    func getListMovie() -> AnyPublisher<DataResponse<MovieResponse, Error>, Never>
    func getDetailMovie(movieId: Int) -> AnyPublisher<DataResponse<MovieDetailEntity, Error>, Never>
    func searchMovie(keyword: String) -> AnyPublisher<DataResponse<MovieResponse, Error>, Never>
}

class RemoteMovieDataSourceImpl : RemoteMovieDataSource {
    
    func getListMovie() -> AnyPublisher<DataResponse<MovieResponse, Error>, Never> {
        let url = "\(AppConfigs.BASE_URL)movie/popular?api_key=\(AppConfigs.API_KEY)&language=id-ID"
        return AF.request(URL(string: url)!, method: .get)
            .validate()
            .publishDecodable(type: MovieResponse.self)
            .map { response in
                response.mapError { error in
                    return error
                }
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func getDetailMovie(movieId: Int) -> AnyPublisher<DataResponse<MovieDetailEntity, Error>, Never> {
        let url = "\(AppConfigs.BASE_URL)movie/\(movieId))?api_key=\(AppConfigs.API_KEY)&language=id-ID"
        return AF.request(URL(string: url)!, method: .get)
            .validate()
            .publishDecodable(type: MovieDetailEntity.self)
            .map { response in
                response.mapError { error in
                    return error
                }
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func searchMovie(keyword: String) -> AnyPublisher<DataResponse<MovieResponse, Error>, Never> {
        let url = "\(AppConfigs.BASE_URL)search/movie?api_key=\(AppConfigs.API_KEY)&language=id-ID&query=\(keyword.replacingOccurrences(of: " ", with: "%20"))"
        return AF.request(URL(string: url)!, method: .get)
            .validate()
            .publishDecodable(type: MovieResponse.self)
            .map { response in
                response.mapError { error in
                    return error
                }
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
