//
//  Steps.swift
//  FlowableWhereAmI
//
//  Created by 송하민 on 2022/09/15.
//

import RxFlow

enum FlowSteps: Step {
    /// Root 화면으로 이동
    case basicViewControllerIsRequired
    /// 검색화면 bind
    case mainSearchIsRequired
}
