//
//  HomeUseCase.swift
//  WatchMovies
//
//  Created by sona setiana on 29/06/22.
//

import Foundation
import UIKit

protocol HomeUseCase {
    func getListMovies(completion: @escaping (Result<[MovieEntity], Error>) -> Void)
    func searchMovies(keyword: String, completion: @escaping (Result<[MovieEntity], Error>) -> Void)
}

class HomeInteractor : HomeUseCase {
    let repository : MovieRepository
    
    init(repository : MovieRepository) {
        self.repository = repository
    }
    
    func getListMovies(completion: @escaping (Result<[MovieEntity], Error>) -> Void) {
        repository.getListMovie(completion: completion)
    }
    
    func searchMovies(keyword: String, completion: @escaping (Result<[MovieEntity], Error>) -> Void) {
        repository.searchMovie(keyword: keyword, completion: completion)
    }
}
