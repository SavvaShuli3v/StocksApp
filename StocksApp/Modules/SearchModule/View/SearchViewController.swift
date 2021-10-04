//
//  SearchViewController.swift
//  StocksApp
//
//  Created by Савва Шулятьев on 02.10.2021.
//

import UIKit

final class SearchViewController: UIViewController {
    
    private lazy var searchBar = CustomSearchBar()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    // MARK: - Private Methods
    
    private func setupUI() {
        view.backgroundColor = Styles.Colors.white
        setupSearchBar()

    }
    
    private func setupSearchBar() {
        self.view.addSubview(searchBar)
        self.searchBar.translatesAutoresizingMaskIntoConstraints = false
        self.searchBar.top(22, to: self.view.safeAreaLayoutGuide.topAnchor)
        self.searchBar.leading(16)
        self.searchBar.trailing(-16)
        self.searchBar.height(48)
        
        self.searchBar.backButton.setAction {
            self.dismiss(animated: false, completion: nil)
        }
    }

}
