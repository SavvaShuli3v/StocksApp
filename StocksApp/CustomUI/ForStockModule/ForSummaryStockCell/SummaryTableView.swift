//
//  SummaryTableView.swift
//  StocksApp
//
//  Created by Савва Шулятьев on 13.10.2021.
//

import UIKit

final class SummaryTableView: UITableView {

    private var summary: String?
    
    private var country: String?
    private var branch: String?
    private var industry: String?
    private var div: String?
    
    // MARK: - Init
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        setupTableView()
        self.rowHeight = 222
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    
    func setSummary(_ summary: String?) {
        self.summary = summary
    }
    
    func setInfo(country: String?, branch: String?, industry: String?, div: String?) {
        self.country = country
        self.branch = branch
        self.industry = industry
        self.div = div
    }
    
    // MARK: - Private Methods
    
    func setupTableView() {
        self.backgroundColor = Styles.Colors.white
        self.separatorStyle = .none
        
        self.delegate = self
        self.dataSource = self
        
        self.register(SummaryTableViewCell.self, forCellReuseIdentifier: CellID.summary)
        self.register(AboutCompanyCell.self, forCellReuseIdentifier: CellID.info)
    }
}

extension SummaryTableView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = dequeueReusableCell(withIdentifier: CellID.summary, for: indexPath) as! SummaryTableViewCell
            cell.setSummary(summary)
            return cell
        case 1:
            let cell = dequeueReusableCell(withIdentifier: CellID.info, for: indexPath) as! AboutCompanyCell
            cell.setData(country: country, branch: branch, industry: industry, div: div)
            return cell
        default:
            precondition(false, PreconditionFailedCalls.defaultCase)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

private enum CellID {
    static let summary = "SummaryCell"
    static let info = "Info"
}
