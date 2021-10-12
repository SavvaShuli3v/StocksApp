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
        
        let assemblyBuilder = AssemblyModuleBuilder()
        let router = Router(assemblyBuilder: assemblyBuilder)
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        //self.window?.rootViewController = router.initialViewController()
        self.window?.rootViewController = assemblyBuilder.createStock(stock: stock, router: router)
        self.window?.makeKeyAndVisible()
        return true
    }

}

private var stock = StockModel(symbol: "AAPL",
                               price: 141.51,
                               mktCap: 2339188506624,
                               lastDiv: 0.85,
                               range: "107.32-157.26",
                               changes: -1.300003,
                               companyName: "Apple Inc.",
                               currency: "USD",
                               exchange: "Nasdaq Global Select",
                               exchangeShortName: "NASDAQ",
                               industry: "Consumer Electronics",
                               website: "http://www.apple.com",
                               description: "Apple Inc. designs, manufactures, and markets smartphones, personal computers, tablets, wearables, and accessories worldwide. It also sells various related services. The company offers iPhone, a line of smartphones; Mac, a line of personal computers; iPad, a line of multi-purpose tablets; and wearables, home, and accessories comprising AirPods, Apple TV, Apple Watch, Beats products, HomePod, iPod touch, and other Apple-branded and third-party accessories. It also provides AppleCare support services; cloud services store services; and operates various platforms, including the App Store, that allow customers to discover and download applications and digital content, such as books, music, video, games, and podcasts. In addition, the company offers various services, such as Apple Arcade, a game subscription service; Apple Music, which offers users a curated listening experience with on-demand radio stations; Apple News+, a subscription news and magazine service; Apple TV+, which offers exclusive original content; Apple Card, a co-branded credit card; and Apple Pay, a cashless payment service, as well as licenses its intellectual property. The company serves consumers, and small and mid-sized businesses; and the education, enterprise, and government markets. It sells and delivers third-party applications for its products through the App Store. The company also sells its products through its retail and online stores, and direct sales force; and third-party cellular network carriers, wholesalers, retailers, and resellers. Apple Inc. was founded in 1977 and is headquartered in Cupertino, California.",
                               sector: "Technology",
                               country: "US",
                               address: "1 Apple Park Way",
                               city: "Cupertino",
                               state: "CALIFORNIA",
                               image: "https://financialmodelingprep.com/image-stock/AAPL.png",
                               ipoDate: "1980-12-12",
                               isActivelyTrading: true)
