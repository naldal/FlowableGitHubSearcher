//
//  RepositoryInformation.swift
//  FlowableGitHubSearcher
//
//  Created by 송하민 on 2022/09/19.
//

import Foundation

// MARK: - Welcome
struct RepositoryInformation: Codable {
    let id: Int
    let name: String
    let welcomePrivate: Bool
    let htmlURL: String
    let welcomeDescription: String
    let url: String
    let createdAt, updatedAt, pushedAt: Date
    let gitURL: String
    let homepage: String
    let stargazersCount: Int
    let language: String
    let forksCount, openIssuesCount: Int
    let topics: [String]
    let openIssues, subscribersCount: Int

    enum CodingKeys: String, CodingKey {
        case id, name
        case welcomePrivate = "private"
        case htmlURL = "html_url"
        case welcomeDescription = "description"
        case url
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case pushedAt = "pushed_at"
        case gitURL = "git_url"
        case homepage
        case stargazersCount = "stargazers_count"
        case language
        case forksCount = "forks_count"
        case openIssuesCount = "open_issues_count"
        case topics
        case openIssues = "open_issues"
        case subscribersCount = "subscribers_count"
    }
}
