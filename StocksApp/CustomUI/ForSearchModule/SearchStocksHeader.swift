//
//  SearchStocksHeader.swift
//  StocksApp
//
//  Created by Савва Шулятьев on 10.11.2021.
//

import UIKit

final class SearchStocksHeader: UITableViewHeaderFooterView {
    
    private lazy var categoryLabel = UILabel()
    
    // MARK: - Init
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupCategoryLabel()
        self.contentView.backgroundColor = Styles.Colors.white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension SearchStocksHeader {
    func setupCategoryLabel() {
        self.addSubview(categoryLabel)
        self.categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        self.categoryLabel.leading(20, to: self.leadingAnchor)
        self.categoryLabel.bottom()
        self.categoryLabel.height(24)
        
        self.categoryLabel.text = Localization.stocks
        self.categoryLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        self.categoryLabel.textColor = Styles.Colors.black
    }
}
