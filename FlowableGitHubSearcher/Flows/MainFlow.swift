//
//  MainFlow.swift
//  FlowableWhereAmI
//
//  Created by 송하민 on 2022/09/15.
//

import Then
import Foundation
import RxFlow
import UIKit

class MainFlow: Flow {
    var root: Presentable {
        return self.rootViewController
    }
    
    private lazy var rootViewController: MainViewController = {
        var viewController = MainViewController()
        viewController.bind(to: MainViewModel())
        return viewController
    }()
    
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? FlowSteps else { return .none }
        
        switch step {
        case .mainSearchIsRequired:
            return test()
        default:
            return .none
        }
    }
    
    private func test() -> FlowContributors {
        self.rootViewController.title = "this is test"
//        return .one(flowContributor: .contribute(withNextPresentable: testVC, withNextStepper: testVC.viewModel))
        return .none
    }
    
}

