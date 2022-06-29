//
//  MovieRepository.swift
//  WatchMovies
//
//  Created by sona setiana on 29/06/22.
//

import Foundation
import Combine

protocol MovieRepository {
    func getListMovie(completion: @escaping (Result<[MovieEntity], Error>) -> Void)
    func getDetailMovie(movieId: Int, completion: @escaping (Result<MovieEntity, Error>) -> Void)
    func searchMovie(keyword: String, completion: @escaping (Result<[MovieEntity], Error>) -> Void)
    func saveFavorite(movie: MovieEntity, completion: @escaping (Result<String, Error>) -> Void)
    func deleteFavorite(movie: MovieEntity, completion: @escaping (Result<String, Error>) -> Void)
    func getListFavorite(completion: @escaping (Result<[FavoriteTable], Error>) -> Void)
}

class MovieRepositoryImpl : MovieRepository{
    private let localDataSource : LocalMovieDataSource
    private let remoteDataSource : RemoteMovieDataSource
    private var cancellableSet: Set<AnyCancellable> = []
    
    init(localDataSource: LocalMovieDataSource, remoteDataSource: RemoteMovieDataSource) {
        self.localDataSource = localDataSource
        self.remoteDataSource = remoteDataSource
    }
    
    func getListMovie(completion: @escaping (Result<[MovieEntity], Error>) -> Void) {
        remoteDataSource
            .getListMovie()
            .publishDecodable(type: [MovieEntity].self)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { (response) in
                switch response.result {
                case .success(let items):
                    completion(.success(items))
                case .failure(let error):
                    completion(.failure(error))
                }
            }).store(in: &cancellableSet)
    }
    
    func getDetailMovie(movieId: Int, completion: @escaping (Result<MovieEntity, Error>) -> Void) {
        remoteDataSource
            .getDetailMovie(movieId: movieId)
            .publishDecodable(type: MovieEntity.self)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { (response) in
                switch response.result {
                case .success(let items):
                    completion(.success(items))
                case .failure(let error):
                    completion(.failure(error))
                }
            }).store(in: &cancellableSet)
    }
    
    func searchMovie(keyword: String, completion: @escaping (Result<[MovieEntity], Error>) -> Void) {
        remoteDataSource
            .searchMovie(keyword: keyword)
            .publishDecodable(type: [MovieEntity].self)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { (response) in
                switch response.result {
                case .success(let items):
                    completion(.success(items))
                case .failure(let error):
                    completion(.failure(error))
                }
            }).store(in: &cancellableSet)
    }
    
    func saveFavorite(movie: MovieEntity, completion: @escaping (Result<String, Error>) -> Void) {
        DispatchQueue.main.async {
            self.localDataSource.saveFavorite(movie: movie, completion: completion)
        }
    }
    
    func deleteFavorite(movie: MovieEntity, completion: @escaping (Result<String, Error>) -> Void) {
        DispatchQueue.main.async {
            self.localDataSource.deleteFavorite(movie: movie, completion: completion)
        }
    }
    
    func getListFavorite(completion: @escaping (Result<[FavoriteTable], Error>) -> Void) {
        localDataSource.getListFavorite(completion: completion)
    }
    
    
}
