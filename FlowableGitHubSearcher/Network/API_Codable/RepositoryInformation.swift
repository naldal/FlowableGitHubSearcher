//
//  RepositoryInformation.swift
//  FlowableGitHubSearcher
//
//  Created by 송하민 on 2022/09/19.
//

import Foundation

// MARK: - Welcome
struct RepositoryInformation: Codable {
    let name: String
    let htmlURL: String
    let welcomeDescription: String?
    let createdAt: String
    let updatedAt: String
    let homepage: String?
    let stargazersCount: Int
    let language: String?
    let forksCount, openIssuesCount: Int
    let topics: [String?]
    let subscribersCount: Int

    enum CodingKeys: String, CodingKey {
        case name
        case htmlURL = "html_url"
        case welcomeDescription = "description"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case homepage
        case stargazersCount = "stargazers_count"
        case language
        case forksCount = "forks_count"
        case openIssuesCount = "open_issues_count"
        case topics
        case subscribersCount = "subscribers_count"
    }
}
