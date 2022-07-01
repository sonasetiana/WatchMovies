//
//  ErrorView.swift
//  WatchMovies
//
//  Created by sona setiana on 30/06/22.
//

import SwiftUI

struct ErrorView: View {
    var message : String?
    var completion : (() -> Void)?
    var body: some View {
        VStack{
            Spacer()
            Text(
                message ?? "An error occurred, please try again."
            )
            .foregroundColor(.black)
            .multilineTextAlignment(.center)
            Button("Try Again"){
                
            }.padding(.top)
            Spacer()
        }
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView()
    }
}
