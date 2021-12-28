//
//  FollowButton.swift
//  StocksApp
//
//  Created by Савва Шулятьев on 05.11.2021.
//

import UIKit

final class FollowButton: SimpleAnimatedButton {
    
    init() {
        super.init()
        setupUI()
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.backgroundColor = Styles.Colors.black
        self.layer.cornerRadius = 16
        
        self.setTitle(Localization.follow, for: .normal)
        self.setTitleColor(Styles.Colors.white, for: .normal)
        self.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
    }
}
