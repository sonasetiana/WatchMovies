//
//  FavoriteView.swift
//  WatchMovies
//
//  Created by sona setiana on 29/06/22.
//

import SwiftUI

struct FavoriteView: View {
    
    @ObservedObject var viewModel : FavoriteViewModel
    
    var body: some View {
        VStack {
            if viewModel.loading {
                LoadingView()
            } else if !viewModel.errorMsg.isEmpty {
                ErrorView(message: viewModel.errorMsg) {
                    viewModel.getListFavorite()
                }
            } else {
                if viewModel.favorites.isEmpty {
                    EmptyView()
                } else  {
                    contens
                }
            }
        }
        .navigationBarTitle("Favorite")
    }
}

extension FavoriteView {
    var contens : some View {
        ScrollView(.vertical, showsIndicators: false) {
            ForEach(viewModel.favorites.indices, id: \.self) { index in
                let item = viewModel.favorites[index]
                NavigationLink(destination: AppModules.shared.provideDetailView(movieId: Int(item.id))) {
                    ItemFavorite(item: item, callback: {
                        viewModel.removeFromFavorite(favorite: item)
                    })
                }
                if index < viewModel.favorites.count {
                    Divider()
                }
            }
        }
    }
}

struct ItemFavorite : View {
    var item : FavoriteTable
    var callback : ( () -> Void)?
    
    var body : some View {
        HStack {
            AsyncImage(
                url: URL(string: getImageMovie(imagePath: item.image ?? "", imageSize: ImageSize.w342)),scale: 2)
            { image in
                image.resizable()
            } placeholder: {
                Color.gray
            }
            .frame(width: 100, height: 100)
            .cornerRadius(AppSpacings.regular)
            VStack(alignment:.leading) {
                VStack(alignment:.leading) {
                    Text(item.releaseDate ?? "")
                        .font(.system(size: 10, weight: .regular))
                    Text(item.title ?? "")
                        .font(.system(size: 14, weight: .bold))
                        .lineLimit(1)
                        .padding(.vertical, -2)
                    Text(item.genres ?? "")
                        .font(.system(size: 10, weight: .light))
                        .lineLimit(1)
                }.padding(.leading)
                HStack {
                    Spacer()
                    Button(action: {
                        callback?()
                    }, label: {
                        Image(AppIcons.imgUnFavorite)
                            .resizable()
                            .frame(width: 24, height: 24)
                    })
                }.padding(.top)
            }
        }.padding()
    }
}

struct FavoriteView_Previews: PreviewProvider {
    static var previews: some View {
        AppModules.shared.provideFavoriteView()
    }
}
