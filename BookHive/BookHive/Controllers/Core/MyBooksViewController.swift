//
//  MyBooksViewController.swift
//  BookHive
//
//  Created by Mehdican Büyükplevne on 12.04.2023.
//

import UIKit

class MyBooksViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func loadView() {
        let mybooksView = Bundle.main.loadNibNamed("MyBooksViewController", owner: self)?.first as! UIView
        self.view = mybooksView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionViewSetup()
    }
    
    private func collectionViewSetup() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        collectionView.collectionViewLayout = layout
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(MyBooksCollectionViewCell.nib(), forCellWithReuseIdentifier: MyBooksCollectionViewCell.identifier)
    }
}

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
    
}

extension MyBooksViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 300, height: 150)
    }
}
