//
//  ValidationViewModel.swift
//  SeSACWeek1617
//
//  Created by taekki on 2022/10/27.
//

import Foundation
import RxSwift
import RxCocoa

final class ValidationViewModel {

    // 절대적으로 변경되지 않을 값이라면 Rx를 사용하지 않아도 됨.
    // 실시간으로 변경될 가능성이 있다면 Rx 적합
    let validText = BehaviorRelay(value: "닉네임은 최소 8자 이상 필요해요")
}
