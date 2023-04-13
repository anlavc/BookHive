//
//  MyBooksViewController.swift
//  BookHive
//
//  Created by Mehdican Büyükplevne on 12.04.2023.
//

import UIKit

class MyBooksViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var wantToReadView: UIView!
    @IBOutlet weak var readView: UIView!
    
    
    
    
    override func loadView() {
        let mybooksView = Bundle.main.loadNibNamed("MyBooksViewController", owner: self)?.first as! UIView
        self.view = mybooksView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionViewSetup()
        viewsSetup()
    }
    
    private func collectionViewSetup() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection         = .horizontal
        layout.minimumLineSpacing      = 10 // ÖĞELER ARASINDAKİ MİNİMUM SATIR BOŞLUĞUNU AYARLA
        layout.minimumInteritemSpacing = 10 // ÖĞELER ARASINDAKİ MİNİMUM DİKEY BOŞLUĞU AYARLA
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10) // COLLECTIONVIEW İÇİNDEKİ KENAR BOŞLUKLARI AYARLA
        collectionView.collectionViewLayout = layout
        collectionView.dataSource = self
        collectionView.delegate   = self
        collectionView.register(MyBooksCollectionViewCell.nib(), forCellWithReuseIdentifier: MyBooksCollectionViewCell.identifier)
    }
    
    private func viewsSetup() {
        wantToReadView.layer.cornerRadius  = 15
        wantToReadView.layer.shadowColor   = UIColor.black.cgColor
        wantToReadView.layer.shadowOpacity = 0.5
        wantToReadView.layer.shadowOffset  = CGSize(width: 2, height: 2)
        wantToReadView.layer.shadowRadius  = 5
        
        readView.layer.cornerRadius  = 15
        readView.layer.shadowColor   = UIColor.black.cgColor
        readView.layer.shadowOpacity = 0.5
        readView.layer.shadowOffset  = CGSize(width: 2, height: 2)
        readView.layer.shadowRadius  = 5
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
