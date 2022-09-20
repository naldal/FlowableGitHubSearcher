//
//  UIView+Extensions.swift
//  FlowableGitHubSearcher
//
//  Created by 송하민 on 2022/09/15.
//

import UIKit

extension UIView {
    
    // MARK: - Layer
    
    /// view's layer에 color, width, radius를 적용
    /// - Parameters:
    ///   - borderColor: layer 색상
    ///   - borderWidth: layer width
    ///   - radius: layer round 각도
    ///   - maskedCorners: layer round 적용 위치
    func setRoundViewLayer(borderColor: UIColor? = nil, borderWidth: CGFloat? = nil, radius: CGFloat? = nil) {
        
        if let color = borderColor, let width = borderWidth {
            self.layer.borderColor = color.cgColor
            self.layer.borderWidth = width
            self.layer.cornerRadius = radius ?? 0
        }
        
        if let color = borderColor, let width = borderWidth {
            self.layer.borderColor = color.cgColor
            self.layer.borderWidth = width
        }
        self.layer.masksToBounds = true
    }
    
    /// subviews 추가
    /// - Parameter views: subView Array
    func addSubviews(_ views: [UIView]) {
        views.forEach {
            self.addSubview($0)
        }
    }
    
    /// subviews 전체삭제
    func removeAllSubviews() {
        subviews.forEach { $0.removeFromSuperview() }
    }
}
