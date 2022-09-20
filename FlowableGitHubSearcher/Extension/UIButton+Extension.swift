//
//  UIButton+Extension.swift
//  FlowableGitHubSearcher
//
//  Created by 송하민 on 2022/09/20.
//

import UIKit

extension UIButton {
    
    func setButtonStyle(
        attrStr: NSAttributedString,
        bgColor: UIColor,
        borderColor: UIColor? = nil,
        borderWidth: CGFloat? = nil,
        radius: CGFloat? = nil) {
            
            self.backgroundColor = bgColor
            self.setAttributedTitle(attrStr, for: .normal)
            self.setRoundViewLayer(borderColor: borderColor,
                                   borderWidth: borderWidth,
                                   radius: radius)
        }
}
