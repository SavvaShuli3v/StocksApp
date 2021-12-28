//
//  SearchTableView.swift
//  StocksApp
//
//  Created by Савва Шулятьев on 10.11.2021.
//

import UIKit

final class SearchTableView: UITableView {
    
    private lazy var searchedStocks = testStocks
    
    // MARK: - Init
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        setupTableView()
        self.alpha = 1
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    
    private func setupTableView() {
        self.backgroundColor = Styles.Colors.white
        self.separatorStyle = .none
        self.showsVerticalScrollIndicator = false
        
        self.delegate = self
        self.dataSource = self

        self.register(SearchStocksHeader.self, forHeaderFooterViewReuseIdentifier: mainHeader)
        self.register(ListStocksCell.self, forCellReuseIdentifier: mainCell)
    }
    
    override func touchesShouldCancel(in view: UIView) -> Bool {
        return true
    }
    
    
}

// MARK: - UITableViewDataSource

extension SearchTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        searchedStocks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = dequeueReusableCell(withIdentifier: mainCell, for: indexPath) as! ListStocksCell
        cell.set(stock: searchedStocks[indexPath.row])
        cell.setColor(to: indexPath as NSIndexPath)
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 84
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = dequeueReusableHeaderFooterView(withIdentifier: mainHeader) as! SearchStocksHeader
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }

}

// MARK: - UITableViewDelegate

extension SearchTableView: UITableViewDelegate {
    
}

// MARK: - MainCell Binding

extension SearchTableView: ListStocksCellProtocol {
    func tappedToCell(with ticker: String) {
        print("жмяк")
    }
    
}

// MARK: - CellID

private let mainCell = "mainCell"
private let mainHeader = "mainHeader"

private let testStocks = [Stock(logo: UIImage(),
                                ticker: "APPL",
                                companyName: "Apple Inc.",
                                price: "$140.91",
                                changePrice: "-$0.60 (0,42%)",
                                changeUp: false),
                          Stock(logo: UIImage(),
                                ticker: "APPL",
                                companyName: "Apple Inc.",
                                price: "$140.91",
                                changePrice: "-$0.60 (0,42%)",
                                changeUp: false),
                          Stock(logo: UIImage(),
                                ticker: "APPL",
                                companyName: "Apple Inc.",
                                price: "$140.91",
                                changePrice: "-$0.60 (0,42%)",
                                changeUp: false)]
