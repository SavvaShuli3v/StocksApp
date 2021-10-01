//
//  SimpleButton.swift
//  StocksApp
//
//  Created by Савва Шулятьев on 01.10.2021.
//

import UIKit

public typealias Action = () -> Void

final class SimpleButton: UIButton {
    
    private var action: Action?
    
    // MARK: - Init
    
    public init(frame: CGRect = .zero, action: Action? = nil) {
        self.action = action
        super.init(frame: frame)
        addTarget(self, action: #selector(touchEnded(_:)), for: [.touchUpInside, .touchUpOutside, .touchDragOutside])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setAction(_ action: Action?) {
        self.action = action
    }
    
    @objc private func touchEnded(_: Any) {
            action?()
    }
    
}
