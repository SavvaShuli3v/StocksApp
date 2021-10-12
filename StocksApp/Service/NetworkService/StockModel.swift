//
//  StockModel.swift
//  StocksApp
//
//  Created by Савва Шулятьев on 11.10.2021.
//

import UIKit

struct StockModel: Decodable {
    var symbol: String
    var price: Double
    var mktCap: Int
    var lastDiv: Double
    var range: String
    var changes: Double
    var companyName: String
    var currency: String
    var exchange: String
    var exchangeShortName: String
    var industry: String
    var website: String
    var description: String
    var sector: String
    var country: String
    var address: String
    var city: String
    var state: String
    var image: String
    var ipoDate: String
    var isActivelyTrading: Bool
}
