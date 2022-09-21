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
    var viewWillAppear: PublishSubject<Void> { get }
}

protocol DetailRepositoryViewModelOutput {
    var repositoryInformation: Driver<RepositoryInformation> { get }
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
    var viewWillAppear = PublishSubject<Void>()

    
    
    // MARK: - Output

    var repositoryInformation = Driver<RepositoryInformation>.empty()
    
    
    // MARK: - Init
    
    init(networkService: NetworkService<GithubSearcherAPI> = NetworkService<GithubSearcherAPI>(), repositoryName: String, userName: String) {
        
        let networkInteractor = NetworkInteractor(networkService: networkService)
        
        let sharedViewWillAppear = viewWillAppear.share()
        
        repositoryInformation = sharedViewWillAppear.take(1)
            .flatMapLatest { n in
                return networkInteractor.fetchRepository(repoName: repositoryName, userName: userName)
        }.asDriverOnErrorJustComplete()
        
    }
    
}
