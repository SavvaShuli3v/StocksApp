//
//  StockBarCollectionView.swift
//  StocksApp
//
//  Created by Савва Шулятьев on 05.11.2021.
//

import UIKit

final class StockBarCollectionView: UICollectionView {
    
    private let context = ["Chart", "Summary", "News", "Financial indicators", "Forecast", "Idea", "Risk"]
    
    private var previousActiveContext = IndexPath(item: 0, section: 0)
    
    // MARK: - Init
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        let collectionLayout = UICollectionViewFlowLayout()
        collectionLayout.scrollDirection = .horizontal
        collectionLayout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        super.init(frame: frame, collectionViewLayout: collectionLayout)
        setupCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    
    private func setupCollectionView() {
        self.backgroundColor = Styles.Colors.white
        self.showsHorizontalScrollIndicator = false
        self.register(StockBarCollectionCell.self, forCellWithReuseIdentifier: cellID)
        self.dataSource = self
        self.delegate = self
    }

}

// MARK: - UICollectionViewDataSource

extension StockBarCollectionView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return context.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! StockBarCollectionCell
        cell.contextLabel.text = context[indexPath.row]
        
        if previousActiveContext == indexPath {
            cell.setActiveContext()
        } else {
            cell.removePreviousContext()
        }
        
        return cell
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout

extension StockBarCollectionView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let item = context[indexPath.row]
        let itemSize = item.size(withAttributes: [
            NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 14)
        ])
        
        let height = self.frame.height
        
        return CGSize(width: itemSize.width + 30, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        
        if previousActiveContext != indexPath {
            weak var cell = cellForItem(at: indexPath) as? StockBarCollectionCell
            cell?.setActiveContext()
        }
        
        if previousActiveContext != indexPath {
            weak var previousCell = cellForItem(at: previousActiveContext) as? StockBarCollectionCell
            previousCell?.removePreviousContext()
            
            previousActiveContext = indexPath
        }
    }
    
}

private let cellID = "cell"
