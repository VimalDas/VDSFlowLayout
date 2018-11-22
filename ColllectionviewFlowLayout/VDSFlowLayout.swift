//
//  VDSFlowLayout.swift
//  ColllectionviewFlowLayout
//
//  Created by Vimal Das on 22/11/18.
//  Copyright © 2018 Vimal Das. All rights reserved.
//

import UIKit

class VDSFlowLayout: UICollectionViewFlowLayout {

    private var size = 200.0
    private var activeDistance:CGFloat = 200
    private var zoomFactor:CGFloat = 0.3
    
    required init?(coder aDecoder: NSCoder) {
        super.init()
        
        self.itemSize = CGSize(width: size, height: size)
        self.scrollDirection = .horizontal
        self.sectionInset = UIEdgeInsets(top: 200, left: 0, bottom: 200, right: 0)
        self.minimumLineSpacing = 50.0
    }
   
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let array = super.layoutAttributesForElements(in: rect) ?? []
        
        var visibleRect = CGRect()
        visibleRect.origin = collectionView!.contentOffset
        visibleRect.size = collectionView!.bounds.size
        
        for attributes:UICollectionViewLayoutAttributes in array {
            if attributes.frame.intersects(rect) {
                let distance = visibleRect.midX - attributes.center.x
                let normalisedDistance = distance/activeDistance
                if abs(distance) < activeDistance {
                    let zoom:CGFloat = 1 + zoomFactor * (1 - abs(normalisedDistance))
                    attributes.transform3D = CATransform3DScale(attributes.transform3D, zoom, zoom, 1.0)
                    attributes.zIndex = Int(round(zoom))
                    
                }
            }
        }
        
        return array
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint) -> CGPoint {
        var offsetAdjustment = MAXFLOAT
        let horizontalCenter = proposedContentOffset.x - collectionView!.bounds.width/2
        let targetRect = CGRect(x: proposedContentOffset.x, y: 0.0, width: collectionView!.bounds.size.width, height: collectionView!.bounds.size.height)
        let array = super.layoutAttributesForElements(in: targetRect) ?? []
        
        for layoutAttributes:UICollectionViewLayoutAttributes in array {
            let itemHorizontalCenter = layoutAttributes.center.x
            if abs(Float(itemHorizontalCenter - horizontalCenter)) < abs(offsetAdjustment) {
                offsetAdjustment = Float(itemHorizontalCenter) - Float(horizontalCenter)
            }
        }
        
        return CGPoint(x: proposedContentOffset.x + CGFloat(offsetAdjustment), y: proposedContentOffset.y)
    }
    
}
