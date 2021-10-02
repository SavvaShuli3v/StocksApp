//
//  ListViewController.swift
//  StocksApp
//
//  Created by Савва Шулятьев on 01.10.2021.
//

import UIKit

final class ListViewController: UIViewController {
    
    var presenter: ListViewPresenterProtocol!
    
    private lazy var mainTableView = ListStocksTableView()

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter.setStocks()
        
        setupUI()
    }
    
    // MARK: - Private Methods
    
    private func setupUI() {
        self.view.backgroundColor = .red
        
        setupMainTableView()
    }
    
    private func setupMainTableView() {
        self.view.addSubview(mainTableView)
        self.mainTableView.translatesAutoresizingMaskIntoConstraints = false
        self.mainTableView.allConstraints(to: self.view)
    }

}

// MARK: - Presenter Binding

extension ListViewController: ListViewProtocol {
    func getStocks(stocks: [Stock], favouriteStocks: [Stock]) {
        self.mainTableView.stocks = stocks
        self.mainTableView.favouriteStocks = favouriteStocks
    }

}
