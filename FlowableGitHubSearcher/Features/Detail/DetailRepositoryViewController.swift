//
//  DetailRepositoryViewController.swift
//  FlowableGitHubSearcher
//
//  Created by 송하민 on 2022/09/16.
//

import RxCocoa
import RxSwift
import UIKit

final class DetailRepositoryViewController: UIViewController, ViewModelBindableType {

    var viewModel: DetailRepositoryViewModel!
    
    // MARK: - Components
    
    
    // MARK: - Component Options
    
    
    
    // MARK: - DisposeBag
    
    let disposeBag = DisposeBag()
    
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .gray
        
        self.setLayout()
        self.configureConstraints()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewModel.input.viewWillAppear.onNext(())
    }
    
    // MARK: - Set Layout
    
    private func setLayout() {
        
    }
    
    // MARK: - Configure Constraints
    
    private func configureConstraints() {
        
    }
    
    
    // MARK: - Bind
    
    func bindViewModel() {
        let _ = self.viewModel.input
        let output = self.viewModel.output
        
        // MARK: input
        
        // MARK: output
        
        output.repositoryInformation
            .drive(onNext: { info in
                print("aaa")
                print("info ~~> \(info)")
            })
            .disposed(by: disposeBag)
    }
}
