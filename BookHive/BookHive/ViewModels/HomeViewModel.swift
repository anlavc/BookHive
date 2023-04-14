//
//  HomeViewModel.swift
//  BookHive
//
//  Created by Anıl AVCI on 14.04.2023.
//

import Foundation

final class HomeViewModel {
    var trendBook: [Work] = []
    
    var eventHandler: ((_ event: Event) -> Void)?
    
    func fetchTrendBooks() {
        APIManager.shared.request(
            modelType: Bookhive.self,
            type: BookEndPoint.trending) { response in
                self.eventHandler?(.stopLoading)
                switch response {
                case .success(let books):
                    self.trendBook = books.works
                    self.eventHandler?(.dataLoaded)
                case .failure(let error):
                    self.eventHandler?(.error(error))
                }
            }
    }
    
    
}
extension HomeViewModel {
    enum Event {
        case loading
        case stopLoading
        case dataLoaded
        case error(Error?)
    }
}
