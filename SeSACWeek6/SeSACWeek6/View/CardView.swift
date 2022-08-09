//
//  CardView.swift
//  SeSACWeek6
//
//  Created by taekki on 2022/08/09.
//

import UIKit

/*
 Xml Interface Builder
 - 셀 파일을 제외하고 기본 생성을 할 수 없도록 애플에서 제한을 하고 있음
 - 그러나 생각보다 많이 사용하는 편
 
 1. UIView Custom Class => 여러가지 뷰를 하나에서 관리하기 편함
 2. File's owner => 자유도가 높고, 확장성이 큰 형태
 */

/*
 View
 - 인터페이스 빌더 UI 초기화 구문: required init?
    - 프로토콜 초기화 구문: required > 초기화 구문이 프로토콜로 명세되어 있음
    - required 키워드가 붙어있으면 프로토콜에서 온거다라고 인식해도 됨
 
 - 코드 UI 초기화 구문: override init
 */

protocol A {
    func example()
    init()
}

class CardView: UIView {
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var likeButton: UIButton!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        // XIB 파일 내에 여러 개의 뷰를 만들 수 있다. (권장은 하지 않음)
        // 그래서 first로 접근해서 몇 번째 뷰인지 체크한다.
        let view = UINib(nibName: "CardView", bundle: nil)
            .instantiate(withOwner: self).first as! UIView
        view.frame = bounds
        view.backgroundColor = .lightGray
        self.addSubview(view)
    }
}
