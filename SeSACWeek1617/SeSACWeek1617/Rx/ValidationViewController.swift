//
//  ValidationViewController.swift
//  SeSACWeek1617
//
//  Created by taekki on 2022/10/27.
//

import UIKit

import RxCocoa
import RxSwift

final class ValidationViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var validationLabel: UILabel!
    @IBOutlet weak var stepButton: UIButton!
    
    private let viewModel = ValidationViewModel()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bind()
        observableVSSubject()
    }
}

extension ValidationViewController {
    
    private func bind() {
        
        let validation = nameTextField.rx.text // String?
            .orEmpty // String
            .map { $0.count >= 8 }  // Bool
            .share()
        
        validation
            .bind(to: stepButton.rx.isEnabled, validationLabel.rx.isHidden) // next 이벤트만 방출(물론 subscribe 사용해도 됨. 그런데 목적상 맞는 것은 bind, 가변 매개변수를 받을 수 있음.
            .disposed(by: disposeBag)
        
        validation
            .withUnretained(self)
            .bind { vc, value in
                vc.stepButton.backgroundColor = value ? .systemPink : .lightGray
            }
            .disposed(by: disposeBag)
        
        stepButton.rx.tap
            .bind { _ in
                print("SHOW ALERT")
            }
            .disposed(by: disposeBag)
        
        viewModel.validText
            .asDriver() // Driver Traits로 변경, 특화된 옵저버블 / drive에서는 에러방출이 불가하기 때문에 윗단에서 에러핸들링이 필요함.
            .drive(validationLabel.rx.text)
            .disposed(by: disposeBag)
    }
    
    private func observableVSSubject() {
        
        // tap에 관한 이벤트는 error, completed 될 수 없음
        let testA = stepButton.rx.tap
            .map { "안녕하세요" }
            .asDriver(onErrorJustReturn: "")
            // .share()
        
        testA
            .drive(validationLabel.rx.text)
            .disposed(by: disposeBag)
        
        testA
            .drive(nameTextField.rx.text)
            .disposed(by: disposeBag)
        
        testA
            .drive(stepButton.rx.title())
            .disposed(by: disposeBag)
        
        // 옵저버블과 옵저버가 일대일 관계
        // 리소스를 각각 사용하고 있다.
        let sampleInt = Observable<Int>.create { observer in
            observer.onNext(Int.random(in: 0..<100))
            return Disposables.create()
        }
        
        sampleInt.subscribe { value in
            print("sampleInt: \(value)")
        }
        .disposed(by: disposeBag)
        
        sampleInt.subscribe { value in
            print("sampleInt: \(value)")
        }
        .disposed(by: disposeBag)
        
        sampleInt.subscribe { value in
            print("sampleInt: \(value)")
        }
        .disposed(by: disposeBag)
        
        // 스트림을 공유한다.
        let subjectInt = BehaviorSubject(value: 0)
        subjectInt.onNext(Int.random(in: 1...100))
        
        subjectInt.subscribe { value in
            print("subjectInt: \(value)")
        }
        .disposed(by: disposeBag)
        
        subjectInt.subscribe { value in
            print("subjectInt: \(value)")
        }
        .disposed(by: disposeBag)
        
        subjectInt.subscribe { value in
            print("subjectInt: \(value)")
        }
        .disposed(by: disposeBag)
    }
}
