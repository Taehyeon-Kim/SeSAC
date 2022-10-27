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

    let validText = BehaviorRelay(value: "닉네임은 최소 8자 이상 필요해요") // UI에 한정할거야.
}
