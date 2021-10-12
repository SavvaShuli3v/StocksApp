//
//  ListPresenter.swift
//  StocksApp
//
//  Created by Савва Шулятьев on 01.10.2021.
//

import UIKit

protocol ListViewProtocol: AnyObject {
    func getStocks(stocks: [Stock], favouriteStocks: [Stock])
    
    func succes()
    func failure(error: Error)
}

protocol ListViewPresenterProtocol {
    init(view: ListViewProtocol, networkService: NetworkServiceProtocol)
    func setStocks()
    func getStock()
    func getStockImage()
    
    var stocks: [StockModel] { get set }
    var stockImages: [UIImage?] { get set }
}

final class ListPresenter: ListViewPresenterProtocol {

    weak var view: ListViewProtocol?
    let networkService: NetworkServiceProtocol!
    
    var stocks: [StockModel]
    var stockImages: [UIImage?]
    
    required init(view: ListViewProtocol, networkService: NetworkServiceProtocol) {
        self.view = view
        self.networkService = networkService
        
        stocks = [StockModel]()
        stockImages = [UIImage?]()
        getStock()
    }
    
    func getStock() {
        for ticker in DataStocks.tickersArray {
            self.networkService.getStock(for: ticker) { [weak self] result in
                guard let self = self else { return }
                
                DispatchQueue.main.async {
                    switch result {
                    case .success(let stock):
                        
                        self.stocks.append(stock!)
                        
                        if self.stocks.count == DataStocks.tickersArray.count {
                        self.view?.succes()
                        }
                    case .failure(let error):
                        self.view?.failure(error: error)
                    }
                }
            }
        }
    }
    
    func getStockImage() {
        self.networkService.getStockImage(for: "", from: "") { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let image):
                self.stockImages.append(image ?? nil)
            case .failure(let error):
                print(error)
            }
            
            
        }
    }

    
    func setStocks() {
        self.view?.getStocks(stocks: hardStocks, favouriteStocks: favouriteStocks)
    }
}






private var aaplLogo = UIImage(named: "TestAAPL")
private var teslaLogo = UIImage(named: "TestTSLA")
private var yandexLogo = UIImage(named: "TestYNDX")

private let hardStocks = [Stock(logo: yandexLogo, ticker: "YNDX", companyName: "Yandex LLDC Company", price: 120.2, changePrice: 3.221) ,Stock(logo: aaplLogo, ticker: "AAPL", companyName: "Apple company", price: 170.1, changePrice: 12), Stock(logo: teslaLogo, ticker: "TSLA", companyName: "Tesla", price: 2001.21, changePrice: -134), Stock(logo: aaplLogo, ticker: "AAPL", companyName: "Apple company", price: 170.1, changePrice: 12), Stock(logo: nil, ticker: "AAPL", companyName: "Apple company", price: 170.1, changePrice: 12), Stock(logo: aaplLogo, ticker: "AAPL", companyName: "Apple company", price: 170.1, changePrice: 12), Stock(logo: aaplLogo, ticker: "AAPL", companyName: "Apple company", price: 170.1, changePrice: 12), Stock(logo: aaplLogo, ticker: "AAPL", companyName: "Apple company", price: 170.1, changePrice: 12), Stock(logo: aaplLogo, ticker: "AAPL", companyName: "Apple company", price: 170.1, changePrice: 12), Stock(logo: aaplLogo, ticker: "AAPL", companyName: "Apple company", price: 170.1, changePrice: 12), Stock(logo: aaplLogo, ticker: "AAPL", companyName: "Apple company", price: 170.1, changePrice: 12), Stock(logo: aaplLogo, ticker: "AAPL", companyName: "Apple company", price: 170.1, changePrice: 12), Stock(logo: aaplLogo, ticker: "AAPL", companyName: "Apple company", price: 170.1, changePrice: 12), Stock(logo: aaplLogo, ticker: "AAPL", companyName: "Apple company", price: 170.1, changePrice: 12), Stock(logo: aaplLogo, ticker: "AAPL", companyName: "Apple company", price: 170.1, changePrice: 12), Stock(logo: aaplLogo, ticker: "AAPL", companyName: "Apple company", price: 170.1, changePrice: 12), Stock(logo: aaplLogo, ticker: "AAPL", companyName: "Apple company", price: 170.1, changePrice: 12), Stock(logo: aaplLogo, ticker: "AAPL", companyName: "Apple company", price: 170.1, changePrice: 12), Stock(logo: aaplLogo, ticker: "AAPL", companyName: "Apple company", price: 170.1, changePrice: 12), Stock(logo: aaplLogo, ticker: "AAPL", companyName: "Apple company", price: 170.1, changePrice: 12), Stock(logo: aaplLogo, ticker: "AAPL", companyName: "Apple company", price: 170.1, changePrice: 12), Stock(logo: aaplLogo, ticker: "AAPL", companyName: "Apple company", price: 170.1, changePrice: 12), Stock(logo: aaplLogo, ticker: "AAPL", companyName: "Apple company", price: 170.1, changePrice: 12), Stock(logo: aaplLogo, ticker: "AAPL", companyName: "Apple company", price: 170.1, changePrice: 12)]

private let favouriteStocks = [Stock(logo: aaplLogo, ticker: "AAPL", companyName: "Apple company", price: 170.1, changePrice: 12), Stock(logo: teslaLogo, ticker: "TSLA", companyName: "Tesla", price: 2001.21, changePrice: -134), Stock(logo: yandexLogo, ticker: "YNDX", companyName: "Yandex LLDC Company", price: 120.1, changePrice: 3.21), Stock(logo: aaplLogo, ticker: "AAPL", companyName: "Apple company", price: 170.1, changePrice: 12), Stock(logo: aaplLogo, ticker: "AAPL", companyName: "Apple company", price: 170.1, changePrice: 12)]
