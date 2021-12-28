//
//  PopularRequestCollectionView.swift
//  StocksApp
//
//  Created by Савва Шулятьев on 04.11.2021.
//

import UIKit

final class PopularRequestCollectionView: UICollectionView {
    
    private var requests: [String]
    
    // MARK: - Init
    
    init(frame: CGRect, requests: [String]) {
        let collectionViewLayout = RequestCollectionLayout()
        self.requests = requests
        super.init(frame: frame, collectionViewLayout: collectionViewLayout)
        setupCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesShouldCancel(in view: UIView) -> Bool {
        return true
    }
    
    // MARK: - Private Methods
    
    private func setupCollectionView() {
        self.backgroundColor = Styles.Colors.white
        self.register(RequestCollectionCell.self, forCellWithReuseIdentifier: "cell")
        
        if let layout = collectionViewLayout as? RequestCollectionLayout {
            layout.delegate = self
        }
        self.dataSource = self
        
        self.showsHorizontalScrollIndicator = false
    }
    
}

extension PopularRequestCollectionView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return requests.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! RequestCollectionCell
        cell.requestLabel.text = requests[indexPath.row]
        return cell
    }
    
}

extension PopularRequestCollectionView: RequestCollectionLayoutDelegate {
    func collectionView(
        _ collectionView: UICollectionView,
        widthForStrAtIndexPath indexPath:IndexPath) -> CGFloat {
            
            let item = requests[indexPath.row]
            let itemSize = item.size(withAttributes: [
                NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 14)
            ])
            
            
            return itemSize.width
        }
}


