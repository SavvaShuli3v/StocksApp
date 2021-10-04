//
//  UISearchBar + Extension.swift
//  StocksApp
//
//  Created by Савва Шулятьев on 04.10.2021.
//

import UIKit

extension UISearchBar {

    func setupSearchBar(background: UIColor = .white, inputText: UIColor = .black, placeholderText: UIColor = .gray, image: UIColor = .black) {

        self.searchBarStyle = .minimal

        self.barStyle = .default

        // IOS 12 and lower:
        for view in self.subviews {

            for subview in view.subviews {
                if subview is UITextField {
                    if let textField: UITextField = subview as? UITextField {

                        // Background Color
                        textField.backgroundColor = background

                        //   Text Color
                        textField.textColor = inputText

                        //  Placeholder Color
                        textField.attributedPlaceholder = NSAttributedString(string: textField.placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor : placeholderText])

                        //  Default Image Color
                        if let leftView = textField.leftView as? UIImageView {
                            leftView.image = leftView.image?.withRenderingMode(.alwaysTemplate)
                            leftView.tintColor = image
                        }

                        let backgroundView = textField.subviews.first
                        backgroundView?.backgroundColor = background
                        backgroundView?.layer.cornerRadius = 10.5
                        backgroundView?.layer.masksToBounds = true

                    }
                }
            }

        }

        // IOS 13 only:
        if let textField = self.value(forKey: "searchField") as? UITextField {

            // Background Color
            textField.backgroundColor = background

            //   Text Color
            textField.textColor = inputText

            //  Placeholder Color
            textField.attributedPlaceholder = NSAttributedString(string: textField.placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor : placeholderText])

            //  Default Image Color
            if let leftView = textField.leftView as? UIImageView {
                leftView.image = leftView.image?.withRenderingMode(.alwaysTemplate)
                leftView.tintColor = image
            }

        }

    }

}
