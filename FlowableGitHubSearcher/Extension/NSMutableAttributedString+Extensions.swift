//
//  NSMutableString+Extensions.swift
//  FlowableGitHubSearcher
//
//  Created by 송하민 on 2022/09/20.
//

import UIKit

extension NSMutableAttributedString {
    
    /// Attribute: Color & Font 속성
    /// - Parameters:
    ///   - str: 텍스트
    ///   - color: 텍스트 색상
    ///   - font: 텍스트 폰트
    func setAttributedString(str: String,
                             color: UIColor,
                             font: UIFont) {
        self.setAttributedString(NSMutableAttributedString(string: str,
                                                           attributes: [NSAttributedString.Key.foregroundColor: color,
                                                                        NSAttributedString.Key.font: font])
        )
    }
}
