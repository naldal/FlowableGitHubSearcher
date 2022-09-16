//
//  NetworkInteractor.swift
//  FlowableGitHubSearcher
//
//  Created by 송하민 on 2022/09/16.
//

import RxSwift
import UIKit

protocol NetworkInteractable {
    func fetchRepositories(query: String) -> Observable<CommonResponse<RepoSearchResponse>>
}

class NetworkInteractor: NetworkInteractable {

    let networkService: NetworkService<GithubSearcherAPI>
    
    init(networkService: NetworkService<GithubSearcherAPI>) {
        self.networkService = networkService
    }
    
    func fetchRepositories(query: String) -> Observable<CommonResponse<RepoSearchResponse>> {
        networkService.request(to: .searchRepositories(query: query), decode: RepoSearchResponse.self)
    }
    
}
