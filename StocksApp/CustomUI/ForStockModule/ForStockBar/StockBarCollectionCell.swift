//
//  StockBarCollectionCell.swift
//  StocksApp
//
//  Created by Савва Шулятьев on 05.11.2021.
//

import UIKit

final class StockBarCollectionCell: UICollectionViewCell {
    
    lazy var contextLabel = UILabel()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    
    func setActiveContext() {
        self.contextLabel.textColor = Styles.Colors.black
        self.contextLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
    }
    
    func removePreviousContext() {
        self.contextLabel.textColor = Styles.Colors.gray
        self.contextLabel.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
    }
    
    // MARK: - Pirvate Methods
    
    private func setupUI() {
        self.backgroundColor = Styles.Colors.white
        
        self.addSubview(contextLabel)
        self.contextLabel.translatesAutoresizingMaskIntoConstraints = false
        self.contextLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        self.contextLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        self.contextLabel.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        self.contextLabel.textColor = Styles.Colors.gray
    }
    
}
