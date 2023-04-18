//
//  HomeCollectionViewCoursel.swift
//  BookHive
//
//  Created by Anıl AVCI on 15.04.2023.
//

import UIKit

class HomeCollectionViewCoursel: UICollectionViewCell {
    
    static let identifier = "HomeCollectionViewCoursel"
    

  
    @IBOutlet weak var bgview: UIView!
    @IBOutlet weak var imageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        imageView.layer.masksToBounds = false
        imageView.layer.shadowOffset = CGSize(width: 0, height: 25)//Blur
        imageView.layer.shadowOpacity = 0.20
        imageView.layer.shadowRadius = 6.0
        imageView.layer.cornerRadius = 10.0
        

    }
    func setup(book: Work) {
        // Download image and set
        let olid = book.availability?.openlibrary_edition
        let cover = String(book.cover_id ?? 0)
        if cover == nil {
            imageView.setImageOlid(with: olid!)
        } else {
            imageView.setImageCover(with: Int(cover)!)
        }
    }
   
    static func nib() -> UINib {
        return UINib(nibName: "HomeCollectionViewCoursel", bundle: nil)
    }
    
}
