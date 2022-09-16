//
//  NetworkService.swift
//  FlowableGitHubSearcher
//
//  Created by 송하민 on 2022/09/15.
//

import Alamofire
import RxMoya
import Moya
import RxCocoa
import RxSwift
import UIKit

public protocol Networkable {
    associatedtype Router
    
    func request<T: Decodable>(
        to router: Router,
        decode: T.Type
    ) -> Observable<CommonResponse<T>>
    
    func defaultRequest<T: Decodable>(
        to router: Router,
        decode: T.Type
    ) -> Observable<T>
}

public typealias VoidModel = String?

// MARK: - NetworkService

public class NetworkService<Router: TargetType> {
    
    /// Real
    public var provider: MoyaProvider<Router>
    
    /// Stub
    private var stubProvider: MoyaProvider<Router>
    
    private let dispatchQueue = DispatchQueue(label: "queue.network.parser")
    
    public init() {
        provider = MoyaProvider<Router>(
            endpointClosure: MoyaProvider.defaultEndpointMapping,
            requestClosure: MoyaProvider<Router>.defaultRequestMapping,
            stubClosure: MoyaProvider.neverStub,
            callbackQueue: nil,
            session: AlamofireSession.configuration,
            plugins: [NetworkLoggerPlugin()],
            trackInflights: false
        )
        
        stubProvider = MoyaProvider<Router>(
            stubClosure: MoyaProvider.immediatelyStub,
            plugins: [NetworkLoggerPlugin()]
        )
    }
}

// MARK: Networkable

extension NetworkService: Networkable {
    
    /// 실제 API Request 호출부
    public func request<T: Decodable>(
        to router: Router,
        decode: T.Type
    ) -> Observable<CommonResponse<T>> {
        let online = networkEnable()
        let request = provider.rx.request(router, callbackQueue: dispatchQueue)
        
        return online
            .ignore(value: false)
            .take(1)
            .flatMap { _ in
                request
                    .filterSuccessfulStatusCodes()
                    .do(onSuccess: {
                        do {
                            _ = try JSONDecoder().decode(CommonResponse<T>.self, from: $0.data)
                        } catch let jsonError {
                            log.debug("\(T.self): \(jsonError.localizedDescription) - \(jsonError)")
                        }
                    })
                        .map(CommonResponse<T>.self)
                        .retry(when: NetworkErrorBuilder.retryHandler)
                        .catch { error in
                            log.error("error localized ~> \(error.localizedDescription)")
                            return .just(NetworkErrorBuilder.common())
                        }
            }
    }
    
    /// Defaults Reqeust로 Observable<T> 리턴
    public func defaultRequest<T: Decodable>(
        to router: Router,
        decode: T.Type
    ) -> Observable<T> {
        let online = networkEnable()
        let request = provider.rx.request(router, callbackQueue: dispatchQueue)
        
        return online
            .ignore(value: false)
            .take(1)
            .flatMap { _ in
                request.map(T.self)
            }
    }
}

// MARK: - SampleData NetworkService

public extension NetworkService {
    
    /// Json SampleData를 사용하기 위한 Request
    func sampleDataRequest<T: Decodable>(
        to router: Router,
        decode: T.Type
    ) -> Observable<CommonResponse<T>> {
        stubProvider.rx
            .request(router, callbackQueue: dispatchQueue)
            .map(CommonResponse<T>.self)
            .asObservable()
    }
}

