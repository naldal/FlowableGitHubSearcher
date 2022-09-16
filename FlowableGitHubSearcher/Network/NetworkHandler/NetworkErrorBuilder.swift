//
//  NetworkErrorBuilder.swift
//  FlowableGitHubSearcher
//
//  Created by 송하민 on 2022/09/15.
//

import Foundation
import Moya
import RxCocoa
import RxSwift

// MARK: - NetworkErrorBuilder

// 에러시 재시도 요청시킴
public enum NetworkErrorBuilder {
    
    private static let maxAttempts = 3 // 재시도 횟수
    
    public static let retryHandler: (Observable<Error>) -> Observable<Void> = {
        $0.enumerated().flatMap { attempt, error -> Observable<Void> in
            if attempt >= NetworkErrorBuilder.maxAttempts {
                return .error(error)
            } else if let moyaError = error as? MoyaError {
                guard let response = NetworkErrorBuilder.response(from: moyaError) else {
                    return .error(error)
                }
                
                log.info("== 재시도 횟수 \(attempt + 1)번 ==")
            }
            
            return Observable<Int>
                .timer(.milliseconds(1500), scheduler: MainScheduler.instance)
                .take(1)
                .ignoreAll()
        }
    }
}

// MARK: - Helper methods

extension NetworkErrorBuilder {
    
    private static func errorHandler(from response: Response) -> Observable<Void> {
        if (try? JSONDecoder().decode(CommonResponse<VoidModel>.self, from: response.data)) != nil {
            //에러 핸들링 부분 :toeken값, ExceptionStatus 체크 등
        }
        return .empty()
    }
    
    private static func response(from error: MoyaError) -> Response? {
        switch error {
        case let .statusCode(response):
            return response
        default:
            return nil
        }
    }
}


