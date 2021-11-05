//
//  RequestsView.swift
//  StocksApp
//
//  Created by Савва Шулятьев on 05.11.2021.
//

import UIKit

private let requests = ["Apple", "First Solar", "Amazon", "Alibaba", "Google", "Facebook", "Tesla", "Mastercard", "Macdonalds", "Apple", "Google", "Amazon", "Tinkoff", "Yandex", "Facebook", "Zipline", "Tesla", "NCF"]

private let yourRequests = ["Apple", "First Solar", "Amazon", "Tesla", "Alibaba", "Google", "Facebook"]

final class RequestsView: UIView {
    
    private lazy var popularRequestLabel = UILabel()
    private lazy var searchedRequestLabel = UILabel()
    
    private lazy var popularCollectionView = PopularRequestCollectionView(frame: .zero, requests: requests)
    private lazy var searchedCollectionView = PopularRequestCollectionView(frame: .zero, requests: yourRequests)
    
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
        setupPopularRequestLabel()
        setupSearchedRequestLabel()
        setupPopularCollectionView()
        setupSearchedCollectionView()
    }
    
}

private extension RequestsView {
    
    func setupPopularRequestLabel() {
        self.addSubview(popularRequestLabel)
        self.popularRequestLabel.translatesAutoresizingMaskIntoConstraints = false
        self.popularRequestLabel.top(32, to: self.topAnchor)
        self.popularRequestLabel.leading(20, to: self.leadingAnchor)
        self.popularRequestLabel.height(24)
        
        self.popularRequestLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        self.popularRequestLabel.text = Localization.popularRequests
    }
    
    func setupSearchedRequestLabel() {
        self.addSubview(searchedRequestLabel)
        self.searchedRequestLabel.translatesAutoresizingMaskIntoConstraints = false
        self.searchedRequestLabel.top(127, to: popularRequestLabel.bottomAnchor)
        self.searchedRequestLabel.leading(20, to: self.leadingAnchor)
        self.searchedRequestLabel.height(24)
        
        self.searchedRequestLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        self.searchedRequestLabel.text = Localization.youAreSearchedForThis
    }
    
    func setupPopularCollectionView() {
        self.addSubview(popularCollectionView)
        self.popularCollectionView.translatesAutoresizingMaskIntoConstraints = false
        self.popularCollectionView.top(11, to: self.popularRequestLabel.bottomAnchor)
        self.popularCollectionView.leading()
        self.popularCollectionView.trailing()
        self.popularCollectionView.height(88)
    }
    
    private func setupSearchedCollectionView() {
        self.addSubview(searchedCollectionView)
        self.searchedCollectionView.translatesAutoresizingMaskIntoConstraints = false
        self.searchedCollectionView.top(11, to: self.searchedRequestLabel.bottomAnchor)
        self.searchedCollectionView.leading()
        self.searchedCollectionView.trailing()
        self.searchedCollectionView.height(88)
    }
    
}
