//
//  String + Extension.swift
//  StocksApp
//
//  Created by Савва Шулятьев on 13.10.2021.
//

import Foundation

extension String {
    
    func changedCommaToPoint() -> String {
        var changedStr = String()
        
        for ch in self {
            if ch == "," {
                changedStr.append(".")
            } else {
                changedStr.append(ch)
            }
        }
        
        return changedStr
    }
    
    func changedPointToComma() -> String {
        var changedStr = String()
        
        for ch in self {
            if ch == "." {
                changedStr.append(",")
            } else {
                changedStr.append(ch)
            }
        }
        
        return changedStr
    }
}
