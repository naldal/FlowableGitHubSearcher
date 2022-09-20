//
//  HorizontalStackView.swift
//  FlowableGitHubSearcher
//
//  Created by 송하민 on 2022/09/21.
//

import UIKit

final class HorizontalStackView: UIStackView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initHorizontalStackView()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        self.initHorizontalStackView()
    }
    
    private func initHorizontalStackView() {
        self.backgroundColor = .white
        self.axis = .horizontal
        self.distribution = .fill
        self.alignment = .center
        self.spacing = 5
    }
    
    func setSpacing(space: CGFloat) {
        self.spacing = space
    }
    
}
