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
    var test: Observable<String> { get }
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

    var test = Observable<String>.just("aa")
    var repositoryInformation = Driver<RepositoryInformation>.empty()
    

    
    
    // MARK: - Init
    
    init(networkService: NetworkService<GithubSearcherAPI> = NetworkService<GithubSearcherAPI>(), repositoryName: String, userName: String) {
        
        let networkInteractor = NetworkInteractor(networkService: networkService)
        
        let sharedViewWillAppear = viewWillAppear.share()
        
        repositoryInformation = sharedViewWillAppear.take(1)
            .flatMapLatest { n in
                print("n ~> \(n)")
                return networkInteractor.fetchRepository(repoName: repositoryName, userName: userName)
        }.asDriverOnErrorJustComplete()
    
    }
    
}
