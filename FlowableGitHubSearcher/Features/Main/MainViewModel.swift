//
//  MainViewModel.swift
//  FlowableGitHubSearcher
//
//  Created by 송하민 on 2022/09/15.
//

import RxSwift
import RxCocoa
import RxFlow

protocol MainViewModelInput: Stepper {
    var searchValue: PublishSubject<String?> { get }
}

protocol MainViewModelOutput {
    var searchStartTrigger: PublishSubject<Void> { get }
    var repositoryInformations: Observable<[RepoInfo]> { get }
}

protocol MainViewModelType {
    var input: MainViewModelInput { get }
    var output: MainViewModelOutput { get }
}

final class MainViewModel: MainViewModelInput,
                           MainViewModelOutput,
                           MainViewModelType {

    // MARK: - Type
    
    var input: MainViewModelInput { return self }
    var output: MainViewModelOutput { return self }
    
    
    // MARK: - Input
    
    var steps = PublishRelay<Step>()
    var searchValue = PublishSubject<String?>()
    
    
    // MARK: - Output
    
    var repositoryInformations = Observable<[RepoInfo]>.empty()
    var searchStartTrigger = PublishSubject<Void>()
    

    
    // MARK: - Init
    
    init(networkService: NetworkService<GithubSearcherAPI> = NetworkService<GithubSearcherAPI>()) {
        let networkInteractor = NetworkInteractor(networkService: networkService)
        
        repositoryInformations = searchValue.flatMapLatest { searchValue -> Observable<[RepoInfo]> in
            guard searchValue != "" else {
                LottieManager.shared.stopLottie()
                return .just([])
            }
        
            self.searchStartTrigger.onNext(())
            let response = networkInteractor.fetchRepositories(query: searchValue!).map{ $0.items }
            return response
        }.share()
    }
    
}
