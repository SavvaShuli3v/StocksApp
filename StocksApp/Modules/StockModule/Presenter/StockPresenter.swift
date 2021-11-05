//
//  StockPresenter.swift
//  StocksApp
//
//  Created by Савва Шулятьев on 12.10.2021.
//

import UIKit

// MARK: - StockViewProtocol

protocol StockViewProtocol: AnyObject {
    func setStock(_ stock: PreparedStock?)
}

// MARK: - StockViewPresenterProtocol

protocol StockViewPresenterProtocol {
    init(view: StockViewProtocol, router: RouterProtocol, stock: PreparedStock?)
    func setStock()
    func tapToBack()
    func setDivAnswer() -> String?
}

// MARK: - class StockPresenter

final class StockPresenter: StockViewPresenterProtocol {
    
    weak var view: StockViewProtocol?
    var router: RouterProtocol?
    var stock: PreparedStock?

    // MARK: - Init
    
    required init(view: StockViewProtocol, router: RouterProtocol, stock: PreparedStock?) {
        self.view = view
        self.router = router
        self.stock = stock
    }
    
    public func setStock() {
        self.view?.setStock(stock)
    }
    
    func tapToBack() {
        router?.popToRoot()
    }
    
    func setDivAnswer() -> String? {
        guard let div = stock?.lastDiv else { return "_" }
        
        if div > 0 {
            return Localization.yes
        } else {
            return Localization.no
        }
    }
    
}
    
    
