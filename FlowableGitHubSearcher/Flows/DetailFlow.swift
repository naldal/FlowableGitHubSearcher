//
//  DetailFlow.swift
//  FlowableGitHubSearcher
//
//  Created by 송하민 on 2022/09/18.
//

import RxCocoa
import RxSwift
import RxFlow
import UIKit

class DetailFlow: Flow {
    var root: RxFlow.Presentable {
        return self.rootViewController
    }
    
    private lazy var rootViewController: UIViewController = {
        let viewController = UIViewController()
        return viewController
    }()
    
    func navigate(to step: RxFlow.Step) -> RxFlow.FlowContributors {
        
        return .none
    }
    
    
}
