//
//  StringUtils.swift
//  WatchMovies
//
//  Created by sona setiana on 30/06/22.
//

import Foundation

func toCurrency(num: Int) -> String {
    let nf = NumberFormatter()
    nf.groupingSeparator = ","
    nf.groupingSize = 3
    nf.usesGroupingSeparator = true
    nf.decimalSeparator = "."
    nf.maximumFractionDigits = 2
    return "USD \(nf.string(from: num as NSNumber) ?? "0")"
}

func convertGenresToString(items: [MovieGenreEntity]) -> String {
    if items.isEmpty {
        return ""
    }
    let genre = items.compactMap{$0.name}.joined(separator: ", ")
    return genre
}

func convertCountryToString(items: [MovieCountryEntity]) -> String {
    if items.isEmpty {
        return ""
    }
    let genre = items.compactMap{$0.name}.joined(separator: ", ")
    return genre
}

func convertCompanyToString(items: [MovieCompanieEntity]) -> String {
    if items.isEmpty {
        return ""
    }
    let genre = items.compactMap{$0.name}.joined(separator: ", ")
    return genre
}

func convertSpokenLanguageToString(items: [MovieSpokenLanguageEntity]) -> String {
    if items.isEmpty {
        return ""
    }
    let genre = items.compactMap{$0.english_name}.joined(separator: ", ")
    return genre
}
