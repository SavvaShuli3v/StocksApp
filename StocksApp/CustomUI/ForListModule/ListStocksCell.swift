//
//  ListStocksCell.swift
//  StocksApp
//
//  Created by Савва Шулятьев on 01.10.2021.
//

import UIKit

protocol ListStocksCellProtocol: AnyObject {
    func tappedToCell(with ticker: String)
}

final class ListStocksCell: UITableViewCell {
    
    weak var delegate: ListStocksCellProtocol?
    private var stock: Stock?
    
    private lazy var stockButton = AnimatedStockButton()
    
    private lazy var detailView = UIView()
    
    private lazy var companyLogo = UIImageView()
    private lazy var ticker = UILabel()
    private lazy var companyName = UILabel()
    
    private lazy var price = UILabel()
    private lazy var changePrice = UILabel()
    
    // MARK: - Init
 
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = Styles.Colors.white
        self.selectionStyle = .none
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    
    func set(stock: Stock) {
        self.stock = stock
        
        self.ticker.text = stock.ticker
        self.companyName.text = stock.companyName

        setCompanyPrice(stock.price)
        changeLogo(stock.logo)
        changePriceUpdate(stock.changePrice)
    }
    
    func setColor(to index: NSIndexPath) {
        if index.row % 2 == 0 {
            self.detailView.backgroundColor = Styles.Colors.lightGray
        } else {
            self.detailView.backgroundColor = Styles.Colors.white
        }
    }
    
    // MARK: - Private Methods
    
    private func setupCell() {
        setupDetailView()
        
        setupCompanyLogo()
        setupTicker()
        setupCompanyName()
        
        setupPrice()
        setupChangePrice()

        setupStockButton()
    }
    
    private func setupStockButton() {
        self.contentView.addSubview(stockButton)
        self.stockButton.translatesAutoresizingMaskIntoConstraints = false
        self.stockButton.allConstraints(to: contentView, top: 8, bottom: -8, leading: 16, tralling: -16)
        self.stockButton.backgroundColor = .clear
        self.stockButton.layer.cornerRadius = 16
        
        self.stockButton.setAction {
            self.delegate?.tappedToCell(with: self.stock!.ticker)
        }
    }

    private func setupDetailView() {
        self.addSubview(self.detailView)
        self.detailView.translatesAutoresizingMaskIntoConstraints = false
        self.detailView.allConstraints(to: self, top: 8, bottom: -8, leading: 16, tralling: -16)
        
        self.detailView.backgroundColor = Styles.Colors.lightGray
        self.detailView.layer.cornerRadius = 16
    }

    private func setupCompanyLogo() {

        self.detailView.addSubview(self.companyLogo)
        self.companyLogo.translatesAutoresizingMaskIntoConstraints = false
        self.companyLogo.top(8, to: self.detailView.topAnchor)
        self.companyLogo.leading(8, to: self.detailView.leadingAnchor)
        self.companyLogo.width(52)
        self.companyLogo.height(52)
        
        self.companyLogo.backgroundColor = .clear
        self.companyLogo.layer.cornerRadius = 12
        self.companyLogo.clipsToBounds = true
    }
    
    private func setupTicker() {
        self.detailView.addSubview(self.ticker)
        self.ticker.translatesAutoresizingMaskIntoConstraints = false
        self.ticker.top(14, to: self.detailView.topAnchor)
        self.ticker.leading(72, to: self.detailView.leadingAnchor)
        self.ticker.adjustsFontSizeToFitWidth = true
        self.ticker.height(24)
        
        self.ticker.backgroundColor = .clear
        self.ticker.textColor = Styles.Colors.black
        self.ticker.font = UIFont.systemFont(ofSize: 18, weight: .bold)
    }
    
    private func setupCompanyName() {
        self.detailView.addSubview(self.companyName)
        self.companyName.translatesAutoresizingMaskIntoConstraints = false
        self.companyName.bottom(-14, to: self.detailView.bottomAnchor)
        self.companyName.leading(72, to: self.detailView.leadingAnchor)
        self.companyName.trailing(-100, to: self.detailView.trailingAnchor)
        self.companyName.height(16)
        
        self.companyName.backgroundColor = .clear
        self.companyName.textColor = Styles.Colors.black
        self.companyName.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
    }
    
    private func setupPrice() {
        self.detailView.addSubview(self.price)
        self.price.translatesAutoresizingMaskIntoConstraints = false
        self.price.top(14, to: self.detailView.topAnchor)
        self.price.trailing(-17, to: self.detailView.trailingAnchor)
        self.price.adjustsFontSizeToFitWidth = true
        self.price.height(24)
        
        self.price.backgroundColor = .clear
        self.price.textColor = Styles.Colors.black
        self.price.textAlignment = .right
        self.price.font = UIFont.systemFont(ofSize: 18, weight: .bold)
    }
    
    private func setupChangePrice() {
        self.detailView.addSubview(self.changePrice)
        self.changePrice.translatesAutoresizingMaskIntoConstraints = false
        self.changePrice.bottom(-14, to: self.detailView.bottomAnchor)
        self.changePrice.trailing(-17, to: self.detailView.trailingAnchor)
        self.changePrice.width(80)
        self.changePrice.height(16)
        
        self.changePrice.backgroundColor = .clear
        self.changePrice.textColor = Styles.Colors.black
        self.changePrice.textAlignment = .right
        self.changePrice.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
    }
    
    private func changeLogo(_ image: UIImage?) {
        self.companyLogo.image = image
    }
    
    private func setCompanyPrice(_ price: Double?) {
        guard let price = price else { return }
        self.price.text = "\(price)"
    }
    
    private func changePriceUpdate(_ change: Double?) {
        guard let change = change else { return }
        
        if change >= 0 {
            let formatChange = (String(format: "%.2f", change))
            self.changePrice.text = "+$\(formatChange)"
            self.changePrice.textColor = Styles.Colors.green
        } else {
            let formatChange = (String(format: "%.2f", -change))
            self.changePrice.text = " -$\(formatChange)"
            self.changePrice.textColor = Styles.Colors.red
        }
    }
    
}
