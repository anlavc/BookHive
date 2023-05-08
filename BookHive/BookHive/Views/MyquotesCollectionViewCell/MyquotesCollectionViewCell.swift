//
//  MyquotesCollectionViewCell.swift
//  BookHive
//
//  Created by Anıl AVCI on 3.05.2023.
//

import UIKit
import FirebaseAuth
import Firebase

protocol MyquotesCollectionViewCellDelegate: AnyObject {
    func deleteQuote(in cell: MyquotesCollectionViewCell)
}

class MyquotesCollectionViewCell: UICollectionViewCell {
    static let identifier = "MyquotesCollectionViewCell"
    weak var delegate: MyquotesCollectionViewCellDelegate?
    
    var index: Int!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var logoStack: UIStackView!
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
        authorLabel.text         = note.author
        bookNameLabel.text       = note.title
        quoteTextField.text      = note.quotesNote
        pageNumberLabel.text     = note.notePageNumber
        logoStack.isHidden       = true
        authorLabel.isHidden     = false
        bookNameLabel.isHidden   = false
        pagenoIcon.isHidden      = false
        bookNameIcon.isHidden    = false
        authorIcon.isHidden      = false
        deleteButton.isHidden   =  false
        shareButton.isHidden    =  false
        
    }
    func setupNil() {
        authorLabel.isHidden    = true
        bookNameLabel.isHidden  = true
        quoteTextField.text     = NSLocalizedString("Hepinizin kitaplarınızı çok sevdiğini ve onları karalamak istemediğinizi biliyoruz. \nOkuduğunuz kitaplarda sevdiğiniz yerleri bu alana not alarak istediğiniz zaman ulaşabilir ve paylaşabilirsiniz.", comment: "")
        pageNumberLabel.text    = ""
        pagenoIcon.isHidden     = true
        bookNameIcon.isHidden   = true
        authorIcon.isHidden     = true
        logoStack.isHidden      = false
        deleteButton.isHidden   = true
        shareButton.isHidden    = true
    }
    
    @IBAction func deleteButtonTapped(_ sender: UIButton) {
        if let collectionView = superview as? UICollectionView,
           let indexPath = collectionView.indexPath(for: self) {
            (collectionView.delegate as? PageNumberViewController)?.deleteQuote(at: indexPath)
        }
    }
}
