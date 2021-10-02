//
//  SearchViewController.swift
//  StocksApp
//
//  Created by Савва Шулятьев on 02.10.2021.
//

import UIKit

final class SearchViewController: UIViewController {
    
    private lazy var searchButton = SimpleButton()

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = Styles.Colors.white
        setupButton()
        
    }
    
    private func setupButton() {
        self.view.addSubview(searchButton)
        self.searchButton.translatesAutoresizingMaskIntoConstraints = false
        self.searchButton.top(16, to: self.view.safeAreaLayoutGuide.topAnchor)
        self.searchButton.leading(16, to: self.view.leadingAnchor)
        self.searchButton.trailing(-16, to: self.view.trailingAnchor)
        self.searchButton.height(48)
        
        self.searchButton.backgroundColor = .clear
        self.searchButton.layer.cornerRadius = 20
        self.searchButton.layer.borderWidth = 1
        self.searchButton.layer.borderColor = Styles.Colors.black.cgColor
        
        self.searchButton.setTitle(Localization.FindCompanyOrTicker, for: .normal)
        self.searchButton.setTitleColor(Styles.Colors.black, for: .normal)
        self.searchButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        self.searchButton.contentHorizontalAlignment = .left
        self.searchButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 36, bottom: 0, right: 0)
        
        self.searchButton.setImage(UIImage(named: Styles.ImageNames.ellipse), for: .normal)
        self.searchButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        
    }

}
