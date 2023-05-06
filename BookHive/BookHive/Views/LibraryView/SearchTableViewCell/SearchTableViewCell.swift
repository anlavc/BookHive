//
//  SearchTableViewCell.swift
//  BookHive
//
//  Created by Mehdican Büyükplevne on 12.04.2023.
//

import UIKit
import Kingfisher

// MARK: - Protocol
protocol SearchTableViewCellDelegate {
    func didSelect(selectedItem: SearchDoc)
}

// MARK: - Class
class SearchTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    var viewModel: SearchViewModel?
    var delegate : SearchTableViewCellDelegate?
    var index    : SearchDoc?
    
    // MARK: - Outlets
    @IBOutlet weak var searchView       : UIView!
    @IBOutlet weak var bookImageView    : UIImageView!
    @IBOutlet weak var bookNameLabel    : UILabel!
    @IBOutlet weak var authorNameLabel  : UILabel!
    @IBOutlet weak var viewDetailsButton: UIButton!
    
    // MARK: - Identifier
    static let identifier = "SearchTableViewCell"
    
    // MARK: - AwakeFromNib
    override func awakeFromNib() {
        super.awakeFromNib()
        viewConfigure()
    }
    
    // MARK: - Nib Func.
    static func nib() -> UINib {
        return UINib(nibName: "SearchTableViewCell", bundle: nil)
    }
    
    // MARK: - Views Config
    private func viewConfigure() {
        viewDetailsButton.layer.cornerRadius = 12
        searchView.layer.cornerRadius        = 20
        searchView.addShadow(color  : .gray,
                             opacity: 0.5,
                             offset : CGSize(width : 2,
                                             height: 2),
                             radius : 5)
    }
    
    // MARK: - Search Cell Config
    public func searchConfig(model: SearchDoc) {
        let olid = model.cover_edition_key
        let cover = String(model.cover_i ?? 0)
        if cover == nil {
            bookImageView.setImageOlid(with: olid!)
        } else {
            bookImageView.setImageCover(with: Int(cover)!)
        }

        bookNameLabel.text = model.title
        let authorNames = model.author_name?.joined(separator: ", ")
        authorNameLabel.text = authorNames
       
    }
    
    // MARK: - Search Details Button Action
    @IBAction func viewDetailsButtonTapped(_ sender: UIButton) {
        delegate?.didSelect(selectedItem: index!)
    }
}
