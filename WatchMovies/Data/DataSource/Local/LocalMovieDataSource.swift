//
//  LocalMovieDataSource.swift
//  WatchMovies
//
//  Created by sona setiana on 29/06/22.
//

import Foundation
import Combine
import CoreData

protocol LocalMovieDataSource {
    func saveFavorite(movie: MovieDetailEntity, completion: @escaping (Result<String, Error>) -> Void)
    func deleteFavorite(movieId: Int, completion: @escaping (Result<String, Error>) -> Void)
    func getListFavorite(completion: @escaping (Result<[FavoriteTable], Error>) -> Void)
    func findFavorite(id: Int, completion: @escaping (Result<Bool, Error>) -> Void)
}

class LocalMovieDataSourceImpl : LocalMovieDataSource{
    
    private let presistence : CoreDataManager
    
    init(presistence: CoreDataManager) {
        self.presistence = presistence
    }
    
    private func provideFavoriteTable(movie: MovieDetailEntity, context: NSManagedObjectContext){
        let table = FavoriteTable(context: context)
        table.id = Int32(movie.id ?? 0)
        table.title = movie.title ?? ""
        table.genres = convertGenresToString(items: movie.genres)
        table.image = movie.backdrop_path
        table.releaseDate = movie.release_date ?? ""
    }
    
    func saveFavorite(movie: MovieDetailEntity, completion: @escaping (Result<String, Error>) -> Void) {
        presistence.getPresistenContainer().performBackgroundTask { context in
            self.provideFavoriteTable(movie: movie, context: context)
            do {
                try context.save()
                completion(.success("Success save favorite"))
            }catch {
                completion(.failure(error))
            }
        }
    }
    
    func deleteFavorite(movieId: Int, completion: @escaping (Result<String, Error>) -> Void) {
        presistence.getPresistenContainer().performBackgroundTask{ context in
            do {
                let favorites : NSFetchRequest<FavoriteTable> = FavoriteTable.fetchRequest()
                let results = try context.fetch(favorites)
                results.filter{
                    $0.id == movieId
                }.forEach { item in
                    context.delete(item)
                }
                try context.save()
                completion(.success("Success delete favorite"))
            }catch {
                completion(.failure(error))
                context.rollback()
            }
        }
    }
    
    func getListFavorite(completion: @escaping (Result<[FavoriteTable], Error>) -> Void) {
        let context = presistence.getViewContext()
        context.perform {
            do {
                let request : NSFetchRequest<FavoriteTable> = FavoriteTable.fetchRequest()
                let favorites = try context.fetch(request)
                completion(.success(favorites))
            }catch {
                completion(.failure(error))
            }
        }
    }
    
    func findFavorite(id: Int, completion: @escaping (Result<Bool, Error>) -> Void) {
        let context = presistence.getViewContext()
        context.perform {
            do {
                let request : NSFetchRequest<FavoriteTable> = FavoriteTable.fetchRequest()
                let favorites = try context.fetch(request).filter{$0.id == id}
                completion(.success(!favorites.isEmpty))
            }catch {
                completion(.failure(error))
            }
        }
    }
}
