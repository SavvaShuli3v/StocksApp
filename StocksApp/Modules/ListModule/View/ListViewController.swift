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
        self.mainTableView.answerDelegate = self
    }
    
    // MARK: - Presents Views
    
    private func presentSearchVC() {
        let searchVC = ModuleBuilder.createSearch()
        searchVC.modalPresentationStyle = .fullScreen
        self.present(searchVC, animated: false, completion: nil)
    }

}

// MARK: - Presenter Binding

extension ListViewController: ListViewProtocol {
    
    func succes() {
        print("succes")
        self.mainTableView.stocks = presenter.stocksForTableView
        self.mainTableView.reloadData()
    }
    
    func failure(error: Error) {
        print(error)
    }
    
    func updateStockImage(for position: Int, with image: UIImage?) {
        print("udapte")
        self.mainTableView.stocks = presenter.stocksForTableView
        self.mainTableView.reloadRows(at: [IndexPath(item: position, section: 1)], with: .none)
    }

}

// MARK: - ListTableView Binding

extension ListViewController: ListTableViewProtocol {
    
    func didTapSearch() {
        print("didTapSearch")
        presentSearchVC()
    }
    
    func didTapStocks() {
        print("didTapStocks")
    }
    
    func didTapFavourite() {
        print("didTapFavourite")
    }
    
    func didTapToCell(with ticker: String) {
        print(ticker)
    }
    
}
