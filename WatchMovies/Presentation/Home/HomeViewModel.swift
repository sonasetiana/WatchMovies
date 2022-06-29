//
//  HomeViewModel.swift
//  WatchMovies
//
//  Created by sona setiana on 29/06/22.
//

import Foundation
import UIKit

class HomeViewModel : ObservableObject {
    let useCase : HomeUseCase
    
    @Published var movies : [MovieEntity] = []
    @Published var errorMsg : String = ""
    @Published var loading : Bool = false
    
    init(useCase : HomeUseCase) {
        self.useCase = useCase
    }
    
    func getListMovies() {
        if loading == true {
            return
        }
        loading = true
        useCase.getListMovies { results in
            switch(results){
            case .success(let movies) :
                self.loading = false
                self.movies = movies
            case .failure(let error) :
                self.loading = false
                self.errorMsg = error.localizedDescription
            }
        }
    }
    
    func searchMovies(keyword: String) {
        if loading == true {
            return
        }
        loading = true
        useCase.searchMovies(keyword: keyword) { results in
            switch(results){
            case .success(let movies) :
                self.loading = false
                self.movies = movies
            case .failure(let error) :
                self.loading = false
                self.errorMsg = error.localizedDescription
            }
        }
    }
}
