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
    
}

protocol MainViewModelOutput {
    var testOutput: Observable<String> { get }
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
    
    
    // MARK: - Output
    var testOutput = Observable<String>.just("this is TEST!")
    
    
    // MARK: - Init
    init() {
        
    }
}
