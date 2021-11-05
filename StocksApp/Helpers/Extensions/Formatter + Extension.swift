//
//  Formatter + Extension.swift
//  StocksApp
//
//  Created by Савва Шулятьев on 13.10.2021.
//

import Foundation

extension Formatter {
    static let withSeparator: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.groupingSeparator = " "
        formatter.numberStyle = .decimal
        return formatter
    }()
}
