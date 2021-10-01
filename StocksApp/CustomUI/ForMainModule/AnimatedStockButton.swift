//
//  AnimatedStockButton.swift
//  StocksApp
//
//  Created by Савва Шулятьев on 02.10.2021.
//

import UIKit

final class AnimatedStockButton: UIButton {
    private var action: Action?
    
    private var isPressed: Bool = false {
        didSet {
            guard isPressed != oldValue else { return }
            UIView.animate(
                withDuration: tapAnimationDuration,
                delay: 0,
                options: .allowUserInteraction,
                animations: {
                    self.alpha *= self.isPressed ? 0.5 : 2
                    self.backgroundColor = self.isPressed ? Styles.Colors.lightGray : .clear
                }
            )
        }
    }
    
    public init(frame: CGRect = .zero, action: Action? = nil) {
        self.action = action
        super.init(frame: frame)
        addTarget(self, action: #selector(press(_:)), for: .touchDown)
        addTarget(self, action: #selector(touchEnded(_:)), for: [.touchUpInside, .touchUpOutside, .touchDragOutside])
        addTarget(self, action: #selector(touchCanceled(_:)), for: .touchCancel)
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setAction(_ action: Action?) {
        self.action = action
    }
    
    @objc private func press(_: Any) {
        self.isPressed = true
    }
    
    @objc private func touchEnded(_: Any) {
        if isTouchInside, isPressed {
            action?()
        }
        self.isPressed = false
    }
    
    @objc private func touchCanceled(_: Any) {
        self.isPressed = false
    }
}

private let tapAnimationDuration = 0.2
