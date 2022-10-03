//
//  MainFlow.swift
//  FlowableWhereAmI
//
//  Created by 송하민 on 2022/09/15.
//

import RxSwift
import RxCocoa
import RxFlow
import UIKit

class MainFlow: Flow {
    
    var root: Presentable {
        return self.rootViewController
    }
    
    private lazy var rootViewController: UINavigationController = {
        let viewController = UINavigationController()
        return viewController
    }()
    
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? FlowSteps else { return .none }
        
        switch step {
        case .mainSearchIsRequired:
            return transitionToMain()
        case let .detailRepositoryInformationIsRequired(repoName, userName):
            transitionToDetail(repositoryName: repoName, userName: userName)
            return .none
        }
    }
    
    private func transitionToMain() -> FlowContributors {
        var mainViewController = MainViewController()
        let mainViewModel = MainViewModel()
        mainViewController.bind(to: mainViewModel)
        self.rootViewController.setViewControllers([mainViewController], animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: mainViewController,
                                                 withNextStepper: mainViewModel))
    }
    
    private func transitionToDetail(repositoryName: String, userName: String) {
        self.rootViewController.setNavigationBarHidden(false, animated: true)
        self.rootViewController.navigationBar.tintColor = .white
        var detailRepositoryViewController = DetailRepositoryViewController()
        let detailRepositoryViewModel = DetailRepositoryViewModel(repositoryName: repositoryName, userName: userName)
        detailRepositoryViewController.bind(to: detailRepositoryViewModel)

        self.rootViewController.present(detailRepositoryViewController, animated: true)
    }
    
}

class MainStepper: Stepper {
    
    let steps = PublishRelay<Step>()
    private let disposeBag = DisposeBag()
    
    var initialStep: Step {
        return FlowSteps.mainSearchIsRequired
    }
    
}
