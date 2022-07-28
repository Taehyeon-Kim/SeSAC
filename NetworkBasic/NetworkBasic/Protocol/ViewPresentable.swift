//
//  ViewPresentable.swift
//  NetworkBasic
//
//  Created by taekki on 2022/07/28.
//

import UIKit

/*
 - ~ Protocol
 - ~ Delegate
 */

// 프로토콜은 규약이자 필요한 요소를 명세만 할 뿐, 실질적인 구현부는 작성하지 않는다.
// 실질적인 구현은 프로토콜을 채택, 준수한 타입이 구현한다.
// 클래스, 구조체, 익스텐션, 열거형 ...
// 클래스는 단일 상속만 가능하지만, 프로토콜은 채택 갯수에 제한이 없다.


// 클래스는 1개의 클래스만 상속만 가능하지만, 프로토콜은 여러개를 채택할 수 있는 장점이 있다.
// 모든 곳에서 사용되는 것이 아닌데 부모 클래스 안에 함수를 구현해놓고 사용하는 것은 비효율적이다.
// @objc optional attributor를 붙여야 함 > 선택적 요청(Optional Requirement)
// 프로토콜 프로퍼티, 프로토콜 메서드

// 프로토콜 프로퍼티: 연산 프로퍼티로 쓰든 저장 프로퍼티로 쓰든 상관하지 않는다.
// 명세하지 않기에, 구현을 할 때 프로퍼티를 저장 프로퍼티로 쓸 수도 있고, 연산 프로퍼티로 사용할 수도 있다.
// 무조건 var로 선언해야 한다.

// 만약 get만 명시했다면, get 기능만 최소한 구현되어 있으면 된다. 플러스 알파(set)가 붙어도 상관하지 않는다.
// ㄴ 그래서 필요하다면 set도 구현해도 괜찮다. (저장 프로퍼티를 썼을 때도 문제가 없다.)

@objc
protocol ViewPresentable {
    var navigationTitleString: String { get set }
    var backgroundColor: UIColor { get }
    static var identifier: String { get }
    
    func configureView()
    @objc optional func configureLabel()
    @objc optional func configureTextField()
}

/*
 ex. 테이블뷰
 */

@objc
protocol JackTableViewProtocol {
    func numberOfRowsInSection() -> Int
    func cellForRowAt(indexPath: IndexPath) -> UITableViewCell
}
