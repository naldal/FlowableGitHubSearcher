//
//  ViewController.swift
//  FlowableGitHubSearcher
//
//  Created by 송하민 on 2022/09/15.
//

import RxCocoa
import RxSwift
import UIKit

class MainViewController: UIViewController, ViewModelBindableType {
    
    // MARK: - ViewModelType
    var viewModel: MainViewModelType!
    
    // MARK: - Components
    
    // MARK: - Component Options

    // MARK: - DisposeBag
    let disposeBag = DisposeBag()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
    }
    
    // MARK: - Set Layout
    private func setLayout() {
        
    }
    
    // MARK: - Configure Constraints
    private func configureConstraints() {
        
    }

    // MARK: - Bind
    func bindViewModel() {
        let output = self.viewModel.output
        
        output.testOutput
            .subscribe(onNext: { str in
                print(str)
            })
            .disposed(by: self.disposeBag)
    }
    
}

