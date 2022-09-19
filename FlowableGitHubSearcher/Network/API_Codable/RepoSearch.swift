//
//  RepoSearch.swift
//  FlowableGitHubSearcher
//
//  Created by 송하민 on 2022/09/16.
//

import Foundation

struct RepoSearchResponse: Codable {
    /// 레포 갯수
    let totalCount: Int
    /// Time-out 여부
    let incompleteResults: Bool
    /// 레포 배열
    let items: [RepoInfo]

    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case incompleteResults = "incomplete_results"
        case items
    }
}

// MARK: - RepoInfo

/// 레포지토리 객체
struct RepoInfo: Codable {
    /// 고유 아이디
    let id: Int
    /// 레포 이름
    let name: String
    /// 레포 Private 여부
    let itemPrivate: Bool
    /// 레포 소유자
    let owner: Owner
    /// 레포 URL
    let htmlURL: String
    /// 레포 Description
    let itemDescription: String?
    /// Star 수
    let stargazersCount: Int
    /// Watch 수
    let watchersCount: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case itemPrivate = "private"
        case owner
        case htmlURL = "html_url"
        case itemDescription = "description"
        case stargazersCount = "stargazers_count"
        case watchersCount = "watchers_count"
    }
}

// MARK: - Owner

/// 계정정보
struct Owner: Codable {
    let login: String
    let id: Int
    let avatarURL: String
    let gravatarID: String
    let url: String
    let htmlURL: String
    let gistsURL: String
    let starredURL: String
    let subscriptionsURL: String
    let organizationsURL: String
    let reposURL: String
    let eventsURL: String
    let receivedEventsURL: String
    let type: String
    let siteAdmin: Bool

    enum CodingKeys: String, CodingKey {
        case login, id
        case avatarURL = "avatar_url"
        case gravatarID = "gravatar_id"
        case url
        case htmlURL = "html_url"
        case gistsURL = "gists_url"
        case starredURL = "starred_url"
        case subscriptionsURL = "subscriptions_url"
        case organizationsURL = "organizations_url"
        case reposURL = "repos_url"
        case eventsURL = "events_url"
        case receivedEventsURL = "received_events_url"
        case type
        case siteAdmin = "site_admin"
        
    }
}
