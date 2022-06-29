//
//  DetailViewModel.swift
//  WatchMovies
//
//  Created by sona setiana on 29/06/22.
//

import Foundation

class DetailViewModel : ObservableObject {
    let useCase : DetailUseCase
    
    @Published var movie : MovieEntity?
    @Published var errorMsg : String = ""
    @Published var loading : Bool = false
    
    init(useCase : DetailUseCase) {
        self.useCase = useCase
    }
    
    func getDetailMovie(movieId: Int) {
        if loading == true {
            return
        }
        
        loading = true
        useCase.getDetailMovie(movieId: movieId) { result in
            switch(result){
            case .success(let movie) :
                self.loading = false
                self.movie = movie
            case .failure(let error) :
                self.loading = false
                self.errorMsg = error.localizedDescription
            }
        }
    }
    
    func saveToFavorite() {
        if movie == nil {
            toast(message: "Error, cannot save to favorite")
            return
        }
        useCase.saveMovieToFavorite(movie: movie!) { result in
            switch(result) {
            case .success(let msg):
                toast(message: msg)
            case .failure(let error):
                toast(message: error.localizedDescription)
            }
        }
    }
    
    func removeFromFavorite() {
        if movie == nil {
            toast(message: "Error, cannot remove from favorite")
            return
        }
        useCase.removeMovieFromFavorite(movie: movie!) { result in
            switch(result) {
            case .success(let msg):
                toast(message: msg)
            case .failure(let error):
                toast(message: error.localizedDescription)
            }
        }
    }
}
