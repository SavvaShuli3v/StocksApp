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
    
    let ticker = UILabel()
    let companyName = UILabel()
    
    private lazy var shadowView = UIView()
    private lazy var closeShadowView = UIView()
    
    private lazy var collectionView = StockBarCollectionView()
    
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
        self.backgroundColor = Styles.Colors.white
        setupBackButton()
        setupFavButton()
        
        setupTickerLabel()
        setupCompanyName()
        
        setupShadowView()
        setupCloseShadowView()
        
        setupCollectionView()
    }
    
    private func setupShadowView() {
        self.addSubview(shadowView)
        self.shadowView.translatesAutoresizingMaskIntoConstraints = false
        self.shadowView.top(0, to: self.bottomAnchor)
        self.shadowView.leading(0, to: self.leadingAnchor)
        self.shadowView.trailing(0, to: self.trailingAnchor)
        self.shadowView.height(1)
        self.shadowView.backgroundColor = Styles.Colors.white
        self.shadowView.alpha = 1
        
        self.shadowView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.20).cgColor
        self.shadowView.layer.shadowOpacity = 1
        self.shadowView.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.shadowView.layer.shadowRadius = 2
    }
    
    private func setupCloseShadowView() {
        self.addSubview(closeShadowView)
        self.closeShadowView.translatesAutoresizingMaskIntoConstraints = false
        self.closeShadowView.bottom(0, to: self.bottomAnchor)
        self.closeShadowView.leading(0, to: self.leadingAnchor)
        self.closeShadowView.trailing(0, to: self.trailingAnchor)
        self.closeShadowView.height(10)
        self.closeShadowView.backgroundColor = Styles.Colors.white
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
    }
    
    private func setupCompanyName() {
        self.addSubview(companyName)
        self.companyName.translatesAutoresizingMaskIntoConstraints = false
        self.companyName.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.companyName.top(4, to: self.ticker.bottomAnchor)
        self.companyName.height(16)
        
        self.companyName.textColor = Styles.Colors.black
        self.companyName.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
    }
    
    private func setupCollectionView() {
        self.addSubview(collectionView)
        self.collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.collectionView.bottom()
        self.collectionView.leading()
        self.collectionView.trailing()
        self.collectionView.height(36)
    }
    
}
