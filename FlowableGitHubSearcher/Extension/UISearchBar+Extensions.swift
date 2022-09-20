//
//  UISearchBar+Extensions.swift
//  FlowableGitHubSearcher
//
//  Created by 송하민 on 2022/09/16.
//

import UIKit

extension UISearchBar {
    
    /// Searchbar 기본 컴포넌트 옵션적용
    /// - Parameters:
    ///   - tintColor: foreground Color
    ///   - cornerRadius: corner 적용위치
    ///   - borderWidth: 테두리 두께
    ///   - borderColor: 테두리 색
    func setSearchBarOptions(tintColor: UIColor, cornerRadius: CGFloat, borderWidth: CGFloat, borderColor: UIColor) {
        self.barTintColor = tintColor
        self.layer.cornerRadius = cornerRadius
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.cgColor
        self.isTranslucent = false
        self.clipsToBounds = true
    }
    
    /// SearchBar 내부 TextField 가져오기
    /// - Returns: UITextField
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
