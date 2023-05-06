//
//  MyquotesCollectionViewCell.swift
//  BookHive
//
//  Created by Anıl AVCI on 3.05.2023.
//

import UIKit

class MyquotesCollectionViewCell: UICollectionViewCell {
    static let identifier = "MyquotesCollectionViewCell"
    
    @IBOutlet weak var pagenoIcon: UIImageView!
    @IBOutlet weak var bookNameIcon: UIImageView!
    @IBOutlet weak var authorIcon: UIImageView!
    @IBOutlet weak var bgview: UIView!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var quoteTextField: UITextView!
    @IBOutlet weak var pageNumberLabel: UILabel!
    @IBOutlet weak var bookNameLabel: UILabel!
    @IBOutlet weak var noTextImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        bgview.layer.cornerRadius = 20
        bgview.addShadow(color: .white, opacity: 0.5, offset: CGSize(width: 2, height: 2), radius: 5)        
    }
    static func nib() -> UINib {
        return UINib(nibName: "MyquotesCollectionViewCell", bundle: nil)
    }
    func setup(note: QuotesNote) {
        authorLabel.text       = note.author
        bookNameLabel.text     = note.title
        quoteTextField.text    = note.quotesNote
        pageNumberLabel.text   = note.notePageNumber
    }
    func setupNil() {
        authorLabel.text        = ""
        bookNameLabel.text      = "Bookhive"
        quoteTextField.text     = NSLocalizedString("Hepinizin kitaplarınızı çok sevdiğini ve onları çizmek istemediğinizi biliyoruz. \n Okuduğunuz kitaplarda sevdiğiniz yerleri bu alana not alarak istediğiniz zaman ulaşabilir ve paylaşabilirsiniz.", comment: "")
        pageNumberLabel.text    = ""
        pagenoIcon.isHidden     = true
        bookNameIcon.isHidden   = true
        authorIcon.isHidden     = true
    }
}
