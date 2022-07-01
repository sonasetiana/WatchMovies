//
//  EmptyView.swift
//  WatchMovies
//
//  Created by sona setiana on 30/06/22.
//

import SwiftUI

struct EmptyView: View {
    var message : String?
    var body: some View {
        VStack(alignment: .center){
            Spacer()
            Text(message ?? "No Data Found")
                .foregroundColor(.black)
            Spacer()
        }
        .frame(maxWidth: .infinity)
    }
}

struct EmptyView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyView()
    }
}
