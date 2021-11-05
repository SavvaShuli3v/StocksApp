//
//  ChartTableView.swift
//  StocksApp
//
//  Created by Савва Шулятьев on 13.10.2021.
//

import UIKit

final class ChartTableView: UITableView {
    
    private var price: String?
    private var changePrice: String?
    private var isUp: Bool?
    
    // MARK: - Init
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        setupTableView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    
    func setStock(price: String?, changePrice: String?, isUp: Bool?) {
        self.price = price
        self.changePrice = changePrice
        self.isUp = isUp
    }
    
    // MARK: - Private Methods
    
    func setupTableView() {
        self.backgroundColor = Styles.Colors.white
        self.separatorStyle = .none
        
        self.delegate = self
        self.dataSource = self
        
        self.register(StockPriceTableViewCell.self, forCellReuseIdentifier: cellID.priceCell)
    }
}

// MARK: - ChartTableView: UITableViewDelegate, UITableViewDataSource

extension ChartTableView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = dequeueReusableCell(withIdentifier: cellID.priceCell, for: indexPath) as! StockPriceTableViewCell
        cell.setPriceAndChangePrice(price, changePrice, isUp)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 120
        default:
            precondition(false, PreconditionFailedCalls.defaultCase)
        }
    }
    
}

private enum cellID {
    static let priceCell = "priceCell"
}
