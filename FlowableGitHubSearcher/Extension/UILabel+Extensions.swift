//
//  UILabel+Extensions.swift
//  FlowableGitHubSearcher
//
//  Created by 송하민 on 2022/09/18.
//

import UIKit

extension UILabel {
    
    /// label option
    /// - Parameters:
    ///   - text: 텍스트
    ///   - color: 텍스트 색상
    ///   - align: 텍스트 align
    ///   - font: 텍스트 폰트
    func setLabelOptions(text: String = "",
                         numberOfLines: Int = 1,
                         color: UIColor = .black,
                         align: NSTextAlignment = .natural,
                         font: UIFont = UIFont.systemFont(ofSize: 10, weight: .regular)) {
        self.text = text
        self.textColor = color
        self.textAlignment = align
        if self.numberOfLines == 1 {
            self.numberOfLines = numberOfLines
        }
        self.font = font
    }
    
}
