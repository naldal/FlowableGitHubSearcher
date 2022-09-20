//
//  UITextField+Extensions.swift
//  FlowableGitHubSearcher
//
//  Created by 송하민 on 2022/09/15.
//

import UIKit

extension UITextField {
    
    /// Label 컴포넌트 옵션 적용
    /// - Parameters:
    ///   - textColor: 텍스트 색
    ///   - backgroundColor: 배경 색
    ///   - font: 폰트
    ///   - align: 정렬
    ///   - keyboardType: 키보드 타입
    func setTextFieldOptions(textColor: UIColor = .black,
                             backgroundColor: UIColor = .white,
                             font: UIFont = UIFont.systemFont(ofSize: 10, weight: .regular),
                             align: NSTextAlignment = .natural,
                             keyboardType: UIKeyboardType = .default) {
        self.textColor = textColor
        self.backgroundColor = backgroundColor
        self.font = font
        self.textAlignment = align
        self.keyboardType = keyboardType
    }
    
    func setPlaceHolder(text: String = "", color: UIColor = .black) {
        self.attributedPlaceholder = NSAttributedString(string: text,
                                                        attributes: [NSAttributedString.Key.foregroundColor : color]
        )
    }
}
