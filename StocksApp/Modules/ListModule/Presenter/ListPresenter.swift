//
//  ListPresenter.swift
//  StocksApp
//
//  Created by Савва Шулятьев on 01.10.2021.
//

import UIKit

protocol ListViewProtocol: AnyObject {
    func getStocks(stocks: [Stock], favouriteStocks: [Stock])
}

protocol ListViewPresenterProtocol {
    init(view: ListViewProtocol)
    func setStocks()
}

final class ListPresenter: ListViewPresenterProtocol {
    
    weak var view: ListViewProtocol?
    
    required init(view: ListViewProtocol) {
        self.view = view

    }
    
    func setStocks() {
        self.view?.getStocks(stocks: stocks, favouriteStocks: favouriteStocks)
    }
}

private var aaplLogo = UIImage(named: "TestAAPL")
private var teslaLogo = UIImage(named: "TestTSLA")
private var yandexLogo = UIImage(named: "TestYNDX")

private let stocks = [Stock(logo: yandexLogo, ticker: "YNDX", companyName: "Yandex LLDC Company", price: 120.2, changePrice: 3.221) ,Stock(logo: aaplLogo, ticker: "AAPL", companyName: "Apple company", price: 170.1, changePrice: 12), Stock(logo: teslaLogo, ticker: "TSLA", companyName: "Tesla", price: 2001.21, changePrice: -134), Stock(logo: aaplLogo, ticker: "AAPL", companyName: "Apple company", price: 170.1, changePrice: 12), Stock(logo: nil, ticker: "AAPL", companyName: "Apple company", price: 170.1, changePrice: 12), Stock(logo: aaplLogo, ticker: "AAPL", companyName: "Apple company", price: 170.1, changePrice: 12), Stock(logo: aaplLogo, ticker: "AAPL", companyName: "Apple company", price: 170.1, changePrice: 12), Stock(logo: aaplLogo, ticker: "AAPL", companyName: "Apple company", price: 170.1, changePrice: 12), Stock(logo: aaplLogo, ticker: "AAPL", companyName: "Apple company", price: 170.1, changePrice: 12), Stock(logo: aaplLogo, ticker: "AAPL", companyName: "Apple company", price: 170.1, changePrice: 12), Stock(logo: aaplLogo, ticker: "AAPL", companyName: "Apple company", price: 170.1, changePrice: 12), Stock(logo: aaplLogo, ticker: "AAPL", companyName: "Apple company", price: 170.1, changePrice: 12), Stock(logo: aaplLogo, ticker: "AAPL", companyName: "Apple company", price: 170.1, changePrice: 12), Stock(logo: aaplLogo, ticker: "AAPL", companyName: "Apple company", price: 170.1, changePrice: 12), Stock(logo: aaplLogo, ticker: "AAPL", companyName: "Apple company", price: 170.1, changePrice: 12), Stock(logo: aaplLogo, ticker: "AAPL", companyName: "Apple company", price: 170.1, changePrice: 12), Stock(logo: aaplLogo, ticker: "AAPL", companyName: "Apple company", price: 170.1, changePrice: 12), Stock(logo: aaplLogo, ticker: "AAPL", companyName: "Apple company", price: 170.1, changePrice: 12), Stock(logo: aaplLogo, ticker: "AAPL", companyName: "Apple company", price: 170.1, changePrice: 12), Stock(logo: aaplLogo, ticker: "AAPL", companyName: "Apple company", price: 170.1, changePrice: 12), Stock(logo: aaplLogo, ticker: "AAPL", companyName: "Apple company", price: 170.1, changePrice: 12), Stock(logo: aaplLogo, ticker: "AAPL", companyName: "Apple company", price: 170.1, changePrice: 12), Stock(logo: aaplLogo, ticker: "AAPL", companyName: "Apple company", price: 170.1, changePrice: 12), Stock(logo: aaplLogo, ticker: "AAPL", companyName: "Apple company", price: 170.1, changePrice: 12)]

private let favouriteStocks = [Stock(logo: aaplLogo, ticker: "AAPL", companyName: "Apple company", price: 170.1, changePrice: 12), Stock(logo: teslaLogo, ticker: "TSLA", companyName: "Tesla", price: 2001.21, changePrice: -134), Stock(logo: yandexLogo, ticker: "YNDX", companyName: "Yandex LLDC Company", price: 120.1, changePrice: 3.21), Stock(logo: aaplLogo, ticker: "AAPL", companyName: "Apple company", price: 170.1, changePrice: 12), Stock(logo: aaplLogo, ticker: "AAPL", companyName: "Apple company", price: 170.1, changePrice: 12)]
