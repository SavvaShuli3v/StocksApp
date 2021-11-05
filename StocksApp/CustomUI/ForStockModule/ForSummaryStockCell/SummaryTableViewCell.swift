//
//  SummaryTableViewCell.swift
//  StocksApp
//
//  Created by Савва Шулятьев on 14.10.2021.
//

import UIKit

final class SummaryTableViewCell: UITableViewCell {
    
    private lazy var summaryLabel = UILabel()
    private lazy var summaryText = UILabel()
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = Styles.Colors.white
        self.selectionStyle = .none
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Method
    
    func setSummary(_ summary: String?) {
        guard let summary = summary else { return }
        self.summaryText.text = summary
    }
    
    // MARK: - Private Method
    
    private func setupUI() {
        setupSummaryLabel()
        setupSummaryText()
    }
    
    private func setupSummaryLabel() {
        self.addSubview(summaryLabel)
        self.summaryLabel.translatesAutoresizingMaskIntoConstraints = false
        self.summaryLabel.top(36, to: self.topAnchor)
        self.summaryLabel.leading(16, to: self.leadingAnchor)
        
        self.summaryLabel.text = Localization.summary
        self.summaryLabel.textColor = Styles.Colors.black
        self.summaryLabel.backgroundColor = Styles.Colors.white
        self.summaryLabel.font = UIFont.systemFont(ofSize: 28, weight: .bold)
    }
    
    private func setupSummaryText() {
        self.addSubview(summaryText)
        self.summaryText.translatesAutoresizingMaskIntoConstraints = false
        self.summaryText.allConstraints(to: self, top: 92, bottom: -16, leading: 16, tralling: -16)
        
        self.summaryText.textColor = Styles.Colors.black
        self.summaryText.backgroundColor = Styles.Colors.white
        self.summaryText.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        self.summaryText.numberOfLines = 0
    }
    
}
