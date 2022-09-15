//
//  CommonResponse.swift
//  FlowableGitHubSearcher
//
//  Created by 송하민 on 2022/09/15.
//

import Foundation
import RxSwift

public struct CommonResponse<T: Codable>: Codable {
    /// 각 API의 모델이 담길 객체
    public var data: T?
    /// 에러 발생시 에러 코드와 메시지가 담길 객체
    public var error: ErrorResponse?
}

public struct ErrorResponse: Codable {
    let message: String
    let errors: [ErrorField]
    let documentationURL: String

    enum CodingKeys: String, CodingKey {
        case message, errors
        case documentationURL = "documentation_url"
    }
}

// MARK: - ErrorField

struct ErrorField: Codable {
    let resource, field, code: String
}
