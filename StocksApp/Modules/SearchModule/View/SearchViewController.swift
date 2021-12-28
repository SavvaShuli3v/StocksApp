//
//  SearchViewController.swift
//  StocksApp
//
//  Created by Савва Шулятьев on 02.10.2021.
//

import UIKit

final class SearchViewController: UIViewController {
    
    var presenter: SearchViewPresenterProtocol!
    
    private lazy var searchBar = CustomSearchBar()
    private lazy var requestsView = RequestsView()
    
    private lazy var searchTableView = SearchTableView()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        self.searchBar.search.becomeFirstResponder()
    }

    // MARK: - Private Methods
    
    private func setupUI() {
        view.backgroundColor = Styles.Colors.white
        
        setupSearchBar()
        setupRequestsView()
        setupSearchTableView()
    }
    
}

// MARK: - Presenter Binding

extension SearchViewController: SearchViewProtocol {

}

// MARK: - private extension SearchViewController for setup UI

private extension SearchViewController {
    
    func setupSearchBar() {
        self.view.addSubview(searchBar)
        self.searchBar.translatesAutoresizingMaskIntoConstraints = false
        self.searchBar.top(22, to: self.view.safeAreaLayoutGuide.topAnchor)
        self.searchBar.leading(16)
        self.searchBar.trailing(-16)
        self.searchBar.height(48)
        
        self.searchBar.backButton.setAction { [weak self] in
            self?.presenter.tappedToBack()
        }
    }
    
    func setupRequestsView() {
        self.view.addSubview(requestsView)
        self.requestsView.translatesAutoresizingMaskIntoConstraints = false
        self.requestsView.top(0, to: self.searchBar.bottomAnchor)
        self.requestsView.leading()
        self.requestsView.trailing()
        self.requestsView.bottom()
    }
    
    func setupSearchTableView() {
        self.view.addSubview(searchTableView)
        self.searchTableView.translatesAutoresizingMaskIntoConstraints = false
        self.searchTableView.top(0, to: self.searchBar.bottomAnchor)
        self.searchTableView.leading()
        self.searchTableView.trailing()
        self.searchTableView.bottom()
    }
    
}
