//
//  InAppPurchaseTests.swift
//  InAppPurchaseTests
//
//  Created by taekki on 2022/11/29.
//

import XCTest
@testable import InAppPurchase

// UI와 직접적으로 연관되게 테스트가 진행되게 되면 이후 변동사항에 대해 대처가 어렵다.
// 기능에 대한 로직 분리가 필요하다는 것을 확인할 수 있는 부분이다.
final class InAppPurchaseTests: XCTestCase {
    
    var sut: LoginViewController! // system under test 테스트를 하고자하는 클래스를 정의할 때 사용

    override func setUpWithError() throws {
        sut = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController
        sut.loadViewIfNeeded()  // 스토리보드 및 @IBOutlet 작업시에 필요
    }

    override func tearDownWithError() throws {
        sut = nil // 테스트 시에 사용됐던 인스턴스가 다음 테스트에서 사용될 수 있기 때문에 초기화해주는 작업이 필요함
    }

    // 이메일 유효성 테스트
    func testLoginViewController_validEmail_returnTrue() throws {
        /// 테스트 객체: Given, Arrange
        sut.emailTextField.text = "taa@taa.com"
        /// 테스트 조건/행동: When, Act
        let valid = sut.isValidEmail()
        /// 테스트 결과: Then, Assert
        XCTAssertTrue(valid)
    }
    
    func testLoginViewController_invalidPassword_returnFalse() throws {
        sut.passwordTextField.text = "1234"
        let valid = sut.isValidPassword()
        XCTAssertFalse(valid)
    }
    
    func testLoginViewController_emailTextField_returnNil() throws {
        sut.emailTextField = nil
        let value = sut.emailTextField
        XCTAssertNil(value)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
}
