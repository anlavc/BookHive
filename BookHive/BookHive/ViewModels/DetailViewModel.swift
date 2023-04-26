//
//  DetailViewModel.swift
//  BookHive
//
//  Created by Anıl AVCI on 20.04.2023.
//

import Foundation

final class DetailViewModel {
    var detailBook: DetailModel?
    var detailOlid: DetailModel2?
    var rating: Rating?
 
    
    var eventHandler: ((_ event: Event) -> Void)?
    
    func fetchDetailBooks(detail: String) {
        APIManager.shared.request(
            modelType: DetailModel.self,
            type: BookEndPoint.detail(detail: detail)) { response in
                self.eventHandler?(.stopLoading)
                switch response {
                case .success(let detail):
                    self.detailBook = detail
                    print()
                    self.eventHandler?(.dataLoaded)
                case .failure(let error):
                    self.eventHandler?(.error(error))
                }
            }
    }
    
    func fetchDetailOlid(olidKey: String) {
        APIManager.shared.request(
            modelType: DetailModel2.self,
            type: BookEndPoint.pageNumber(olid: olidKey)) { response in
                self.eventHandler?(.stopLoading)
                switch response {
                case .success(let detail):
                    self.detailOlid = detail
                    self.eventHandler?(.dataLoaded)
                case .failure(let error):
                    self.eventHandler?(.error(error))
                }
            }
    }
    func fetchRating(olidKey: String) {
        APIManager.shared.request(
            modelType: Rating.self,
            type: BookEndPoint.rating(olid: olidKey)) { response in
                self.eventHandler?(.stopLoading)
                switch response {
                case .success(let detail):
                    self.rating = detail
                    self.eventHandler?(.dataLoaded)
                case .failure(let error):
                    self.eventHandler?(.error(error))
                }
            }
    }
    
    
}
extension DetailViewModel {
    enum Event {
        case loading
        case stopLoading
        case dataLoaded
        case error(Error?)
    }
}

