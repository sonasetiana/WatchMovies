//
//  LoadingView.swift
//  WatchMovies
//
//  Created by sona setiana on 30/06/22.
//

import SwiftUI

struct Loading: View {
    var body: some View {
        ProgressView()
            .tint(.black).progressViewStyle(.circular)
    }
}

struct LoadingView: View {
    var body: some View {
        VStack{
            Spacer()
            Loading()
            Spacer()
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
