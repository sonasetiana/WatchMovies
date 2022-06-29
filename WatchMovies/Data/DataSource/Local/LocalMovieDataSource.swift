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
    func provideFavoriteTable(movie: MovieEntity)
    func saveFavorite(movie: MovieEntity, completion: @escaping (Result<String, Error>) -> Void)
    func deleteFavorite(movie: MovieEntity, completion: @escaping (Result<String, Error>) -> Void)
    func getListFavorite() -> Future<[FavoriteTable], Error>
}

class LocalMovieDataSourceImpl : LocalMovieDataSource{
    
    private let presistence : CoreDataManager
    
    init(presistence: CoreDataManager) {
        self.presistence = presistence
    }
    
    func provideFavoriteTable(movie: MovieEntity){
        let table = FavoriteTable(context: presistence.getViewContext())
        table.id = Int32(movie.id ?? 0)
        table.title = movie.title ?? ""
        table.genres = movie.genres.map{String($0.name ?? "")}.joined(separator: ",")
        table.image = getImageMovie(imagePath: movie.backdrop_path ?? "", imageSize: ImageSize.w342)
        table.releaseDate = movie.release_date ?? ""
    }
    
    func saveFavorite(movie: MovieEntity, completion: @escaping (Result<String, Error>) -> Void) {
        do {
            provideFavoriteTable(movie: movie)
            try presistence.getViewContext().save()
            completion(.success("Success save to favorite"))
        }catch {
            completion(.failure(error))
        }
    }
    
    func deleteFavorite(movie: MovieEntity, completion: @escaping (Result<String, Error>) -> Void) {
        let viewContext = presistence.getViewContext()
        do {
            let favorites : NSFetchRequest<FavoriteTable> = FavoriteTable.fetchRequest()
            let results = try viewContext.fetch(favorites)
            results.filter{
                $0.id == movie.id!
            }.forEach { item in
                viewContext.delete(item)
            }
            try viewContext.save()
            completion(.success("Success delete to favorite"))
        }catch {
            completion(.failure(error))
            viewContext.rollback()
        }
    }
    
    func getListFavorite() -> Future<[FavoriteTable], Error> {
        return Future { completion in
            do {
                let viewContext = self.presistence.getViewContext()
                let favorites : NSFetchRequest<FavoriteTable> = FavoriteTable.fetchRequest()
                let results = try viewContext.fetch(favorites)
                completion(.success(results))
            }catch {
                completion(.failure(error))
            }
        }
    }
    
    
    
}
