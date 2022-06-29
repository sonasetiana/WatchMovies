//
//  FavoriteUseCase.swift
//  WatchMovies
//
//  Created by sona setiana on 29/06/22.
//

import Foundation

protocol FavoriteUseCase {
    func getListFavorite(completion: @escaping (Result<[FavoriteTable], Error>) -> Void)
    func removeFavorite(table: FavoriteTable, completion: @escaping (Result<String, Error>) -> Void)
}

class FavoriteInteractor : FavoriteUseCase {
    let repository : MovieRepository
    
    init(repository : MovieRepository) {
        self.repository = repository
    }
    
    func getListFavorite(completion: @escaping (Result<[FavoriteTable], Error>) -> Void) {
        repository.getListFavorite(completion: completion)
    }
    
    func removeFavorite(table: FavoriteTable, completion: @escaping (Result<String, Error>) -> Void) {
        repository.deleteFavorite(table: table, completion: completion)
    }
}
