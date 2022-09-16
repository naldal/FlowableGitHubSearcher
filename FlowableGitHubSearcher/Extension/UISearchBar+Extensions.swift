//
//  UISearchBar+Extensions.swift
//  FlowableGitHubSearcher
//
//  Created by 송하민 on 2022/09/16.
//

import UIKit

extension UISearchBar {

    func getTextField() -> UITextField? {
        if #available(iOS 13.0, *) {
            return self.searchTextField
        } else {
            var textField: UITextField?
            for view: UIView in (self.subviews[0]).subviews {

                if let textFieldTmp = view as? UITextField {
                    textField = textFieldTmp
                    break
                }
            }

            return textField

        }
    }
}
