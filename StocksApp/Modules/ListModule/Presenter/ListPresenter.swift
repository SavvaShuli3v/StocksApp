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
    init(view: ListViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol)
    func getStock(from data: [String])
    func getStockImage(for ticker: String, from urlString: String)
    func tappedToStock(with ticker: String)
    func tappedToSearch()
    
    var stocks: [NetworkStock] { get set }
    var stocksForTableView: [Stock] { get set }
    var preparedStocks: [PreparedStock] { get set }
}

// MARK: - class ListPresenter

final class ListPresenter: ListViewPresenterProtocol {
    
    weak var view: ListViewProtocol?
    var router: RouterProtocol?
    let networkService: NetworkServiceProtocol!
    
    var stocks: [NetworkStock]
    var stocksForTableView: [Stock]
    var preparedStocks: [PreparedStock]
    
    // MARK: - Init
    
    required init(view: ListViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol) {
        self.view = view
        self.networkService = networkService
        self.router = router
        
        stocks = [NetworkStock]()
        stocksForTableView = [Stock]()
        preparedStocks = [PreparedStock]()
        stocksForTableView = setupStocksForTableView(with: DataStocks.tickersArray)
        
        getStock(from: DataStocks.tickersArray)
    }
    
    // MARK: - Private Methods
    
    private func setupStocksForTableView(with tickers: [String]) -> [Stock] {
        var stocks = [Stock]()
        
        for ticker in tickers {
            stocks.append(Stock(ticker: ticker))
        }
        return stocks
    }
    
    private func setPreparedStock(from stock: NetworkStock) {
        preparedStocks.append(PreparedStock(symbol: stock.symbol,
                                            price: stock.price,
                                            mktCap: stock.mktCap,
                                            lastDiv: stock.lastDiv,
                                            range: stock.range,
                                            changes: stock.changes,
                                            companyName: stock.companyName,
                                            currency: stock.currency,
                                            exchange: stock.exchange,
                                            exchangeShortName: stock.exchangeShortName,
                                            industry: stock.industry,
                                            website: stock.website,
                                            description: stock.description,
                                            sector: stock.sector,
                                            country: stock.currency,
                                            address: stock.address,
                                            city: stock.city,
                                            state: stock.state,
                                            image: stock.image,
                                            ipoDate: stock.ipoDate,
                                            isActivelyTrading: stock.isActivelyTrading,
                                            preparedPrice: setStockPrice(with: stock.price),
                                            preparedChangePrice: setChangePrice(with: stock.changes, with: stock.price),
                                            isUp: isChangeUp(stock.changes),
                                            stockLogo: nil))
    }
    
    private func setupStocksArrayForTableView() {
        for stock in stocks {
            for i in 0..<stocksForTableView.count {
                if stocksForTableView[i].ticker == stock.symbol {
                    stocksForTableView[i].companyName = stock.companyName
                    stocksForTableView[i].price = setStockPrice(with: stock.price)
                    stocksForTableView[i].changePrice = setChangePrice(with: stock.changes, with: stock.price)
                    stocksForTableView[i].changeUp = isChangeUp(stock.changes)
                    
                    getStockImage(for: stock.symbol, from: stock.image)
                    setPreparedStock(from: stock)
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
                print("Get image failure - \(error)")
            }
        }
    }
    
    func tappedToStock(with ticker: String) {
        for stock in preparedStocks {
            if stock.symbol == ticker {
                router?.showStockModule(stock: stock)
            }
        }
    }
    
    func tappedToSearch() {
        router?.showSearchModule()
    }

}

// MARK: - setDataForStock

private extension ListViewPresenterProtocol {
    
    func setStockPrice(with price: Double?) -> String? {
        guard let price = price else { return nil }
        
        let roundedPrice = price.rounded(digits: 2)
        let formattedPrice = roundedPrice.formattedWithSeparator
        let outputPrice = "$" + formattedPrice
        return outputPrice.changedCommaToPoint()
    }
    
    func setChangePrice(with change: Double?, with price: Double?) -> String? {
        guard
            let change = change,
            let price = price
        else { return nil }

        var str = String()
        
        switch change {
        case 0...:
            let formatChange = (String(format: "%.2f", change))
            str = "+$\(formatChange)"
        case ..<0:
            let formatChange = (String(format: "%.2f", -change))
            str = " -$\(formatChange)"
        default:
            precondition(false, PreconditionFailedCalls.defaultCase)
        }
        
        func getChange() -> Double {
            let oldPrice = price - change
            let changePercent = change / oldPrice
            return changePercent * 100
        }
        
        let percent = getChange()
        
        if percent >= 0 {
            let formatPercent = (String(format: "%.2f", percent))
            str += " (\(formatPercent.changedPointToComma())%)"
        } else {
            let formatPercent = (String(format: "%.2f", -percent))
            str += " (\(formatPercent.changedPointToComma())%)"
        }
        
        return str
    }
    
    func isChangeUp(_ change: Double?) -> Bool? {
        guard let change = change else { return nil }
        
        switch change {
        case ..<0:
            return false
        case 0...:
            return true
        default:
            precondition(false, PreconditionFailedCalls.defaultCase)
        }
    }
}

