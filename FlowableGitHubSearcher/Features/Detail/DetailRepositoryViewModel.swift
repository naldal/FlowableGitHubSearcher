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
    
}

protocol DetailRepositoryViewModelOutput {
    var repositoryInformation: Observable<RepositoryInformation> { get }
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

    var repositoryInformation = Observable<RepositoryInformation>.empty()
    

    
    
    // MARK: - Init
    
    init(networkService: NetworkService<GithubSearcherAPI> = NetworkService<GithubSearcherAPI>(), repositoryName: String, userName: String) {
        
        let networkInteractor = NetworkInteractor(networkService: networkService)
        repositoryInformation = networkInteractor.fetchRepository(repoName: repositoryName, userName: userName).share()
    }
    
}
