//
//  ValidationViewModel.swift
//  SeSACWeek1617
//
//  Created by taekki on 2022/10/27.
//

import Foundation
import RxSwift
import RxCocoa

struct ValidationViewModel {
    
    struct Input {
        let text: ControlProperty<String?>
        let stepButtonDidTap: ControlEvent<Void>
    }
    
    struct Output {
        let validText: Driver<String>
        let validation: Observable<Bool>
        let stepButtonDidTap: ControlEvent<Void>
    }
    
    func transform(input: Input) -> Output {
        let validText = BehaviorRelay(value: "닉네임은 최소 8자 이상 필요해요").asDriver()
        
        // 데이터스트림을 바꿔가는 작업도 ViewModel로 숨겨놓음
        let validation = input.text
            .orEmpty
            .map { $0.count >= 8 }
            .share()
        
        return Output(
            validText: validText,
            validation: validation,
            stepButtonDidTap: input.stepButtonDidTap
        )
    }
}
