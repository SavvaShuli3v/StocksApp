//
//  RequestCollectionCell.swift
//  StocksApp
//
//  Created by Савва Шулятьев on 16.10.2021.
//

import UIKit

final class RequestCollectionCell: UICollectionViewCell {
    
    lazy var requestLabel = UILabel()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Pirvate Methods
    
    private func setupUI() {
        self.backgroundColor = Styles.Colors.lightGray
        self.layer.cornerRadius = 20
        
        self.addSubview(requestLabel)
        self.requestLabel.translatesAutoresizingMaskIntoConstraints = false
        self.requestLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        self.requestLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        self.requestLabel.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
    }
    
}
