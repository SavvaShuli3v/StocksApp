//
//  ChartStockCell.swift
//  StocksApp
//
//  Created by Савва Шулятьев on 11.10.2021.
//

import UIKit

final class ChartStockCell: UICollectionViewCell {
    
    private lazy var chartTableView = ChartTableView()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    
    func setStock(price: String?, changePrice: String?, isUp: Bool?) {
        chartTableView.setStock(price: price, changePrice: changePrice, isUp: isUp)
    }
    
    // MARK: - Private methods
    
    private func setupUI() {
        setupChartTableView()
    }
}

// MARK: - private extension ChartStockCell

private extension ChartStockCell {
    func setupChartTableView() {
        self.addSubview(chartTableView)
        self.chartTableView.translatesAutoresizingMaskIntoConstraints = false
        self.chartTableView.allConstraints(to: self)
    }

}
