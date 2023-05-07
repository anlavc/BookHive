//
//  CustomFlowLayout.swift
//  BookHive
//
//  Created by Anıl AVCI on 7.05.2023.
//

import UIKit

class CustomFlowLayout: UICollectionViewFlowLayout {
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let attributes = super.layoutAttributesForElements(in: rect)?.map { $0.copy() as! UICollectionViewLayoutAttributes }
        attributes?.forEach { self.update(layoutAttributes: $0) }
        return attributes
    }

    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let attributes = super.layoutAttributesForItem(at: indexPath)?.copy() as? UICollectionViewLayoutAttributes
        if let attributes = attributes {
            update(layoutAttributes: attributes)
        }
        return attributes
    }
    private func update(layoutAttributes attributes: UICollectionViewLayoutAttributes) {
        guard let collectionView = collectionView else { return }
        
        let centerX = collectionView.contentOffset.x + collectionView.bounds.width / 2
        let offsetX = attributes.center.x - centerX
        let maxDistance = self.itemSize.width + self.minimumLineSpacing
        let scaleFactor = max(1 - abs(offsetX / maxDistance), 0.9)
        
        attributes.transform = CGAffineTransform(scaleX: scaleFactor, y: scaleFactor)
    }

}
