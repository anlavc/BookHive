//
//  SearchViewModel.swift
//  BookHive
//
//  Created by Anıl AVCI on 19.04.2023.
//

import UIKit

final class SearchViewModel {
    var searchBook: [SearchDoc] = []
  
    var eventHandler: ((_ event: Event) -> Void)?
    
    func fetchSearchBooks(searchWord: String) {
        APIManager.shared.request(
            modelType: SearchModel.self,
            type: BookEndPoint.search(search: searchWord)) { response in
                self.eventHandler?(.stopLoading)
                switch response {
                case .success(let books):
                    self.searchBook = books.docs!
                    self.eventHandler?(.dataLoaded)
                case .failure(let error):
                    self.eventHandler?(.error(error))
                }
            }
    }   
}
extension SearchViewModel {
    enum Event {
        case loading
        case stopLoading
        case dataLoaded
        case error(Error?)
    }
}

