//
//  CollectionViewFlowLayout.swift
//  CustomerTaxiApp
//
//  Created by Trương Thắng on 12/23/16.
//  Copyright © 2016 Trương Thắng. All rights reserved.
//

import UIKit

class CollectionViewFlowLayout: UICollectionViewFlowLayout {
    
    var scalingOffset: CGFloat = 200 // for offsets >= scalingOffset scale Factor is minimumScaleFactor
    var minimumScaleFactor: CGFloat = 0.7
    var isScaleItems = true
    var lastCollectionViewSize: CGSize?
    var pageWidth : CGFloat = 0
    
    static func layoutConfigured(with collectionView: UICollectionView, itemSize: CGSize, minimumLineSpacing: CGFloat) -> CollectionViewFlowLayout {
        let layout = CollectionViewFlowLayout()
        collectionView.collectionViewLayout = layout
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = minimumLineSpacing
        layout.itemSize = itemSize
        layout.collectionView?.decelerationRate = UIScrollViewDecelerationRateFast
        layout.pageWidth = itemSize.width + minimumLineSpacing;
        return layout
    }
    
    
    
    override func invalidateLayout(with context: UICollectionViewLayoutInvalidationContext) {
        super.invalidateLayout(with: context)
        let currentCollectionViewSize = collectionView?.bounds.size;
        if currentCollectionViewSize != lastCollectionViewSize {
            configureInset()
            lastCollectionViewSize = currentCollectionViewSize
        }
    }
    
    func configureInset() {
        guard collectionView != nil else {return}
        
        let inset = (collectionView!.bounds.width - self.itemSize.width) / 2
        collectionView?.contentInset = UIEdgeInsets(top: 0, left: inset, bottom: 0, right: inset)
        collectionView?.contentOffset = CGPoint(x: -inset, y: 0)
    }
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        guard let collectionViewSize = collectionView?.bounds.size else {
            assert(false , "Error: There are no CollectionView in CollectionViewFlowLayout")
        }
        var inoutproposedContentOffset = proposedContentOffset
        let proposedContentOffsetCenterX = inoutproposedContentOffset.x + collectionViewSize.width / 2
        let proposedRect = CGRect(origin: CGPoint(x: inoutproposedContentOffset.x, y: 0), size: collectionViewSize)
        var candidateAttributes : UICollectionViewLayoutAttributes?
        if let layoutAttributes = layoutAttributesForElements(in: proposedRect) {
            for layoutAttribute in layoutAttributes  {
                if !(layoutAttribute.representedElementCategory == UICollectionElementCategory.cell) { continue }
                if candidateAttributes == nil {
                    candidateAttributes = layoutAttribute
                    continue
                }
                if (fabs(layoutAttribute.center.x - proposedContentOffsetCenterX) < fabs(candidateAttributes!.center.x - proposedContentOffsetCenterX)) {
                    candidateAttributes = layoutAttribute
                }
            }
        }
        inoutproposedContentOffset.x = candidateAttributes!.center.x - collectionViewSize.width / 2
        let offset = inoutproposedContentOffset.x - collectionView!.contentOffset.x
        if (velocity.x < 0 && offset > 0) || (velocity.x > 0 && offset < 0) {
            inoutproposedContentOffset.x += velocity.x > 0 ? pageWidth : -pageWidth
        }
        return inoutproposedContentOffset
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        guard let attributes = super.layoutAttributesForElements(in: rect) else {
            assert(false , "Error: There are no return from layoutAttributesForElements(in: rect)")
            return nil
        }
        var attributesCopy = [UICollectionViewLayoutAttributes]()
        for attribute in attributes {
            attributesCopy.append(attribute.copy() as! UICollectionViewLayoutAttributes)
        }
        guard let collectionView = collectionView else {
            assert(false , "Error: There are no CollectionView in CollectionViewFlowLayout")
            return nil
        }
        if isScaleItems == false {
            return attributesCopy
        }
        let visibleRect = CGRect(origin: collectionView.contentOffset, size: collectionView.bounds.size)
        let visibleRectCenterX = visibleRect.midX
        for attribute in attributesCopy{
            let distanceFromCenter = visibleRectCenterX - attribute.center.x
            let absolutedDistanceFromCenter = [abs(distanceFromCenter),scalingOffset].min()
            let scale = absolutedDistanceFromCenter! * (minimumScaleFactor - 1) / scalingOffset + 1
            attribute.transform3D = CATransform3DScale(CATransform3DIdentity, scale, scale, 1)
        }
        return attributesCopy
    }
    
    
}
