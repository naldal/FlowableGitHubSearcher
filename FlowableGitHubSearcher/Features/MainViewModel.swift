//
//  MainViewModel.swift
//  FlowableGitHubSearcher
//
//  Created by 송하민 on 2022/09/15.
//

import RxCocoa
import RxFlow

final class MainViewModel: Stepper {
    let steps = PublishRelay<Step>()
    
    init() {
        
    }
}
