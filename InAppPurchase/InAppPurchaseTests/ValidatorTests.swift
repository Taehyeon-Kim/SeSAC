//
//  ValidatorTests.swift
//  InAppPurchaseTests
//
//  Created by taekki on 2022/11/30.
//

import XCTest
@testable import InAppPurchase

final class ValidatorTests: XCTestCase {
    
    var sut: Validator!

    override func setUpWithError() throws {
        sut = Validator()
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    // ui가 수정된다고 해도 테스트 코드가 수정될일은 없음 -> 독립적임
    // 기능/로직 - ui의 분리
    // 비즈니스 로직의 분리 -(비슷한 맥락)- 테스터블한 코드 작성
    func testValidator_validEmail_returnTrue() throws {
        let user = User(email: "taa@taa.com", password: "1234", check: "1234")
        let valid = sut.isValid(email: user.email)
        XCTAssertTrue(valid)
    }
}
