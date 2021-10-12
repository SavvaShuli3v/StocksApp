//
//  AppDelegate.swift
//  StocksApp
//
//  Created by Савва Шулятьев on 01.10.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = ModuleBuilder.createList()
        //self.window?.rootViewController = SearchViewController()
        self.window?.makeKeyAndVisible()
        return true
    }

}

