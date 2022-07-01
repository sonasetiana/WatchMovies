//
//  FavoriteViewModel.swift
//  WatchMovies
//
//  Created by sona setiana on 29/06/22.
//

import Foundation
import UIKit

class FavoriteViewModel : ObservableObject {
    let useCase : FavoriteUseCase
    
    @Published var favorites : [FavoriteTable] = []
    @Published var errorMsg : String = ""
    @Published var loading : Bool = false
    
    init(useCase : FavoriteUseCase) {
        self.useCase = useCase
        getListFavorite()
    }
    
    func getListFavorite() {
        if loading == true {
            return
        }
        
        loading = true
        useCase.getListFavorite { results in
            switch(results){
            case .success(let favorites) :
                self.loading = false
                self.favorites = favorites
            case .failure(let error) :
                self.loading = false
                self.errorMsg = error.localizedDescription
            }
        }
    }
    
    func removeFromFavorite(favorite: FavoriteTable) {
        useCase.removeFavorite(id: Int(favorite.id)) { result in
            switch(result) {
            case .success(let msg):
                toast(message: msg)
                self.getListFavorite()
            case .failure(let error):
                print("Remove Favorite: ", error.localizedDescription)
                toast(message: "Failed remove from favorite")
            }
        }
    }
}
