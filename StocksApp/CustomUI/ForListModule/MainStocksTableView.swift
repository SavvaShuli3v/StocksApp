//
//  MainStocksTableView.swift
//  StocksApp
//
//  Created by Савва Шулятьев on 01.10.2021.
//

import UIKit

protocol ListTableViewProtocol: AnyObject {
    func didTapSearch()
    func didTapStocks()
    func didTapFavourite()
    func didTapToCell(with stock: Stock)
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
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = dequeueReusableCell(withIdentifier: CellID.searchCell, for: indexPath) as! ListSearchCell
            cell.delegate = self
            return cell
        default:
            let cell = dequeueReusableCell(withIdentifier: CellID.mainCell, for: indexPath) as! ListStocksCell
            switch isStocks {
            case true:
                cell.set(stock: stocks[indexPath.row])
                cell.setColor(to: indexPath as NSIndexPath)
                cell.delegate = self
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
            return 48
        case 1:
            return 84
        default:
            return 0
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
            return nil
        }
        
    }    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 1 {
            return 60
        } else {
            return 0
        }
    }
    
    // MARK: - Animate Methods
    
    private func setAlphaSearchCell(_ y: CGFloat) {
        print(y) // -20
        // -47
        // set = -48    (-48)  -48...-18  dif = 30
        // -20...10
        if localScrollTop == nil {
            localScrollTop = y
        }
        //print(localScrollTop)
        
        weak var searchCell = self.cellForRow(at: IndexPath(item: 0, section: 0))
        weak var header = self.headerView(forSection: 1) as? ListStocksHeader
        
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
        
//        if y >= 35 && y < 37 {
//            header?.shadowView.alpha += y/150
//        } else if y >= 37 {
//            header?.shadowView.alpha = 1
//        } else {
//            header?.shadowView.alpha = 1
//        }
    }
    
    private func scrollTo(_ y: CGFloat) {
        
//        if y < 5  {
//            DispatchQueue.main.async {
//                self.scrollToRow(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
//            }
//        }
//
//        if y >= 5 && y <= 30 {
//            DispatchQueue.main.async {
//                self.scrollToRow(at: IndexPath(item: 0, section: 1), at: .top, animated: true)
//            }
//        }
        
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
    
    func tappedToCell(with stock: Stock) {
        self.answerDelegate?.didTapToCell(with: stock)
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
