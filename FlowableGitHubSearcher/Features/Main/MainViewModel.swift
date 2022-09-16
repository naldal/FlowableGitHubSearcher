//
//  MainViewModel.swift
//  FlowableGitHubSearcher
//
//  Created by 송하민 on 2022/09/15.
//

import RxSwift
import RxCocoa
import RxFlow

protocol MainViewModelInput {
    var viewWillAppear: PublishRelay<Void> { get }
}

protocol MainViewModelOutput {
    var realDataOutput: Driver<RepoSearchResponse> { get }
}

protocol MainViewModelType {
    var input: MainViewModelInput { get }
    var output: MainViewModelOutput { get }
}

final class MainViewModel: Stepper,
                           MainViewModelInput,
                           MainViewModelOutput,
                           MainViewModelType {
    
    
    // MARK: - Steps
    
    let steps = PublishRelay<Step>()
    
    
    // MARK: - Type
    
    var input: MainViewModelInput { return self }
    var output: MainViewModelOutput { return self }
    
    
    // MARK: - Input
    
    var viewWillAppear = PublishRelay<Void>()
    
    
    // MARK: - Output
    
    var realDataOutput = Driver<RepoSearchResponse>.empty()
    

    
    // MARK: - Init
    init(networkService: NetworkService<GithubSearcherAPI> = NetworkService<GithubSearcherAPI>()) {
        let networkInteractor = NetworkInteractor(networkService: networkService)
        
        let viewWillAppearShared = viewWillAppear.share()
        
        let fetchRepositoriesResponse = viewWillAppearShared
            .flatMapLatest({ networkInteractor.fetchRepositories(query: "whereIam") })
            .share()
        
        realDataOutput = fetchRepositoriesResponse
            .filter({ data in
                print("data ~> \(data)")
                return true
            })

            .asDriverOnErrorJustComplete()
    }
}
