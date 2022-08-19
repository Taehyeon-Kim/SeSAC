//
//  BaseView.swift
//  SeSACWeek7+Diary
//
//  Created by taekki on 2022/08/19.
//

import UIKit

class BaseView: UIView {

    // 코드 베이스 일때만 실행
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
        setConstraints()
    }
    
    // 실패 가능한 이니셜라이저
    // 코드베이스의 경우 호출이 안되는 이니셜라이저
    // nil 값이 들어올 수 있음
    // 혹시나 nil이 들어오는 경우를 대비하기 위해 옵셔널 형태로 작성
    // 실패 가능한 이니셜라이저로 작성
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented") // 런타임 오류
    }
    
    func configureUI() {}
    func setConstraints() {}
}

// required initializer
protocol example {
    init(name: String)
}

class Mobile: example {
    let name: String
    
    required init(name: String) {
        self.name = name
    }
}

class Apple: Mobile {
    let wwdc: String
    
    init(wwdc: String) {
        self.wwdc = wwdc
        
        super.init(name: "모바일")
    }
    
    required convenience init(name: String) {
        self.init(wwdc: "wwdc")
    }
}

let a = Apple(wwdc: "애플")
