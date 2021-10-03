//
//  ListStocksHeader.swift
//  StocksApp
//
//  Created by Савва Шулятьев on 01.10.2021.
//

import UIKit

protocol StocksHeaderProtocol: AnyObject {
    func tapStoksButton()
    func tapFavoriteButton()
}

final class ListStocksHeader: UITableViewHeaderFooterView {
    
    weak var delegate: StocksHeaderProtocol?

    let whiteView = UIView()
    let shadowView = UIView()
    private let closeShadowView = UIView()
    
    let stocksButton = SimpleButton()
    let favouriteButton = SimpleButton()
    
    
    private var heightForSearch: NSLayoutConstraint?
    private var widthForSearch: NSLayoutConstraint?
    
    private var heightForFavourite: NSLayoutConstraint?
    private var widthForFavourite: NSLayoutConstraint?
    
    
    // MARK: - Init
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        configureContents()
        setupWhiteView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    
    func updateBigStock() {
        self.heightForSearch?.constant = 32
        self.widthForSearch?.constant = 98
        
        self.heightForFavourite?.constant = 24
        self.widthForFavourite?.constant = 89
        
        self.stocksButton.setTitleColor(Styles.Colors.black, for: .normal)
        self.stocksButton.titleLabel?.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        
        self.favouriteButton.setTitleColor(Styles.Colors.gray, for: .normal)
        self.favouriteButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        
        self.setNeedsLayout()
        self.layoutIfNeeded()
    }
    
    func updateBigFavourite() {
        self.heightForSearch?.constant = 24
        self.widthForSearch?.constant = 63
        
        self.heightForFavourite?.constant = 32
        self.widthForFavourite?.constant = 139
        
        self.favouriteButton.setTitleColor(Styles.Colors.black, for: .normal)
        self.favouriteButton.titleLabel?.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        
        self.stocksButton.setTitleColor(Styles.Colors.gray, for: .normal)
        self.stocksButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        
        self.setNeedsLayout()
        self.layoutIfNeeded()
    }

    
    // MARK: - Private Methods
    
    private func configureContents() {
        self.contentView.backgroundColor = Styles.Colors.white
        
        setupStocksButton()
        setupFavouriteButton()
        setupShadowView()
        setupCloseShadowView()
    }
    
    private func setupWhiteView() {
        self.addSubview(whiteView)
        self.whiteView.translatesAutoresizingMaskIntoConstraints = false
        self.whiteView.bottom(0, to: self.topAnchor)
        self.whiteView.leading(0, to: self.leadingAnchor)
        self.whiteView.trailing(0, to: self.trailingAnchor)
        self.whiteView.height(50)
        
        self.whiteView.backgroundColor = Styles.Colors.white
        self.whiteView.alpha = 0
    }
    
    private func setupStocksButton() {
        self.contentView.addSubview(stocksButton)
        self.stocksButton.translatesAutoresizingMaskIntoConstraints = false
        self.stocksButton.leading(20, to: self.leadingAnchor)
        self.stocksButton.bottom(-20, to: self.bottomAnchor)
        heightForSearch = self.stocksButton.heightAnchor.constraint(equalToConstant: 32)
        widthForSearch = self.stocksButton.widthAnchor.constraint(equalToConstant: 98)
        heightForSearch?.isActive = true
        widthForSearch?.isActive = true

        self.stocksButton.backgroundColor = Styles.Colors.white
        self.stocksButton.setTitle(Localization.stocks, for: .normal)
        self.stocksButton.setTitleColor(Styles.Colors.black, for: .normal)
        self.stocksButton.titleLabel?.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        
        self.stocksButton.setAction {
            self.delegate?.tapStoksButton()
        }
    }
    
    private func setupFavouriteButton() {
        self.contentView.addSubview(favouriteButton)
        self.favouriteButton.translatesAutoresizingMaskIntoConstraints = false
        self.favouriteButton.leading(20, to: self.stocksButton.trailingAnchor)
        self.favouriteButton.bottom(-20, to: self.contentView.bottomAnchor)
        heightForFavourite = self.favouriteButton.heightAnchor.constraint(equalToConstant: 24)
        widthForFavourite = self.favouriteButton.widthAnchor.constraint(equalToConstant: 89)
        heightForFavourite?.isActive = true
        widthForFavourite?.isActive = true

        self.favouriteButton.backgroundColor = Styles.Colors.white
        self.favouriteButton.setTitle(Localization.favourite, for: .normal)
        self.favouriteButton.setTitleColor(Styles.Colors.gray, for: .normal)
        self.favouriteButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        
        self.favouriteButton.setAction {
            self.delegate?.tapFavoriteButton()
        }
    }
    
    private func setupShadowView() {
        self.addSubview(shadowView)
        self.shadowView.translatesAutoresizingMaskIntoConstraints = false
        self.shadowView.top(0, to: self.bottomAnchor)
        self.shadowView.leading(0, to: self.leadingAnchor)
        self.shadowView.trailing(0, to: self.trailingAnchor)
        self.shadowView.height(1)
        self.shadowView.backgroundColor = Styles.Colors.white
        self.shadowView.alpha = 0
        
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
    
}
