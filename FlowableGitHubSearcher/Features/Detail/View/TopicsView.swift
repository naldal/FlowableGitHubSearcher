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
    
    
    
    
    // MARK: - Disposable
    
    let disposeBag = DisposeBag()
    
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureLayout()
        setConstraint()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private
    
    
    
    // MARK: - Component Option
    
    
    
    // MARK: - Layout
    
    func configureLayout() {
        
    }
    
    
    // MARK: - Constraint
    
    func setConstraint() {
        
    }
    
}
