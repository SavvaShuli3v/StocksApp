//
//  ListStocksTableView.swift
//  StocksApp
//
//  Created by Савва Шулятьев on 01.10.2021.
//

import UIKit

protocol ListTableViewProtocol: AnyObject {
    func didTapSearch()
    func didTapStocks()
    func didTapFavourite()
    func didTapToCell(with ticker: String)
}

final class ListStocksTableView: UITableView {
    
    weak var answerDelegate: ListTableViewProtocol?
    
    var stocks = [Stock]()
    var favouriteStocks = [Stock]()
    
    var isStocks = true
    private var localTop: CGFloat = 0
    private var localScrollTop: CGFloat?
    
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
        
        self.register(ListStocksHeader.self, forHeaderFooterViewReuseIdentifier: HeaderID.mainStocksHeader)
        
        self.register(ListSearchCell.self, forCellReuseIdentifier: CellID.searchCell)
        self.register(ListStocksCell.self, forCellReuseIdentifier: CellID.mainCell)
    }
    
    override func touchesShouldCancel(in view: UIView) -> Bool {
        return true
    }
    
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension ListStocksTableView: UITableViewDelegate, UITableViewDataSource {
    
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
            precondition(false, PreconditionFailedCalls.defaultCase)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = dequeueReusableCell(withIdentifier: CellID.searchCell, for: indexPath) as! ListSearchCell
            cell.delegate = self
            return cell
        case 1:
            let cell = dequeueReusableCell(withIdentifier: CellID.mainCell, for: indexPath) as! ListStocksCell
            switch isStocks {
            case true:
                cell.set(stock: stocks[indexPath.row])
                cell.setColor(to: indexPath as NSIndexPath)
                cell.delegate = self
                return cell
            case false:
                //cell.set(stock: favouriteStocks[indexPath.row])
                cell.setColor(to: indexPath as NSIndexPath)
                return cell
            }
        default:
            precondition(false, PreconditionFailedCalls.defaultCase)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 48
        case 1:
            return 84
        default:
            precondition(false, PreconditionFailedCalls.defaultCase)
        }
    }
    
    // MARK: - HeaderSettings
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 0:
            return nil
        case 1:
            let header = dequeueReusableHeaderFooterView(withIdentifier: HeaderID.mainStocksHeader) as! ListStocksHeader
            header.delegate = self
            return header
        default:
            precondition(false, PreconditionFailedCalls.defaultCase)
        }
        
    }    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 0
        case 1:
            return 60
        default:
            precondition(false, PreconditionFailedCalls.defaultCase)
        }
    }
    
    // MARK: - Animate Methods
    
    private func setAlphaSearchCell(_ y: CGFloat) {
        
        if localScrollTop == nil {
            if y >= 0 {
                localScrollTop = y
            } else {
                localScrollTop = -y
            }
        }
        
        let localY = y + localScrollTop!
        
        weak var searchCell = self.cellForRow(at: IndexPath(item: 0, section: 0))
        weak var header = self.headerView(forSection: 1) as? ListStocksHeader
        
        if localY > 30 {
            searchCell?.alpha = 1 - (localY - 30)/10
        } else {
            searchCell?.alpha = 1
        }
        
        if localY >= 73 {
            header?.whiteView.alpha = 1
        } else {
            header?.whiteView.alpha = 0
        }
        
        if localY >= 96 && localY < 103 {
            header?.shadowView.alpha += localY/400
        } else if localY >= 103 {
            header?.shadowView.alpha = 1
        } else {
            header?.shadowView.alpha = 0
        }
    }
    
    private func scrollTo(_ y: CGFloat) {
        
        let localY = y + localScrollTop!
        
        if localY < 45  {
            DispatchQueue.main.async {
                self.scrollToRow(at: IndexPath.init(row: 0, section: 0), at: .middle, animated: true)
            }
        }

        if localY >= 45 && localY <= 91 {
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

extension ListStocksTableView: ListSearchCellProtocol {
    
    func didTapSearchButton() {
        self.answerDelegate?.didTapSearch()
    }
}

// MARK: - MainHeader Binding

extension ListStocksTableView: StocksHeaderProtocol {
    
    func tapStoksButton() {
        self.answerDelegate?.didTapStocks()
    }
    
    func tapFavoriteButton() {
        self.answerDelegate?.didTapFavourite()
    }
}

// MARK: - MainCell Binding

extension ListStocksTableView: ListStocksCellProtocol {
    func tappedToCell(with ticker: String) {
        self.answerDelegate?.didTapToCell(with: ticker)
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
