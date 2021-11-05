//
//  SummaryStockCell.swift
//  StocksApp
//
//  Created by Савва Шулятьев on 13.10.2021.
//

import UIKit

final class SummaryStockCell: UICollectionViewCell {
    
    private lazy var summaryTableView = SummaryTableView()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    
    func setSummary(_ summary: String?) {
        summaryTableView.setSummary(summary)
    }
    
    func setInfo(country: String?, branch: String?, industry: String?, div: String?) {
        summaryTableView.setInfo(country: country, branch: branch, industry: industry, div: div)
    }

    // MARK: - Private methods
    
    private func setupUI() {
        setupSummaryTableView()
    }
}

private extension SummaryStockCell {
    func setupSummaryTableView() {
        self.addSubview(summaryTableView)
        self.summaryTableView.translatesAutoresizingMaskIntoConstraints = false
        self.summaryTableView.allConstraints(to: self)
    }
}
