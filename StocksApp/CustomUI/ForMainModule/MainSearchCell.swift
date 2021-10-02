//
//  MainSearchCell.swift
//  StocksApp
//
//  Created by Савва Шулятьев on 01.10.2021.
//

import UIKit

protocol MainSearchCellProtocol: AnyObject {
    func didTapSearchButton()
}

final class MainSearchCell: UITableViewCell {
    
    weak var delegate: MainSearchCellProtocol?
    
    private lazy var searchButton = SimpleButton()
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = Styles.Colors.white
        self.selectionStyle = .none
        
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    
    private func setupButton() {
        self.contentView.addSubview(searchButton)
        self.searchButton.translatesAutoresizingMaskIntoConstraints = false
        self.searchButton.top(16, to: self.topAnchor)
        self.searchButton.leading(16, to: self.leadingAnchor)
        self.searchButton.trailing(-16, to: self.trailingAnchor)
        self.searchButton.height(48)
        
        self.searchButton.backgroundColor = .clear
        self.searchButton.layer.cornerRadius = 20
        self.searchButton.layer.borderWidth = 1
        self.searchButton.layer.borderColor = Styles.Colors.black.cgColor
        
        self.searchButton.setTitle(Localization.FindCompanyOrTicker, for: .normal)
        self.searchButton.setTitleColor(Styles.Colors.black, for: .normal)
        self.searchButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        self.searchButton.contentHorizontalAlignment = .left
        self.searchButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 36, bottom: 0, right: 0)
        
        self.searchButton.setImage(UIImage(named: Styles.ImageNames.ellipse), for: .normal)
        self.searchButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        
        self.searchButton.setAction {
            self.delegate?.didTapSearchButton()
        }
    }
    
}
