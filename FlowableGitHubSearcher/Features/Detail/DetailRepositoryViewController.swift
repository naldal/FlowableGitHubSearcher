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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .redOrange
    }
    
    func bindViewModel() {
        
    }
}
