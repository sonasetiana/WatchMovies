//
//  AboutView.swift
//  WatchMovies
//
//  Created by sona setiana on 29/06/22.
//

import SwiftUI

struct AboutView: View {
    var body: some View {
        VStack {
            VStack {
                Image(AppIcons.imgPhoto)
                    .resizable()
                    .frame(width: 94, height: 94)
                    .clipShape(Circle())
                Text("Sona Setiana")
                    .font(.system(size: 24, weight: .medium))
                Text("iOS Developer")
                    .font(.system(size: 12, weight: .regular))
            }.padding()
            List {
                ItemAbout(title: "Email", value: "sonasetiana13@gmail.com")
                ItemAbout(title: "Nomor Ponsel", value: "082288331199")
                ItemAbout(title: "Alamat", value: "Jln. Dewi Sartika RT / RW 008 / 008, Kec. Pancoran Mas, Kel. Depok, Kota Depok, Jawa Barat 16433")
            }.listStyle(.plain)
            Text("Version 1.0.1")
                .font(.system(size: 12, weight: .regular))
                .padding()
        }.navigationTitle("About")
    }
}

struct ItemAbout : View {
    var title: String
    var value: String
    
    var body : some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.system(size: 8, weight: .light))
            Text(value)
                .font(.system(size: 14, weight: .medium))
        }
    }
}
struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
