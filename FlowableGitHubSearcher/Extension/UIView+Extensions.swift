//
//  UIView+Extensions.swift
//  FlowableGitHubSearcher
//
//  Created by 송하민 on 2022/09/15.
//

import UIKit

extension UIView {
    func addSubviews(_ views: [UIView]) {
        views.forEach {
            self.addSubview($0)
        }
    }
    
    func removeAllSubviews() {
        subviews.forEach { $0.removeFromSuperview() }
    }
}
