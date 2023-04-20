//
//  ImageView + Ext.swift
//  BookHive
//
//  Created by Anıl AVCI on 20.04.2023.
//

import UIKit
import Kingfisher
// Kingfisher image cache Extensions
extension UIImageView {
    func setImageOlid(with olid: String) {
        let urlString = "https://covers.openlibrary.org/b/olid/\(olid)-M.jpg"
        guard let url = URL(string: urlString) else {
            return
        }
        let resource = ImageResource(downloadURL: url, cacheKey: urlString)
        print("------> OLİD URL SERVİS \(urlString)")
        kf.indicatorType = .activity
        kf.setImage(with: resource)
    }
    
    func setImageCover(with cover: Int) {
        let urlString = "https://covers.openlibrary.org/b/id/\(cover)-M.jpg"
        guard let url = URL(string: urlString) else {
            return
        }
        let resource = ImageResource(downloadURL: url, cacheKey: urlString)
        print("------> COVER URL servis-- \(urlString)")
      
        kf.indicatorType = .activity
        kf.setImage(with: resource)
    }

}
