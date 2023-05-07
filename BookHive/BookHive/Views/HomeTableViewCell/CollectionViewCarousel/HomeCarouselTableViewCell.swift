//
//  HomeCourselTableViewCell.swift
//  BookHive
//
//  Created by Anıl AVCI on 15.04.2023.
//

import UIKit

protocol HomeCourseTableViewCellDelegate {
    func didSelectCell(selectedItem: Work)
}

class HomeCarouselTableViewCell: UITableViewCell {
    
    var delegate            : HomeCourseTableViewCellDelegate?
    private var viewModel   = HomeViewModel()
    
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        initViewModel()
        observeEvent()
        collectionSetup()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    //MARK: - Functions
    
    func initViewModel() {
        viewModel.fetchBestSeller()
    }
    
    func observeEvent() {
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
                        //                        self.indicator.stopAnimating()
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
    
    private func scaleCenterCell() {
        let centerX = collectionView.contentOffset.x + collectionView.frame.size.width / 2
        for cell in collectionView.visibleCells {
            var offsetX = centerX - cell.center.x
            if offsetX < 0 { offsetX = -offsetX }
            let scale = 1 - offsetX / collectionView.frame.size.width * 0.9
            let scaleFactor = 0.8
            if offsetX < 0 {
                cell.transform = CGAffineTransform(scaleX: CGFloat(scale * scaleFactor), y: CGFloat(scale * scaleFactor))
            } else {
                cell.transform = CGAffineTransform(scaleX: CGFloat(scale), y: CGFloat(scale))
            }
        }
    }
    
    private func scaleCell() {
        let customFlowLayout = CustomFlowLayout()
        customFlowLayout.itemSize = CGSize(width: 130, height: 200)
        customFlowLayout.scrollDirection = .horizontal
        customFlowLayout.minimumLineSpacing = 5
        collectionView.collectionViewLayout = customFlowLayout
        collectionView.decelerationRate = .fast
    }
    
    private func scrollToNearestVisibleCollectionViewCell() {
        let visibleCenterPositionOfScrollView = Float(collectionView.contentOffset.x + (collectionView.bounds.size.width / 2))
        var closestCellIndex = -1
        var closestDistance: Float = .greatestFiniteMagnitude
        
        for i in collectionView.visibleCells.indices {
            let cell = collectionView.visibleCells[i]
            let cellWidth = cell.bounds.size.width
            let cellCenter = Float(cell.frame.origin.x + cellWidth / 2)
            let distance: Float = fabsf(visibleCenterPositionOfScrollView - cellCenter)
            if distance < closestDistance {
                closestDistance = distance
                closestCellIndex = collectionView.indexPath(for: cell)!.row
            }
        }
        if closestCellIndex != -1 {
            collectionView.scrollToItem(at: IndexPath(row: closestCellIndex, section: 0), at: .centeredHorizontally, animated: true)
        }
    }
    
    //MARK: - Collection Setup
    private func collectionSetup() {
        collectionView.register(HomeCollectionViewCarousel.nib(), forCellWithReuseIdentifier: HomeCollectionViewCarousel.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        scaleCell()
    }
    
}
extension HomeCarouselTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.bestSeller.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCarousel.identifier, for: indexPath) as! HomeCollectionViewCarousel
        cell.setup(book: viewModel.bestSeller[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelectCell(selectedItem: viewModel.bestSeller[indexPath.row])
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        scaleCenterCell()
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scaleCenterCell()
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        scrollToNearestVisibleCollectionViewCell()
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            scrollToNearestVisibleCollectionViewCell()
        }
    }
}
