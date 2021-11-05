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
    var navigationController: UINavigationController? { get set }
}

protocol RouterProtocol: RouterMain {
    func initialViewController()
    func showSearchModule()
    func showStockModule(stock: PreparedStock?)
    func popToRoot()
    func popToRootWithoutAnimated()
}

final class Router: RouterProtocol {
    
    var assemblyBuilder: AssemblyBuilderProtocol?
    var navigationController: UINavigationController?
    
    init(assemblyBuilder: AssemblyBuilderProtocol, navigationController: UINavigationController) {
        self.assemblyBuilder = assemblyBuilder
        self.navigationController = navigationController
    }
    
    func initialViewController() {
        if let navigationController = navigationController {
            guard let listViewController = assemblyBuilder?.createList(router: self) else { return }
            navigationController.viewControllers = [listViewController]
        }
    }
    
    func showSearchModule() {
        guard let searchViewController = assemblyBuilder?.createSearch(router: self) else { return }
        navigationController?.pushViewController(searchViewController, animated: false)
    }
    
    func showStockModule(stock: PreparedStock?) {
        guard let stockViewController = assemblyBuilder?.createStock(stock: stock, router: self) else { return }
        navigationController?.pushViewController(stockViewController, animated: true)

    }
    
    func popToRoot() {
        if let navigationController = navigationController {
            navigationController.popToRootViewController(animated: true)
        }
    }
    
    func popToRootWithoutAnimated() {
        if let navigationController = navigationController {
            navigationController.popToRootViewController(animated: false)
        }
    }
    
}
