//
//  RequestCollectionLayout.swift
//  StocksApp
//
//  Created by Савва Шулятьев on 02.11.2021.
//

import UIKit

protocol RequestCollectionLayoutDelegate: AnyObject {
    func collectionView(_ collectionView: UICollectionView, widthForStrAtIndexPath indexPath: IndexPath) -> CGFloat
}

final class RequestCollectionLayout: UICollectionViewLayout {
    // 1
    weak var delegate: RequestCollectionLayoutDelegate?
    
    // 2
    private let numberOfLines = 2
    private let leftInset: CGFloat = 16
    private let spaceBetweenLines: CGFloat = 8
    private let spaceBetweenCells: CGFloat = 4
    
    private let strInset: CGFloat = 16
    
    // 3
    private var cache: [UICollectionViewLayoutAttributes] = []
    
    // 4
    private var contentWidth: CGFloat = 0
    
    
    private var contentHeight: CGFloat {
        guard let collectionView = collectionView else {
            return 0
        }
        let insets = collectionView.contentInset
        return collectionView.bounds.height - (insets.top + insets.bottom)
    }
    
    // 5
    override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }
    
    override func prepare() {
        // 1
        guard
            cache.isEmpty == true,
            let collectionView = collectionView
        else {
            return
        }
        // 2
        let lineHeight: CGFloat = 40
        var yOffset: [CGFloat] = []
        for line in 0..<numberOfLines {
            if line == 0 {
                yOffset.append(CGFloat(line) * lineHeight)
            } else {
                yOffset.append(CGFloat(line) * lineHeight + 8)
            }
        }
        var line = 0
        var xOffset: [CGFloat] = .init(repeating: 0, count: numberOfLines)
        
        // 3
        for item in 0..<collectionView.numberOfItems(inSection: 0) {
            let indexPath = IndexPath(item: item, section: 0)
            
            // 4
            let strWidth = delegate?.collectionView(
                collectionView,
                widthForStrAtIndexPath: indexPath) ?? 0
            let width = strInset * 2 + strWidth
            let frame = CGRect(x: leftInset + xOffset[line] - spaceBetweenCells / 2,
                               y: yOffset[line],
                               width: width,
                               height: lineHeight)
            let insetFrame = frame.insetBy(dx: spaceBetweenCells / 2, dy: 0)
            
            // 5
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.frame = insetFrame
            cache.append(attributes)
            
            // 6
            contentWidth = max(contentWidth, frame.maxX)
            xOffset[line] = xOffset[line] + width
            
            line = line < (numberOfLines - 1) ? (line + 1) : 0
        }
    }
    
    override func layoutAttributesForElements(in rect: CGRect)
    -> [UICollectionViewLayoutAttributes]? {
        var visibleLayoutAttributes: [UICollectionViewLayoutAttributes] = []
        
        // Loop through the cache and look for items in the rect
        for attributes in cache {
            if attributes.frame.intersects(rect) {
                visibleLayoutAttributes.append(attributes)
            }
        }
        return visibleLayoutAttributes
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath)
    -> UICollectionViewLayoutAttributes? {
        return cache[indexPath.item]
    }
}
