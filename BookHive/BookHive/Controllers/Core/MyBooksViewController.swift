//
//  MyBooksViewController.swift
//  BookHive
//
//  Created by Mehdican Büyükplevne on 12.04.2023.
//

import UIKit

class MyBooksViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var wantToReadView: UIView!
    @IBOutlet weak var readView      : UIView!
    
    // MARK: - Properties

    
    // MARK: - Load View
    override func loadView() {
        let mybooksView = Bundle.main.loadNibNamed("MyBooksViewController",
                                                   owner: self)?.first as! UIView
        self.view       = mybooksView
        
        
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionViewSetup()
        viewsSetup()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(wantToReadViewTapped))
        wantToReadView.addGestureRecognizer(tapGesture)
        
    }
    
    // MARK: - Collection View Configure
    private func collectionViewSetup() {
        let layout                          = UICollectionViewFlowLayout()
        layout.scrollDirection              = .horizontal
        layout.minimumLineSpacing           = 10
        layout.minimumInteritemSpacing      = 10
        layout.sectionInset                 = UIEdgeInsets(top   : 10,
                                                           left  : 10,
                                                           bottom: 10,
                                                           right : 10)
        collectionView.collectionViewLayout = layout
        collectionView.dataSource           = self
        collectionView.delegate             = self
        collectionView.register(MyBooksCollectionViewCell.nib(),
                                forCellWithReuseIdentifier: MyBooksCollectionViewCell.identifier)
    }
    
    // MARK: - Views Setup
    private func viewsSetup() {
        wantToReadView.layer.cornerRadius = 15
        wantToReadView.addShadow(color: .gray,
                                 opacity: 0.5,
                                 offset: CGSize(width: 2,
                                                height: 2),
                                 radius: 5)
        readView.layer.cornerRadius = 15
        readView.addShadow(color: .gray,
                           opacity: 0.5,
                           offset: CGSize(width: 2,
                                          height: 2),
                           radius: 5)
    }
    
    @objc public func wantToReadViewTapped() {
        let vc = ReadListViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
}

// MARK: - Extensions
extension MyBooksViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyBooksCollectionViewCell.identifier, for: indexPath) as! MyBooksCollectionViewCell
        return cell
    }
}

extension MyBooksViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = PageNumberViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
}

extension MyBooksViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width : 300,
                      height: 150)
    }
}
