//
//  MyBooksCollectionViewCell.swift
//  BookHive
//
//  Created by Mehdican Büyükplevne on 13.04.2023.
//

import UIKit

class MyBooksCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "MyBooksCollectionViewCell"
    
    @IBOutlet weak var mybooksView           : UIView!
    @IBOutlet weak var mybooksImageView      : UIImageView!
    @IBOutlet weak var mybooksBookNameLabel  : UILabel!
    @IBOutlet weak var mybooksAuthorNameLabel: UILabel!
    @IBOutlet weak var progressBar           : UIProgressView!
    
    @IBOutlet weak var pageNumberLabel: UILabel!
    @IBOutlet weak var progressLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        mybooksView.layer.cornerRadius  = 15
        mybooksView.layer.shadowColor   = UIColor.gray.cgColor
        mybooksView.layer.shadowOpacity = 0.5
        mybooksView.layer.shadowRadius  = 5
        mybooksView.layer.shadowOffset  = CGSize(width : 2,
                                                 height: 2)
        progressBar.layer.cornerRadius      = 5
    }
    func setup(book: ReadBook) {
        mybooksBookNameLabel.text = book.title
        mybooksAuthorNameLabel.text = book.author
        mybooksImageView.setImageOlid(with: book.coverID!)
        progressLabel.text = "23"
        guard let readPage = book.readPage else { return }
        pageNumberLabel.text = "\(readPage)"
        let percentCompleted    = Double((book.readPage)!) / Double(((book.totalpageNumber)!)) * 100
        progressLabel.text    = "% \(Int(percentCompleted))"
        let percentComplete     = Float(book.readPage!) / Float(book.totalpageNumber!)
        progressBar.setProgress(percentComplete, animated: true)
    }
   
    
    static func nib() -> UINib {
        return UINib(nibName: "MyBooksCollectionViewCell", bundle: nil)
    }

}
