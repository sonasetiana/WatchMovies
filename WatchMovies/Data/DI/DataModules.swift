//
//  DataModules.swift
//  WatchMovies
//
//  Created by sona setiana on 30/06/22.
//

import Foundation

class DataModules {
    static let shared = DataModules()
    
    func provideLocalMovieDataSource() -> LocalMovieDataSource {
        let manager = CoreDataManager()
        return LocalMovieDataSourceImpl(presistence: manager)
    }
    
    func provideRemoteMovieDataSource() -> RemoteMovieDataSource {
        return RemoteMovieDataSourceImpl()
    }
    
    func provideMovieRepository() -> MovieRepository {
        return MovieRepositoryImpl(
            localDataSource: provideLocalMovieDataSource(),
            remoteDataSource: provideRemoteMovieDataSource()
        )
    }
}
