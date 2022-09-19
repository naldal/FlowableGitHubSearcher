//
//  DetailRepositoryViewController.swift
//  FlowableGitHubSearcher
//
//  Created by 송하민 on 2022/09/16.
//

import RxSwift
import UIKit

final class DetailRepositoryViewController: UIViewController, ViewModelBindableType {

    var viewModel: DetailRepositoryViewModel!
    
    private lazy var btn: UIButton = {
        let button = UIButton()
        button.backgroundColor = .black
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .gray
        
        self.view.addSubview(btn)
        btn.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.width.height.equalTo(200)
        }
    }
    
    func bindViewModel() {
        let input = self.viewModel.input
        let output = self.viewModel.output
        
        // MARK: input
        
        // MARK: output
        output.repositoryInformation
            .subscribe(onNext: { info in
                // TEST
                print("info ~~> \(info)")
            }).disposed(by: DisposeBag())
    }
}
