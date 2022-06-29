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
    func saveFavorite(movie: MovieEntity, completion: @escaping (Result<String, Error>) -> Void)
    func deleteFavorite(movie: MovieEntity, completion: @escaping (Result<String, Error>) -> Void)
    func getListFavorite(completion: @escaping (Result<[FavoriteTable], Error>) -> Void)
}

class LocalMovieDataSourceImpl : LocalMovieDataSource{
    
    private let presistence : CoreDataManager
    
    init(presistence: CoreDataManager) {
        self.presistence = presistence
    }
    
    private func provideFavoriteTable(movie: MovieEntity, context: NSManagedObjectContext){
        let table = FavoriteTable(context: context)
        table.id = Int32(movie.id ?? 0)
        table.title = movie.title ?? ""
        table.genres = movie.genres.map{String($0.name ?? "")}.joined(separator: ",")
        table.image = getImageMovie(imagePath: movie.backdrop_path ?? "", imageSize: ImageSize.w342)
        table.releaseDate = movie.release_date ?? ""
    }
    
    func saveFavorite(movie: MovieEntity, completion: @escaping (Result<String, Error>) -> Void) {
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
    
    func deleteFavorite(movie: MovieEntity, completion: @escaping (Result<String, Error>) -> Void) {
        presistence.getPresistenContainer().performBackgroundTask{ context in
            do {
                let favorites : NSFetchRequest<FavoriteTable> = FavoriteTable.fetchRequest()
                let results = try context.fetch(favorites)
                results.filter{
                    $0.id == movie.id!
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
}
