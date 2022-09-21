//
//  TopicsView.swift
//  FlowableGitHubSearcher
//
//  Created by 송하민 on 2022/09/20.
//

import SnapKit
import RxSwift
import UIKit

final class TopicsView: UIView {
    
    // MARK: - Component
    
    private lazy var baseHorizontalStackView: HorizontalStackView = {
        let horizonStack = HorizontalStackView()
        horizonStack.setSpacing(space: 5)
        return horizonStack
    }()
    
    
    // MARK: - Disposable
    
    let disposeBag = DisposeBag()
    
    
    // MARK: - Init
    
    init() {
        super.init(frame: CGRect.zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private
    
    private var topicViews: [UIView]?
    
    
    // MARK: - Component Option
    
    public func makeTopicsViews(topics: [String?]) {
        
        setLayout()
        configureConstraints()
        
        topics.compactMap { $0 }.forEach { topic in
            let topicBaseView = UIView().then {
                $0.backgroundColor = .cancelGray
            }
            baseHorizontalStackView.addArrangedSubview(topicBaseView)
            let topicText = UILabel().then {
                $0.setLabelOptions(text: topic,
                                   numberOfLines: 1,
                                   color: .charcoal,
                                   align: .center,
                                   font: .appleSDGothicNeo(weight: .medium,
                                                           size: 13)
                )
            }
            topicBaseView.addSubview(topicText)
            topicText.snp.makeConstraints { make in
                make.centerX.centerY.equalToSuperview()
            }
            topicBaseView.snp.makeConstraints { make in
                make.width.greaterThanOrEqualTo(topicText.snp.width).multipliedBy(1.2)
                make.height.equalToSuperview()
            }
            
        }
    }
    
    
    // MARK: - Layout
    
    func setLayout() {
        self.addSubview(baseHorizontalStackView)
    }
    
    
    // MARK: - Constraint
    
    func configureConstraints() {
        baseHorizontalStackView.snp.makeConstraints { make in
            make.edges.width.height.equalToSuperview()
        }
    }
    
}
