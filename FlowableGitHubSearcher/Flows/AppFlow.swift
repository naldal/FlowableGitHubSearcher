//
//  AppFlow.swift
//  FlowableWhereAmI
//
//  Created by 송하민 on 2022/09/15.
//

import RxSwift
import RxCocoa
import RxFlow
import UIKit

class AppFlow: Flow {
    
    var root: Presentable {
        return self.rootViewController
    }
    
    private lazy var rootViewController: UINavigationController = {
        let viewController = UINavigationController()
        viewController.setNavigationBarHidden(true, animated: false)
        return viewController
    }()
    
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? FlowSteps else { return .none }
        
        switch step {
        case .basicViewControllerIsRequired:
            return navigationToMainScreen()
        default:
            return .none
        }
    }
    
    private func navigationToMainScreen() -> FlowContributors {
        let mainFlow = MainFlow()
        Flows.use(mainFlow, when: .created) { [weak self] root in
            guard let self = self else { return }
            self.rootViewController.pushViewController(root, animated: false)
        }
        
        return .one(flowContributor: .contribute(withNextPresentable: mainFlow, withNextStepper: OneStepper(withSingleStep: FlowSteps.mainSearchIsRequired)))
    }
    
}

class AppStepper: Stepper {
    
    let steps = PublishRelay<Step>()
    private let disposeBag = DisposeBag()
    
    var initialStep: Step {
        return FlowSteps.basicViewControllerIsRequired
    }
    
}
