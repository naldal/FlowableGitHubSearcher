//
//  Observable+Extensions.swift
//  FlowableGitHubSearcher
//
//  Created by 송하민 on 2022/09/15.
//

import RxCocoa
import RxSwift
import UIKit

extension ObservableType {
    
    func ignoreAll() -> Observable<Void> {
        return map { _ in }
    }
    
    func asDriverOnErrorJustComplete() -> Driver<Element> {
     return asDriver { _ in
        Driver.empty()
      }
    }
}

extension Observable where Element: Equatable {
    
    func ignore(value: Element) -> Observable<Element> {
        filter { value != $0 }
    }
}
