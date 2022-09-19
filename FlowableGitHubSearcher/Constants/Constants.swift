//
//  Constants.swift
//  FlowableGitHubSearcher
//
//  Created by 송하민 on 2022/09/16.
//

import Foundation

class Constants {
    
    static let baseURL = "https://api.github.com"
    
    struct githubAPI {
        static let acceptType = "application/vnd.github+json"
        static let authToken = "dbTByHU2tJ1Ittw74q1XBVThu5LZJj2qnzXr"
    }
    
    struct Path {
        static let searchRepositoriesPath = "/search/repositories"
        static let searchRepositoryPath = "/repos"
    }
    
    struct CellIdentifier {
        static let repositoryInformationCell = "repositoryInformationCell"
    }
}
