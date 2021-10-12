//
//  PriceStockCell.swift
//  StocksApp
//
//  Created by Савва Шулятьев on 11.10.2021.
//

import UIKit

final class PriceStockCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setForColor(ind: Int) {
    switch ind {
    case 0:
        self.backgroundColor = .blue
    case 1:
        self.backgroundColor = .green
    case 2:
        self.backgroundColor = .gray
    default:
        print("aaaaaaa")
    }
    }
}
