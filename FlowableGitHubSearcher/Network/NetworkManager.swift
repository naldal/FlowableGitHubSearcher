//
//  NetworkManager.swift
//  FlowableGitHubSearcher
//
//  Created by 송하민 on 2022/09/16.
//

import Foundation
import Moya
import Alamofire
import RxSwift

enum GithubSearcherAPI {
    case searchRepositories(query: String)
    case getRepository
    case searchUserInformations
}

extension GithubSearcherAPI: TargetType {
    var baseURL: URL {
        return URL(string: Constants.baseURL)!
    }
    
    var path: String {
        switch self {
        case .searchRepositories:
            return Constants.Path.searchRepositoriesPath
        case .getRepository:
            return ""
        case .searchUserInformations:
            return ""
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .searchRepositories, .getRepository, .searchUserInformations:
            return Method.get
        }
    }
    
    var task: Task {
        switch self {
        case let .searchRepositories(query):
            let params: [String: Any] = ["q": query,
                                         "per_page": 20,
                                         "page": 1]
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
            
        case .getRepository:
            return .requestPlain
        case .searchUserInformations:
            return .requestPlain
    
        }
    }
    
    var headers: [String : String]? {
        var httpHeaders: [String: String]
        httpHeaders = ["Accept": Constants.githubAPI.acceptType,
                       "Authorization": "ghp_"+Constants.githubAPI.authToken]
        return httpHeaders
    }
    
    
}
