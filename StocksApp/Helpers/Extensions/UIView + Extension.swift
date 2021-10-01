//
//  UIView + Extension.swift
//  StocksApp
//
//  Created by Савва Шулятьев on 01.10.2021.
//

import UIKit

extension UIView {
    
    func top(_ constant: CGFloat = 0, to anchor: NSLayoutYAxisAnchor? = nil) {
        precondition(!translatesAutoresizingMaskIntoConstraints, autoLayoutIsDisabledError)
        self.topAnchor.constraint(equalTo: anchor ?? self.superview!.topAnchor, constant: constant).isActive = true
    }
    
    func bottom(_ constant: CGFloat = 0.0, to anchor: NSLayoutYAxisAnchor? = nil) {
        precondition(!translatesAutoresizingMaskIntoConstraints, autoLayoutIsDisabledError)
        self.bottomAnchor.constraint(equalTo: anchor ?? self.superview!.bottomAnchor, constant: constant).isActive = true
    }
    
    func leading(_ constant: CGFloat = 0.0, to anchor: NSLayoutXAxisAnchor? = nil) {
        precondition(!translatesAutoresizingMaskIntoConstraints, autoLayoutIsDisabledError)
        self.leadingAnchor.constraint(equalTo: anchor ?? self.superview!.leadingAnchor, constant: constant).isActive = true
    }
    
    func trailing(_ constant: CGFloat = 0.0, to anchor: NSLayoutXAxisAnchor? = nil) {
        precondition(!translatesAutoresizingMaskIntoConstraints, autoLayoutIsDisabledError)
        self.trailingAnchor.constraint(equalTo: anchor ?? self.superview!.trailingAnchor, constant: constant).isActive = true
    }
    
    func height(_ constant: CGFloat) {
        precondition(!translatesAutoresizingMaskIntoConstraints, autoLayoutIsDisabledError)
        self.heightAnchor.constraint(equalToConstant: constant).isActive = true
    }
    
    func width(_ constant: CGFloat) {
        precondition(!translatesAutoresizingMaskIntoConstraints, autoLayoutIsDisabledError)
        self.widthAnchor.constraint(equalToConstant: constant).isActive = true
    }
    
    func allConstraints(to superView: UIView, top: CGFloat = 0, bottom: CGFloat = 0, leading: CGFloat = 0, tralling: CGFloat = 0) {
        precondition(!translatesAutoresizingMaskIntoConstraints, autoLayoutIsDisabledError)

        self.topAnchor.constraint(equalTo: superView.topAnchor, constant: top).isActive = true
        self.bottomAnchor.constraint(equalTo: superView.bottomAnchor, constant: bottom).isActive = true
        self.leadingAnchor.constraint(equalTo: superView.leadingAnchor, constant: leading).isActive = true
        self.trailingAnchor.constraint(equalTo: superView.trailingAnchor, constant: tralling).isActive = true
    }
    
}

private let autoLayoutIsDisabledError = "Auto layout is disabled. Set translatesAutoresizingMaskIntoConstraints = false or .autoLayout() to fix it"
