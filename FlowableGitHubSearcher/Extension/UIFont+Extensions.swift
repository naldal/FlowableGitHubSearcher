//
//  UIFont+Extension.swift
//  FlowableGitHubSearcher
//
//  Created by 송하민 on 2022/09/15.
//

import UIKit

enum AppleSDGothicNeo: String {
    case regular = "AppleSDGothicNeo-Regular"
    case medium = "AppleSDGothicNeo-Medium"
    case semibold = "AppleSDGothicNeo-SemiBold"
    case bold = "AppleSDGothicNeo-Bold"
}

extension UIFont {
    class func appleSDGothicNeo(weight: AppleSDGothicNeo = .medium, size: CGFloat) -> UIFont {
        return UIFont(name: weight.rawValue, size: size) ?? UIFont.systemFont(ofSize: size)
    }
}
