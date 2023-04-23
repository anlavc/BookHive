//
//  LibraryViewModel.swift
//  BookHive
//
//  Created by Mehdican Büyükplevne on 22.04.2023.
//

import Foundation

final class LibraryViewModel {
    var subjects: [Subjects] = []
    
    var eventHandler: ((_ event: Event) -> Void)?
    
    func fetchLibrarySubjects() {
        APIManager.shared.request(modelType: LibraryModel.self,
                                  type: BookEndPoint.subjects) { response in
            self.eventHandler?(.stopLoading)
            switch response {
            case .success(let subjects):
                self.subjects = subjects.title!
                self.eventHandler?(.dataLoaded)
            case .failure(let error):
                self.eventHandler?(.error(error))
            }
        }
    }
}

extension LibraryViewModel {
    enum Event {
        case loading
        case stopLoading
        case dataLoaded
        case error(Error?)
    }
}
