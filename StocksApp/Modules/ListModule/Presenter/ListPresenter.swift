//
//  ListPresenter.swift
//  StocksApp
//
//  Created by Савва Шулятьев on 01.10.2021.
//

import UIKit

// MARK: - ListViewProtocol

protocol ListViewProtocol: AnyObject {
    func succes()
    func failure(error: Error)
    func updateStockImage(for position: Int, with image: UIImage?)
}

// MARK: - ListViewPresenterProtocol

protocol ListViewPresenterProtocol {
    init(view: ListViewProtocol, networkService: NetworkServiceProtocol)
    func getStock(from data: [String])
    func getStockImage(for ticker: String, from urlString: String)
    
    var stocks: [StockModel] { get set }
    var stocksForTableView: [Stock] { get set }
}

// MARK: - class ListPresenter

final class ListPresenter: ListViewPresenterProtocol {

    weak var view: ListViewProtocol?
    let networkService: NetworkServiceProtocol!
    
    var stocks: [StockModel]
    var stocksForTableView: [Stock]
    
    // MARK: - Init
    
    required init(view: ListViewProtocol, networkService: NetworkServiceProtocol) {
        self.view = view
        self.networkService = networkService
        
        stocks = [StockModel]()
        stocksForTableView = [Stock]()
        stocksForTableView = setupStocksForTableView(with: DataStocks.tickersArray)
        
        getStock(from: DataStocks.tickersArray)
    }
    
    // MARK: - Private Methods
    
    private func setupStocksForTableView(with tickers: [String]) -> [Stock] {
        var stocks = [Stock]()
        
        for ticker in tickers {
            stocks.append(Stock(logo: nil, ticker: ticker, companyName: nil, price: nil, changePrice: nil))
        }
        return stocks
    }
    
    private func setupStocksArrayForTableView() {
        for stock in stocks {
            for i in 0..<stocksForTableView.count {
                if stocksForTableView[i].ticker == stock.symbol {
                    stocksForTableView[i].companyName = stock.companyName
                    stocksForTableView[i].price = stock.price
                    stocksForTableView[i].changePrice = stock.changes
                    
                    getStockImage(for: stock.symbol, from: stock.image)
                }
            }
        }
    }
    
    private func updateStocksForTableView(for ticker: String, with image: UIImage?) {
        for i in 0..<stocksForTableView.count {
            if stocksForTableView[i].ticker == ticker {
                stocksForTableView[i].logo = image
                
                DispatchQueue.main.async {
                    self.view?.updateStockImage(for: i, with: image)
                }
            }
        }
    }
    
    // MARK: - Binding
    
    func getStock(from data: [String]) {
        for ticker in data {
            self.networkService.getStock(for: ticker) { [weak self] result in
                guard let self = self else { return }
                
                DispatchQueue.main.async {
                    switch result {
                    case .success(let stock):
                        
                        self.stocks.append(stock!)
                        
                        if self.stocks.count == DataStocks.tickersArray.count {
                            self.setupStocksArrayForTableView()
                            self.view?.succes()
                        }
                    case .failure(let error):
                        self.view?.failure(error: error)
                    }
                }
            }
        }
    }
    
    func getStockImage(for ticker: String, from urlString: String) {
        self.networkService.getStockImage(for: ticker, from: urlString) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let image):
                self.updateStocksForTableView(for: ticker, with: image)
            case .failure(let error):
                print("Get image failure:")
                print(error)
            }
        }
    }

}



