//
//  CustomSearchBar.swift
//  StocksApp
//
//  Created by Савва Шулятьев on 03.10.2021.
//

import UIKit

final class CustomSearchBar: UIView {
    
    let backButton = SimpleAnimatedButton()
    var search = UISearchBar()
    
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
        setupView()
        setupButton()
        setupSearch()
    }
    
    private func setupView() {
        self.backgroundColor = Styles.Colors.white
        self.layer.cornerRadius = 20
        self.layer.borderWidth = 1
        self.layer.borderColor = Styles.Colors.black.cgColor
    }
    
    private func setupButton() {
        self.addSubview(backButton)
        self.backButton.translatesAutoresizingMaskIntoConstraints = false
        self.backButton.top(0, to: self.topAnchor)
        self.backButton.bottom(0, to: self.bottomAnchor)
        self.backButton.leading(0, to: self.leadingAnchor)
        self.backButton.width(40)
        self.backButton.backgroundColor = .white
        self.backButton.setImage(UIImage(named: "Arrow"), for: .normal)
        self.backButton.imageEdgeInsets = UIEdgeInsets(top: 17, left: 18, bottom: 17, right: 5)
        
        self.backButton.setAction {
            print("back")
        }
    }
    
    private func setupSearch() {
        self.addSubview(search)
        self.search.translatesAutoresizingMaskIntoConstraints = false
        self.search.leading(34, to: self.leadingAnchor)
        self.search.top(12, to: self.topAnchor)
        self.search.bottom(-12, to: self.bottomAnchor)
        self.search.trailing(-4, to: self.trailingAnchor)
        
        setupTextField()
    }
    
    private func setupTextField() {
        self.search.setImage(UIImage(named: "Cross"), for: .clear, state: .normal)
        
        // Remove the icon, which is located in the left view
        self.search.setImage(UIImage(), for: .search, state: .normal)
        // Give some left padding between the edge of the search bar and the text the user enters
        UISearchBar.appearance().searchTextPositionAdjustment = UIOffset(horizontal: 0, vertical: 0)
        
        self.search.setupSearchBar(background: Styles.Colors.white, inputText: Styles.Colors.black, placeholderText: Styles.Colors.black, image: Styles.Colors.black)
        
        self.search.tintColor = Styles.Colors.black
        

        if let textField = search.value(forKey: "searchField") as? UITextField {
            textField.backgroundColor = Styles.Colors.white
            textField.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
            
            let backgroundView = textField.subviews.first
            if #available(iOS 11.0, *) { // If `searchController` is in `navigationItem`
                backgroundView?.backgroundColor = UIColor.white.withAlphaComponent(0.3) //Or any transparent color that matches with the `navigationBar color`
                backgroundView?.subviews.forEach({ $0.removeFromSuperview() }) // Fixes an UI bug when searchBar appears or hides when scrolling
            }
        }
    }
    
}
