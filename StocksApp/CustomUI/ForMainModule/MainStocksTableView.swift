//
//  MainStocksTableView.swift
//  StocksApp
//
//  Created by Савва Шулятьев on 01.10.2021.
//

import UIKit

final class MainStocksTableView: UITableView, MainSearchCellProtocol, StocksHeaderProtocol {
    
    var stocks = [Stock]()
    var favouriteStocks = [Stock]()
    
    var isStocks = true
    private var localTop: CGFloat = 0
    
    // MARK: - Init
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        setupTableView()
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
        
        self.register(MainStocksHeader.self, forHeaderFooterViewReuseIdentifier: HeaderID.mainStocksHeader)
        
        self.register(MainSearchCell.self, forCellReuseIdentifier: CellID.searchCell)
        self.register(MainStocksCell.self, forCellReuseIdentifier: CellID.mainCell)
    }
    
    override func touchesShouldCancel(in view: UIView) -> Bool {
        return true
    }
    
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension MainStocksTableView: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            switch isStocks {
            case true:
                return stocks.count
            case false:
                return favouriteStocks.count
            }
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = dequeueReusableCell(withIdentifier: CellID.searchCell, for: indexPath) as! MainSearchCell
            cell.delegate = self
            return cell
        default:
            let cell = dequeueReusableCell(withIdentifier: CellID.mainCell, for: indexPath) as! MainStocksCell
            switch isStocks {
            case true:
                cell.set(stock: stocks[indexPath.row])
                cell.setColor(to: indexPath as NSIndexPath)
                return cell
            case false:
                cell.set(stock: favouriteStocks[indexPath.row])
                cell.setColor(to: indexPath as NSIndexPath)
                return cell
            }
            
            
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 80
        case 1:
            return 84
        default:
            return 0
        }
    }
    
    // MARK: - HeaderSettings
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = dequeueReusableHeaderFooterView(withIdentifier: HeaderID.mainStocksHeader) as! MainStocksHeader
        header.delegate = self
        return header
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 1 {
            return 50
        } else {
            return 0
        }
    }
    
    // MARK: - Animate Methods
    
    private func setAlphaSearchCell(_ y: CGFloat) {
        
        weak var searchCell = self.cellForRow(at: IndexPath(item: 0, section: 0))
        weak var header = self.headerView(forSection: 1) as? MainStocksHeader
        
        if y > -18 {
            searchCell?.alpha = 1 - (y + 18)/10
        } else {
            searchCell?.alpha = 1
        }
        
        if y >= 25 {
            header?.whiteView.alpha = 1
        } else {
            header?.whiteView.alpha = 0
        }
        
        if y >= 35 && y < 37 {
            header?.shadowView.alpha += y/150
        } else if y >= 37 {
            header?.shadowView.alpha = 1
        } else {
            header?.shadowView.alpha = 0
        }
    }
    
    private func scrollTo(_ y: CGFloat) {
        
        if y < 5  {
            DispatchQueue.main.async {
                self.scrollToRow(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
            }
        }
        
        if y >= 5 && y <= 30 {
            DispatchQueue.main.async {
                self.scrollToRow(at: IndexPath(item: 0, section: 1), at: .top, animated: true)
            }
        }
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        localTop = scrollView.contentOffset.y
        setAlphaSearchCell(localTop)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        scrollTo(localTop)
    }
    
}

// MARK: - SearchCell Binding

extension MainStocksTableView {
    
    func didTapSearchButton() {
        print("Search tapped (tableView)")
    }
}

// MARK: - MainHeader Binding

extension MainStocksTableView {
    
    func tapStoksButton() {
        print("Tapped stocks (tableView)")
    }
    
    func tapFavoriteButton() {
        print("Tapped stocks (tableView)")
    }
    
}

// MARK: - HeaderID, CellID

private enum HeaderID {
    static let mainStocksHeader = "mainStocksHeader"
}

private enum CellID {
    static let searchCell = "searchCell"
    static let mainCell = "mainCell"
}
