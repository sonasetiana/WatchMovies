//
//  toast.swift
//  WatchMovies
//
//  Created by sona setiana on 29/06/22.
//

import Foundation
import Toast

enum ImageSize: String {
    case original
    case w92
    case w154
    case w185
    case w342
    case w500
    case w780
}

func toast(message: String?) {
    let toast = Toast.text(message ?? "")
    toast.show()
}

func getImageMovie(imagePath: String, imageSize: ImageSize) -> String{
    let link = "\(AppConfigs.IMAGE_URL)\(imageSize.rawValue)/\(imagePath)"
    print(link)
    return link
}
