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

protocol DetailRepositoryViewModelInput: Stepper {
    var backAction: PublishSubject<Bool> { get }
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
    

    
    
    // MARK: - Type
    var input: DetailRepositoryViewModelInput { return self }
    var output: DetailRepositoryViewModelOutput { return self }
    
    
    
    // MARK: - Input
    
    let steps = PublishRelay<Step>()
    var backAction = PublishSubject<Bool>()
    
    
    
    // MARK: - Output

    
    
    // MARK: - Init
    
    init(repositoryName: String, userName: String) {
        print("~~~>")
        print(repositoryName)
        print(userName)
        
    }
    
}
