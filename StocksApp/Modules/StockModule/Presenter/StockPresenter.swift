//
//  StockPresenter.swift
//  StocksApp
//
//  Created by Савва Шулятьев on 12.10.2021.
//

import UIKit

// MARK: - StockViewProtocol

protocol StockViewProtocol: AnyObject {
    func setStock(_ stock: StockModel?)
}

// MARK: - StockViewPresenterProtocol

protocol StockViewPresenterProtocol {
    init(view: StockViewProtocol, router: RouterProtocol, stock: StockModel?)
    func setStock()
    func tapToBack()
}

// MARK: - class StockPresenter

final class StockPresenter: StockViewPresenterProtocol {
    
    weak var view: StockViewProtocol?
    var router: RouterProtocol?
    var stock: StockModel?

    // MARK: - Init
    
    required init(view: StockViewProtocol, router: RouterProtocol, stock: StockModel?) {
        self.view = view
        self.router = router
        self.stock = stock
    }
    
    public func setStock() {
        self.view?.setStock(stock)
    }
    
    func tapToBack() {
        guard let view = view as? UIViewController else { return }
        router?.popToRoot(from: view)
    }
    
}
    
    
