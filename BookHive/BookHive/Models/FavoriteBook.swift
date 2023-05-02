//
//  FavoriteBook.swift
//  BookHive
//
//  Created by Anıl AVCI on 29.04.2023.
//

import Foundation

struct Book {
    let coverID: String?
    let title: String?
    let author: String?
}
struct ReadBook {
    let coverID          :String?
    let title            :String?
    let finish           :Bool?
    var readPage         :Int?
    let readingDate      :Date?
    let totalpageNumber  :Int?
    let author           :String?
    let documentID       :String?
}
