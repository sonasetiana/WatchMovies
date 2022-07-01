//
//  AppModules.swift
//  WatchMovies
//
//  Created by sona setiana on 30/06/22.
//

import Foundation
import SwiftUI

class AppModules {
    static let shared = AppModules()
    
    func provideHomeView() -> some View {
        let useCase = DomainModules.shared.provideHomeUseCase()
        let viewModel = HomeViewModel(useCase: useCase)
        return HomeView(viewModel: viewModel)
    }
    
    func provideDetailView(movieId: Int?) -> some View {
        let useCase = DomainModules.shared.provideDetailUseCase()
        let viewModel = DetailViewModel(movieId: movieId, useCase: useCase)
        return DetailView(viewModel: viewModel)
    }
    
    func provideFavoriteView() -> some View {
        let useCase = DomainModules.shared.provideFavoriteUseCase()
        let viewModel = FavoriteViewModel(useCase: useCase)
        return FavoriteView(viewModel: viewModel)
    }
}
