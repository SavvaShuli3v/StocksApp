//
//  ModuleBuilder.swift
//  StocksApp
//
//  Created by Савва Шулятьев on 01.10.2021.
//

import UIKit

protocol Builder {
    static func createList() -> UIViewController
    static func createSearch() -> UIViewController
}

class ModuleBuilder: Builder {

    static func createList() -> UIViewController {
        let view = ListViewController()
        let presenter = ListPresenter(view: view)
        view.presenter = presenter
        return view
    }
    
    static func createSearch() -> UIViewController {
        return SearchViewController()
    }
 
}
