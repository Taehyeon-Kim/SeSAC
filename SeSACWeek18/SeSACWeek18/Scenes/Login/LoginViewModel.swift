//
//  LoginViewModel.swift
//  SeSACWeek18
//
//  Created by taekki on 2022/11/02.
//

import Foundation

import RxCocoa
import RxSwift

final class LoginViewModel: ViewModelType {
    
    private let disposeBag = DisposeBag()
    
    // Private property
    private let result = PublishRelay<APIService.LoginResponse>()
    private let error = PublishRelay<String>()
    
    struct Input {
        let emailText: ControlProperty<String?>
        let passwordText: ControlProperty<String?>
        let loginButtonTap: ControlEvent<Void>
    }
    
    struct Output {
        let isEnabled: Observable<Bool>
        let doLogin: Observable<Void?>
        let result: PublishRelay<APIService.LoginResponse>
        let error: PublishRelay<String>
    }
    
    // https://velog.io/@horeng2/Swift-RxSwift-map-flatMap%EC%9D%98-%EC%B0%A8%EC%9D%B4%EC%A0%90%EA%B3%BC-%EC%9A%A9%EB%8F%84
    func transform(input: Input) -> Output {
        let credential = Observable.combineLatest(
            input.emailText.orEmpty.asObservable(),
            input.passwordText.orEmpty.asObservable())
        let isEnabled = credential.map { $0.count > 6 && $1.count > 6 }
        
        // 통신을 map 부분에서 진행한다.
        let result = input.loginButtonTap
            .asObservable()
            .withLatestFrom(credential)
            .map { [weak self] email, password in self?.attemptLogin(email: email, password: password) }

        return Output(isEnabled: isEnabled, doLogin: result, result: self.result, error: self.error)
    }
    
    func attemptLogin(email: String, password: String) {
        // <의식의 흐름>
        // Single로 반환이 되는데
        // 이 때, 성공/실패 이벤트가 방출된다.
        // 이벤트를 방출하고 난 뒤에는 dispose된다.
        // 한 번의 Cycle이 도는 것인데, 그럼 이 때 종료되고 구독이 취소되면
        // 주기적으로 통신을 요청해야하는 경우에는 어떻게 해야하지? -> 버튼을 누를 때마다 해당 통신을 진행하고
        // 각 부분에서 나오는 값을 새로운 옵저버블(output)에 담아서 처리해주면 되지 않을까라는 생각이 든다.
        APIService.shared.login(email: email, password: password)
            .subscribe { value in
                self.result.accept(value)
            } onFailure: { error in
                self.error.accept(error.localizedDescription)
            }.disposed(by: disposeBag)
    }
}
