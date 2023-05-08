//
//  OnboardingViewController.swift
//  BookHive
//
//  Created by Mehdican Büyükplevne on 8.05.2023.
//

import UIKit

class OnboardingViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var currentPage = 0 {
        didSet {
            pageControl.currentPage = currentPage
            if currentPage == slides.count - 1 {
                nextButton.setTitle(NSLocalizedString("Get Started", comment: ""), for: .normal)
            } else {
                nextButton.setTitle(NSLocalizedString("Next", comment: ""), for: .normal)
            }
        }
    }
    
    // MARK: - Properties
    var slides: [OnboardingSlide] = []
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        slides =
        [
            OnboardingSlide(title: NSLocalizedString("Do you love reading books? Then Bookhive if for you!", comment: ""), image: UIImage(named: "sp1")!),
            OnboardingSlide(title: NSLocalizedString("Easily keep track of the books you've read, create reading lists, and create quotes about your books!", comment: ""), image: UIImage(named: "sp2")!),
            OnboardingSlide(title: NSLocalizedString("Sign up now and choose from millions of books", comment: ""), image: UIImage(named: "sp3")!)
        ]
        
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        collectionView.collectionViewLayout = layout
    }
    
    // MARK: - Button Action
    @IBAction func nextButtonClicked(_ sender: Any) {
        if currentPage == slides.count - 1 {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let tabBar = storyboard.instantiateViewController(identifier: "navBar") as? UINavigationController
            self.view.window?.rootViewController = tabBar
            self.view.window?.makeKeyAndVisible()
        } else {
            currentPage += 1
            let indexPath = IndexPath(item: currentPage, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
        
    }
    

}

// MARK: - Extensions
extension OnboardingViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slides.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingCollectionViewCell.identifier, for: indexPath) as! OnboardingCollectionViewCell
        cell.setup(slides[indexPath.row])
        return cell
    }
}

extension OnboardingViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x / width)
    }
}
