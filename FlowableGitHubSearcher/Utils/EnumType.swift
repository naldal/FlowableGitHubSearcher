//
//  EnumType.swift
//  FlowableGitHubSearcher
//
//  Created by 송하민 on 2022/09/16.
//

import Foundation

enum DefaultBranch: String, Codable {
    case main = "main"
    case master = "master"
}

enum TypeEnum: String, Codable {
    case user = "User"
}

enum Visibility: String, Codable {
    case visibilityPublic = "public"
}

