//
//  SearchPresenter.swift
//  StocksApp
//
//  Created by Савва Шулятьев on 16.10.2021.
//

import Foundation

// MARK: - StockViewProtocol

protocol SearchViewProtocol: AnyObject {
}

// MARK: - StockViewPresenterProtocol

protocol SearchViewPresenterProtocol {
    init(view: SearchViewProtocol, router: RouterProtocol)
    func tappedToBack()
}

// MARK: - class StockPresenter

final class SearchPresenter: SearchViewPresenterProtocol {
    
    weak var view: SearchViewProtocol?
    var router: RouterProtocol?
    
    func tappedToBack() {
        router?.popToRootWithoutAnimated()
    }

    // MARK: - Init
    
    required init(view: SearchViewProtocol, router: RouterProtocol) {
        self.view = view
        self.router = router
    }
    
}
