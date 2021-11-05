//
//  AssemblyModuleBuilder.swift
//  StocksApp
//
//  Created by Савва Шулятьев on 01.10.2021.
//

import UIKit

protocol AssemblyBuilderProtocol {
    func createList(router: RouterProtocol) -> UIViewController
    func createSearch(router: RouterProtocol) -> UIViewController
    func createStock(stock: PreparedStock?, router: RouterProtocol) -> UIViewController
}

class AssemblyModuleBuilder: AssemblyBuilderProtocol {
    
    func createList(router: RouterProtocol) -> UIViewController {
        let view = ListViewController()
        let networkService = NetworkService()
        let presenter = ListPresenter(view: view, networkService: networkService, router: router)
        view.presenter = presenter
        return view
    }
    
    func createSearch(router: RouterProtocol) -> UIViewController {
        let view = SearchViewController()
        let presenter = SearchPresenter(view: view, router: router)
        view.presenter = presenter
        return view
    }
    
    func createStock(stock: PreparedStock?, router: RouterProtocol) -> UIViewController {
        let view = StockViewController()
        let presenter = StockPresenter(view: view, router: router, stock: stock)
        view.presenter = presenter
        return view
    }
 
}
