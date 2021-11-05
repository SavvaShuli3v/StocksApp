//
//  StockPriceTableViewCell.swift
//  StocksApp
//
//  Created by Савва Шулятьев on 14.10.2021.
//

import UIKit

final class StockPriceTableViewCell: UITableViewCell {
    
    private lazy var stockPrice = UILabel()
    private lazy var stockChangePrice = UILabel()
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = Styles.Colors.white
        self.selectionStyle = .none
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    
    func setPriceAndChangePrice(_ price: String?, _ changePrice: String?, _ isUp: Bool?) {
        guard
            let price = price,
            let changePrice = changePrice,
            let isUp = isUp
        else { return }
        
        self.stockPrice.text = price
        self.stockChangePrice.text = changePrice
        
        if isUp {
            self.stockChangePrice.textColor = Styles.Colors.green
        } else {
            self.stockChangePrice.textColor = Styles.Colors.red
        }
    }
    
    // MARK: - Private Methods
    
    private func setupUI() {
        setupStockPrice()
        setupStockChangePrice()
    }
}

private extension StockPriceTableViewCell {
    func setupStockPrice() {
        self.addSubview(stockPrice)
        self.stockPrice.translatesAutoresizingMaskIntoConstraints = false
        self.stockPrice.top(48, to: self.topAnchor)
        self.stockPrice.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.stockPrice.height(32)
        
        self.stockPrice.textColor = Styles.Colors.black
        self.stockPrice.font = UIFont.systemFont(ofSize: 28, weight: .bold)
    }
    
    func setupStockChangePrice() {
        self.addSubview(stockChangePrice)
        self.stockChangePrice.translatesAutoresizingMaskIntoConstraints = false
        self.stockChangePrice.top(8, to: self.stockPrice.bottomAnchor)
        self.stockChangePrice.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.stockChangePrice.height(16)
        
        self.stockChangePrice.textColor = Styles.Colors.black
        self.stockChangePrice.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
    }
}

