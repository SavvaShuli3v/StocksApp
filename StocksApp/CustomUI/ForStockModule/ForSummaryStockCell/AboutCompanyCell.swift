//
//  AboutCompanyCell.swift
//  StocksApp
//
//  Created by Савва Шулятьев on 15.10.2021.
//

import UIKit

final class AboutCompanyCell: UITableViewCell {
    
    private lazy var mainView = UIView()
    
    private lazy var countryLabel = UILabel()
    private lazy var branchLabel = UILabel()
    private lazy var industryLabel = UILabel()
    private lazy var divLabel = UILabel()
    
    private lazy var countryData = UILabel()
    private lazy var branchData = UILabel()
    private lazy var industryData = UILabel()
    private lazy var divData = UILabel()
    
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.backgroundColor = Styles.Colors.white
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    
    func setData(country: String?, branch: String?, industry: String?, div: String?) {
        self.countryData.text = country
        self.branchData.text = branch
        self.industryData.text = industry
        self.divData.text = div
    }
    
    // MARK: - Private Methods
    
    private func setupView() {
        self.addSubview(mainView)
        self.mainView.translatesAutoresizingMaskIntoConstraints = false
        self.mainView.top(16, to: self.topAnchor)
        self.mainView.leading(16, to: self.leadingAnchor)
        self.mainView.trailing(-16, to: self.trailingAnchor)
        self.mainView.height(190)
        self.mainView.layer.cornerRadius = 16
        self.mainView.backgroundColor = Styles.Colors.lightGray
        
        setupCountryLabel()
        setupBranchLabel()
        setupIndustryLabel()
        setupDivLabel()
        
        setupCountryData()
        setupBranchData()
        setupIndustryData()
        setupDivData()
    }
    
    private func setupCountryLabel() {
        self.mainView.addSubview(countryLabel)
        self.countryLabel.translatesAutoresizingMaskIntoConstraints = false
        self.countryLabel.top(22, to: self.mainView.topAnchor)
        self.countryLabel.leading(16, to: self.mainView.leadingAnchor)
        self.countryLabel.height(20)
        
        self.countryLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        self.countryLabel.textColor = Styles.Colors.gray
        self.countryLabel.text = Localization.country
    }
    
    private func setupBranchLabel() {
        self.mainView.addSubview(branchLabel)
        self.branchLabel.translatesAutoresizingMaskIntoConstraints = false
        self.branchLabel.top(22, to: self.countryLabel.bottomAnchor)
        self.branchLabel.leading(16, to: self.mainView.leadingAnchor)
        self.branchLabel.height(20)
        
        self.branchLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        self.branchLabel.textColor = Styles.Colors.gray
        self.branchLabel.text = Localization.branch
    }
    
    private func setupIndustryLabel() {
        self.mainView.addSubview(industryLabel)
        self.industryLabel.translatesAutoresizingMaskIntoConstraints = false
        self.industryLabel.top(22, to: self.branchLabel.bottomAnchor)
        self.industryLabel.leading(16, to: self.mainView.leadingAnchor)
        self.industryLabel.height(20)
        
        self.industryLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        self.industryLabel.textColor = Styles.Colors.gray
        self.industryLabel.text = Localization.industry
    }
    
    private func setupDivLabel() {
        self.mainView.addSubview(divLabel)
        self.divLabel.translatesAutoresizingMaskIntoConstraints = false
        self.divLabel.top(22, to: self.industryLabel.bottomAnchor)
        self.divLabel.leading(16, to: self.mainView.leadingAnchor)
        self.divLabel.height(20)
        
        self.divLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        self.divLabel.textColor = Styles.Colors.gray
        self.divLabel.text = Localization.dividends
    }
    
    private func setupCountryData() {
        self.mainView.addSubview(countryData)
        self.countryData.translatesAutoresizingMaskIntoConstraints = false
        self.countryData.top(22, to: self.mainView.topAnchor)
        self.countryData.trailing(-16, to: self.mainView.trailingAnchor)
        self.countryData.height(20)
        
        self.countryData.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        self.countryData.textColor = Styles.Colors.black
    }
    
    private func setupBranchData() {
        self.mainView.addSubview(branchData)
        self.branchData.translatesAutoresizingMaskIntoConstraints = false
        self.branchData.top(22, to: self.countryData.bottomAnchor)
        self.branchData.trailing(-16, to: self.mainView.trailingAnchor)
        self.branchData.height(20)
        
        self.branchData.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        self.branchData.textColor = Styles.Colors.black
    }
    
    private func setupIndustryData() {
        self.mainView.addSubview(industryData)
        self.industryData.translatesAutoresizingMaskIntoConstraints = false
        self.industryData.top(22, to: self.branchData.bottomAnchor)
        self.industryData.trailing(-16, to: self.mainView.trailingAnchor)
        self.industryData.height(20)
        
        self.industryData.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        self.industryData.textColor = Styles.Colors.black
    }
    
    private func setupDivData() {
        self.mainView.addSubview(divData)
        self.divData.translatesAutoresizingMaskIntoConstraints = false
        self.divData.top(22, to: self.industryData.bottomAnchor)
        self.divData.trailing(-16, to: self.mainView.trailingAnchor)
        self.divData.height(20)
        
        self.divData.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        self.divData.textColor = Styles.Colors.black
    }
    
}
