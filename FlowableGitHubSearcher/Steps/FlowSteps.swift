//
//  Steps.swift
//  FlowableWhereAmI
//
//  Created by 송하민 on 2022/09/15.
//

import RxFlow

enum FlowSteps: Step {
    
    /// 메인검색 화면으로 이동
    case mainSearchIsRequired
    /// 상세 레포지토리 화면으로 이동
    case detailRepositoryInformationIsRequired(repoName: String, ownerName: String)
}
