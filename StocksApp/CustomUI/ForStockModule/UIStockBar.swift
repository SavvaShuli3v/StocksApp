//
//  UIStockBar.swift
//  StocksApp
//
//  Created by Савва Шулятьев on 10.10.2021.
//

import UIKit

final class UIStockBar: UIView {
    
    let backButton = SimpleAnimatedButton()
    private lazy var favButton = SimpleAnimatedButton()
    
    private lazy var ticker = UILabel()
    private lazy var companyName = UILabel()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    
    private func setupUI() {
        setupBackButton()
        setupFavButton()
        
        setupTickerLabel()
        setupCompanyName()
    }
    
    private func setupBackButton() {
        self.addSubview(backButton)
        self.backButton.translatesAutoresizingMaskIntoConstraints = false
        self.backButton.leading(18, to: self.leadingAnchor)
        self.backButton.top(30, to: self.topAnchor)
        self.backButton.height(14)
        self.backButton.width(20)
        
        self.backButton.setImage(UIImage(named: ImageNames.arrow), for: .normal)
        self.backButton.setAction {
            print("back from stock")
        }
    }
    
    private func setupFavButton() {
        self.addSubview(favButton)
        self.favButton.translatesAutoresizingMaskIntoConstraints = false
        self.favButton.trailing(-17, to: self.trailingAnchor)
        self.favButton.top(30, to: self.topAnchor)
        self.favButton.width(22)
        self.favButton.height(22)
        
        self.favButton.setImage(UIImage(named: ImageNames.star), for: .normal)
        
    }
    
    private func setupTickerLabel() {
        self.addSubview(ticker)
        self.ticker.translatesAutoresizingMaskIntoConstraints = false
        self.ticker.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.ticker.top(22, to: self.topAnchor)
        self.ticker.height(24)
        
        self.ticker.textColor = Styles.Colors.black
        self.ticker.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        self.ticker.text = "AAPL"
    }
    
    private func setupCompanyName() {
        self.addSubview(companyName)
        self.companyName.translatesAutoresizingMaskIntoConstraints = false
        self.companyName.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.companyName.top(4, to: self.ticker.bottomAnchor)
        self.companyName.height(16)
        
        self.companyName.textColor = Styles.Colors.black
        self.companyName.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        self.companyName.text = "Apple inc."
    }
    
}
