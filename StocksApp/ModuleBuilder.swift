//
//  ModuleBuilder.swift
//  StocksApp
//
//  Created by Савва Шулятьев on 01.10.2021.
//

import UIKit

protocol Builder {
    static func createMain() -> UIViewController
}

class ModuleBuilder: Builder {
    
    static func createMain() -> UIViewController {
        let view = MainViewController()
        let presenter = MainPresenter(view: view)
        view.presenter = presenter
        return view
    }
 
}
