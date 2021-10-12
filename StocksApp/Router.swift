//
//  Router.swift
//  StocksApp
//
//  Created by Савва Шулятьев on 12.10.2021.
//

import Foundation
import UIKit

protocol RouterMain {
    var assemblyBuilder: AssemblyBuilderProtocol? { get set }
}

protocol RouterProtocol: RouterMain {
    func initialViewController() -> UIViewController?
    func showStockModule(from view: UIViewController, stock: StockModel?)
    func popToRoot(from view: UIViewController)
}

final class Router: RouterProtocol {
    var assemblyBuilder: AssemblyBuilderProtocol?
    
    init(assemblyBuilder: AssemblyBuilderProtocol) {
        self.assemblyBuilder = assemblyBuilder
    }
    
    func initialViewController() -> UIViewController? {
        guard let listViewController = assemblyBuilder?.createList(router: self) else { return nil }
        return listViewController
    }
    
    func showStockModule(from view: UIViewController, stock: StockModel?) {
        guard let stockViewController = assemblyBuilder?.createStock(stock: stock, router: self) else { return }
        stockViewController.modalPresentationStyle = .fullScreen
        view.present(stockViewController, animated: true, completion: nil)

    }
    
    func popToRoot(from view: UIViewController) {
        view.dismiss(animated: true, completion: nil)
    }
    
}
