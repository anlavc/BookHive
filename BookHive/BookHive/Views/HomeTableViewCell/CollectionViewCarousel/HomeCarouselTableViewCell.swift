//
//  HomeCourselTableViewCell.swift
//  BookHive
//
//  Created by Anıl AVCI on 15.04.2023.
//

import UIKit

class HomeCarouselTableViewCell: UITableViewCell {
    var delegate : HomeCourseTableViewCellDelegate?
    private var viewModel = HomeViewModel()
    
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initViewModel()
        observeEvent()
        collectionSetup()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        scaleCenterCell()
        
    }
    func initViewModel() {
        viewModel.fetchBestSeller()
    }
    
    func observeEvent() {
        print("DENEME")
        viewModel.eventHandler = { [weak self] event in
            guard let self else {return}
            
            switch event {
            case .loading:
                DispatchQueue.main.async {
                    self.indicator.startAnimating()
                }
                print("Product loading...")
            case .stopLoading:
                DispatchQueue.main.async {
                    self.indicator.stopAnimating()
                    
                }
                print("Stop loading...")
            case .dataLoaded:
                
                if self.viewModel.bestSeller.count == 0 {
                    print("DATA COUNT ----->>>> 0")
                } else {
                    DispatchQueue.main.async {
                        self.indicator.stopAnimating()
                        self.collectionView.reloadData()
                    }
                }
                print("Data loaded count...\( self.viewModel.bestSeller.count)")
            case .error(let error):
                
                DispatchQueue.main.async {
                    self.indicator.stopAnimating()
                    self.collectionView.reloadData()
                }
                print("HATA VAR!!!! \(error?.localizedDescription ?? "ERROR")")
            }
        }
    }
    // HomePage collection ilk açıldığında istenilen görünümü alması için;
    func scaleCenterCell() {
        let centerX = collectionView.contentOffset.x + collectionView.frame.size.width / 2
        for cell in collectionView.visibleCells {
            var offsetX = centerX - cell.center.x
            if offsetX < 0 { offsetX = -offsetX }
            let scale = 1 - offsetX / collectionView.frame.size.width * 0.4
            
            // Sol ve sağ hücrelerin boyutunu ayarla
            let scaleFactor = 0.8
            if offsetX < 0 {
                cell.transform = CGAffineTransform(scaleX: CGFloat(scale * scaleFactor), y: CGFloat(scale * scaleFactor))
            } else {
                cell.transform = CGAffineTransform(scaleX: CGFloat(scale), y: CGFloat(scale))
            }
        }
    }

    
    
    
    private func collectionSetup() {
        collectionView.register(HomeCollectionViewCarousel.nib(), forCellWithReuseIdentifier: HomeCollectionViewCarousel.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        
    }
    
}
extension HomeCarouselTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.bestSeller.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCarousel.identifier, for: indexPath) as! HomeCollectionViewCarousel
        cell.setup(book: viewModel.bestSeller[indexPath.row])
        scaleCenterCell()
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelectCell(selectedItem: viewModel.bestSeller[indexPath.row])
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat = 10
        let availableWidth = collectionView.frame.width - padding * 3
        let widthPerItem = availableWidth / 3
        return CGSize(width: widthPerItem, height: widthPerItem + 50)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scaleCenterCell()
        
    }
    
}

protocol HomeCourseTableViewCellDelegate {
    func didSelectCell(selectedItem: Work)
    
}