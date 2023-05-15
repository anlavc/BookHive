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
        quoteTextField.text     = NSLocalizedString( "We know that you all love your books and don't want to scribble them You can access and share your favorite parts of the books you read at any time by making a note in this field.", comment: "")
        pageNumberLabel.text    = ""
        pagenoIcon.isHidden     = true
        bookNameIcon.isHidden   = true
        authorIcon.isHidden     = true
        logoStack.isHidden      = false
        logoStack.alpha         = 1
        deleteButton.isHidden   = true
        shareButton.isHidden    = true
    }
    
    @IBAction func deleteButtonTapped(_ sender: UIButton) {
        if let collectionView = superview as? UICollectionView,
           let indexPath = collectionView.indexPath(for: self) {
            (collectionView.delegate as? PageNumberViewController)?.deleteQuote(at: indexPath)
        }
    }
    
    @IBAction func shareButtonTapped(_ sender: UIButton) {
        deleteButton.isHidden   = true
        shareButton.isHidden    = true
        logoStack.isHidden      = false
        logoStack.alpha         = 0.2
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, 0.0)
        layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        let activityViewController = UIActivityViewController(activityItems: [image as Any], applicationActivities: nil)
        if let viewController = UIApplication.shared.keyWindow?.rootViewController {
            activityViewController.popoverPresentationController?.sourceView = sender
            
            activityViewController.completionWithItemsHandler = { [weak self] activityType, completed, returnedItems, error in
                self?.deleteButton.isHidden = false
                self?.shareButton.isHidden  = false
                self?.logoStack.isHidden    = true
            }
            
            viewController.present(activityViewController, animated: true, completion: nil)
        }
    }
}

