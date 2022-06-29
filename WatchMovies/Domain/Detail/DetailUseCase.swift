//
//  DetailUseCase.swift
//  WatchMovies
//
//  Created by sona setiana on 29/06/22.
//

import Foundation

protocol DetailUseCase {
    func getDetailMovie(movieId: Int, completion: @escaping (Result<MovieEntity, Error>) -> Void)
    func saveMovieToFavorite(movie: MovieEntity, completion: @escaping (Result<String, Error>) -> Void)
    func removeMovieFromFavorite(movie: MovieEntity, completion: @escaping (Result<String, Error>) -> Void)
}

class DetailInteractor : DetailUseCase {
    let repository : MovieRepository
    
    init(repository : MovieRepository) {
        self.repository = repository
    }
    
    func getDetailMovie(movieId: Int, completion: @escaping (Result<MovieEntity, Error>) -> Void) {
        repository.getDetailMovie(movieId: movieId, completion: completion)
    }
    
    func saveMovieToFavorite(movie: MovieEntity, completion: @escaping (Result<String, Error>) -> Void) {
        repository.saveFavorite(movie: movie, completion: completion)
    }
    
    func removeMovieFromFavorite(movie: MovieEntity, completion: @escaping (Result<String, Error>) -> Void) {
        repository.deleteFavorite(movie: movie, completion: completion)
    }
}
