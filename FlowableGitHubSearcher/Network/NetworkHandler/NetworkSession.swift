//
//  NetworkSession.swift
//  FlowableGitHubSearcher
//
//  Created by 송하민 on 2022/09/15.
//

import Alamofire
import Foundation
import RxSwift

/// Session과 네트워크 연결 여부를 관장
public class AlamofireSession: Alamofire.Session {
    
    public static let configuration: Alamofire.Session = {
        let configuration = URLSessionConfiguration.default
        configuration.headers = HTTPHeaders.default
        configuration.timeoutIntervalForRequest = 60
        configuration.timeoutIntervalForResource = 60
        configuration.requestCachePolicy = NSURLRequest.CachePolicy.useProtocolCachePolicy
        return Alamofire.Session(configuration: configuration)
    }()
}

public func networkEnable() -> Observable<Bool> {
    ReachabilityManager.shared.reach
}

// MARK: - ReachabilityManager

public class ReachabilityManager: NSObject {
    
    // MARK: - Properties
    
    /// singleton
    public static let shared = ReachabilityManager()
    
    let reachSubject = ReplaySubject<Bool>.create(bufferSize: 1)
    var reach: Observable<Bool> {
        reachSubject.asObservable()
            .do(onNext: { reachable in
                if !reachable {
                    // requestAPi 요청시 필수로 네트워크 여결 여부 확인, 필요시 이 부분에 noti를 걸어 BaseView등에서 Toast 처리 가능
                    print("testtest0")
                } else {
                    print("testtest1")
                }
            })
                }
    
    // MARK: - Initialize
    
    override private init() {
        super.init()
        
        NetworkReachabilityManager.default?.startListening(onUpdatePerforming: { status in
            let reachable = (status == .notReachable || status == .unknown) ? false : true
            self.reachSubject.onNext(reachable)
        })
    }
}

