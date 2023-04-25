//
//  HomeViewModel.swift
//  BookHive
//
//  Created by Anıl AVCI on 14.04.2023.
//

import Foundation

final class HomeViewModel {
    var nowBook: [Work] = []
    var bestSeller: [Work] = []
    var weekTrend: [Work] = []
    var yearlyTrendy: [Work] = []
    
    var eventHandler: ((_ event: Event) -> Void)?
    
    func fetchNowTrendBooks() {
        APIManager.shared.request(
            modelType: Bookhive.self,
            type: BookEndPoint.now) { response in
                self.eventHandler?(.stopLoading)
                switch response {
                case .success(let books):
                    self.nowBook = books.works
                    self.eventHandler?(.dataLoaded)
                case .failure(let error):
                    self.eventHandler?(.error(error))
                }
            }
    }
    func fetchWeekTrendBooks() {
        APIManager.shared.request(
            modelType: Bookhive.self,
            type: BookEndPoint.week) { response in
                self.eventHandler?(.stopLoading)
                switch response {
                case .success(let books):
                    self.weekTrend = books.works
                    self.eventHandler?(.dataLoaded)
                case .failure(let error):
                    self.eventHandler?(.error(error))
                }
            }
    }
    func fetchYearlyTrendBooks() {
        APIManager.shared.request(
            modelType: Bookhive.self,
            type: BookEndPoint.yearly) { response in
                self.eventHandler?(.stopLoading)
                switch response {
                case .success(let books):
                    self.yearlyTrendy = books.works
                    self.eventHandler?(.dataLoaded)
                case .failure(let error):
                    self.eventHandler?(.error(error))
                }
            }
    }
    
    func fetchBestSeller() {
        APIManager.shared.request(
            modelType: Bookhive.self,
            type: BookEndPoint.bestseller) { response in
                self.eventHandler?(.stopLoading)
                switch response {
                case .success(let books):
                    self.bestSeller = books.works
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

