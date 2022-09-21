//
//  StarAndForkView.swift
//  FlowableGitHubSearcher
//
//  Created by 송하민 on 2022/09/20.
//

import Then
import SnapKit
import RxSwift
import UIKit

final class StarAndForkView: UIView {
    
    // MARK: - Component
    
    private lazy var baseHorizontalStackView: HorizontalStackView = {
        let horizonStack = HorizontalStackView()
        return horizonStack
    }()
    
    private let starIcon = UIImageView().then {
        $0.image = UIImage(systemName: "star.fill")
        $0.tintColor = .greenishGrey
    }
    
    private let startCountLabel = UILabel().then {
        $0.setLabelOptions(numberOfLines: 1,
                           color: .charcoal,
                           align: .left,
                           font: .appleSDGothicNeo(weight: .medium,
                                                   size: 11)
        )
        $0.adjustsFontSizeToFitWidth = true
    }
    
    private let forkIcon = UIImageView().then {
        $0.image = UIImage(systemName: "tuningfork")
        $0.tintColor = .greenishGrey
    }
    
    private let forkCountLabel = UILabel().then {
        $0.setLabelOptions(numberOfLines: 1,
                           color: .charcoal,
                           align: .left,
                           font: .appleSDGothicNeo(weight: .medium,
                                                   size: 11)
        )
        $0.adjustsFontSizeToFitWidth = true
    }
    
    // MARK: - Init
    
    init() {
        super.init(frame: CGRect.zero)
        setStackValues()
        configureLayout()
        setConstraint()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Component Option
    
    public func setStackValues(star: Int = 0, fork: Int = 0) {
        self.startCountLabel.text = star.description
        self.forkCountLabel.text = fork.description
    }
    
    public func setSize(fontSize: CGFloat) {
        self.startCountLabel.font = .appleSDGothicNeo(size: fontSize)
    }
    
    public func setIcon(starIcon: UIImage, forkIcon: UIImage, size: CGFloat) {
        self.starIcon.image = starIcon
        self.forkIcon.image = forkIcon
        [self.starIcon, self.forkIcon].forEach { icon in
            icon.snp.makeConstraints { make in
                make.width.height.equalTo(size)
            }
        }
    }
    
    
    
    // MARK: - Layout
    
    func configureLayout() {
        self.addSubview(baseHorizontalStackView)
        [starIcon,
         startCountLabel,
         forkIcon,
         forkCountLabel]
            .forEach { baseHorizontalStackView.addArrangedSubview($0) }
        baseHorizontalStackView.setCustomSpacing(10, after: startCountLabel)
    }
    
    
    // MARK: - Constraint
    
    func setConstraint() {
        baseHorizontalStackView.snp.makeConstraints { make in
            make.edges.width.height.equalToSuperview()
        }
        
        [starIcon, forkIcon].forEach { icon in
            icon.snp.makeConstraints { make in
                make.width.height.equalTo(baseHorizontalStackView.snp.height)
            }
        }
        
        [startCountLabel, forkCountLabel].forEach { label in
            label.snp.makeConstraints { make in
                make.width.greaterThanOrEqualTo(baseHorizontalStackView.snp.height)
                make.centerY.equalToSuperview()
            }
        }
    }
    
}
