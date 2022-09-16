//
//  DetailRepositoryViewModel.swift
//  FlowableGitHubSearcher
//
//  Created by 송하민 on 2022/09/16.
//

import RxCocoa
import RxSwift
import UIKit
import RxFlow

protocol DetailRepositoryViewModelInput {
    
}

protocol DetailRepositoryViewModelOutput {
    
}

protocol DetailRepositoryViewModelType {
    var input: DetailRepositoryViewModelInput { get }
    var output: DetailRepositoryViewModelOutput { get }
}

class DetailRepositoryViewModel: DetailRepositoryViewModelInput,
                                 DetailRepositoryViewModelOutput,
                                 DetailRepositoryViewModelType {

    
    // MARK: - Steps
    let steps = PublishRelay<Step>()
    
    // MARK: - Type
    var input: DetailRepositoryViewModelInput { return self }
    var output: DetailRepositoryViewModelOutput { return self }
    
    
    
    // MARK: - Input
    
    
    
    // MARK: - Output

    
    
    // MARK: - Init
    
    init() {
      
    }
    
}
