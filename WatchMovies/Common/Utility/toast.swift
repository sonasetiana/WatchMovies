//
//  toast.swift
//  WatchMovies
//
//  Created by sona setiana on 29/06/22.
//

import Foundation
import Toast

func toast(message: String?) {
    let toast = Toast.text(message ?? "")
    toast.show()
}
