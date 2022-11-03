//
//  ProfileViewController.swift
//  SeSACWeek18
//
//  Created by taekki on 2022/11/02.
//

import UIKit

import RxSwift
import SnapKit
import Then

final class ProfileViewController: BaseViewController, Bindable {
    
    typealias ViewModelType = ProfileViewModel
    
    private let label = UILabel()
    
    let viewModel: ViewModelType = ProfileViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let phone = Phone()
        print(phone[2])
        
        bind()
        checkCOW()
    }
    
    override func attributes() {
        view.backgroundColor = .systemBackground
    }
    
    override func hierarchy() {
        view.addSubview(label)
    }
    
    override func constraints() {
        label.snp.makeConstraints {
            $0.top.directionalHorizontalEdges.equalTo(view.safeAreaLayoutGuide).offset(30)
        }
    }
}

extension ProfileViewController {
    
    func bind() {
        viewModel.profile
            .withUnretained(self)
            .subscribe { vc, userResponse in
                vc.label.text = userResponse.user.email
            } onError: { error in
                print(error.localizedDescription)
            }.disposed(by: disposeBag)
        
        viewModel.getProfile()
    }
    
    func checkCOW() {
        checkString()
        checkArray()
    }
    
    func checkArray() {
        var array = Array(repeating: "A", count: 100)
        address(&array)
        
        var newArray = array // 실제로 복사 안함, 원본을 공유하고 있음
        address(&newArray)   // array가 구조체인데 참조타입처럼 동작
        
        // 복사했다고 해서 바로 독립적인 메모리 공간을 주는 것보다
        // 실제로 값의 수정이 일어났을 때 메모리 공간을 제공하자.
        // 그전까지는 같은 메모리 주소를 바라보고 있음
        // ㄴ 실제 객체의 수정이나 삭제가 일어날때
        // ㄴ * Collection 타입(Array, Dictionary, Set)에 대해서 Copy On Write로 성능을 최적화하고 있음
        
        newArray[0] = "B"
        
        print(array[safe: 99])
        print(array[safe: 199])
        
        address(&array)
        address(&newArray)
    }
    func checkString() {
        // String -> Struct -> Value Type -> 객체가 서로 다른 메모리 주소를 가리킴
        
        var test = "ttt"
        address(&test)  // inout 매개변수
        
        var test2 = test
        address(&test2)
        
        test2 = "sesac"
        
        address(&test)
        address(&test2)
    }
    
    func address(_ value: UnsafeRawPointer) {
        let address = String(format: "%p", Int(bitPattern: value))   // pointer 추적
        print(address)
    }
}
