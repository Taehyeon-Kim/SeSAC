//
//  LoginUITest.swift
//  InAppPurchaseUITests
//
//  Created by taekki on 2022/11/29.
//

import XCTest
@testable import InAppPurchase
/// 1) import 해야하지 않음?
/// 2) 접근제어해야하지 않음? -> 접근제어를 설정하지 않아도 접근가능하도록 어노테이션 설정

final class LoginUITest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do 
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testLoginExample() {
        let app = XCUIApplication() // 앱의 실행과 종료
        app.launch()
        
        app.textFields["emailTextField"].tap()
        app.textFields["emailTextField"].typeText("taa@taa.com")

        app.textFields["passwordTextField"].tap()
        app.textFields["passwordTextField"].typeText("12341234")
        
        app.textFields["checkTextField"].tap()
        app.textFields["checkTextField"].typeText("12341234")
        
        app.staticTexts["로그인하기"].tap()
        
        let label = app.staticTexts.element(matching: .any, identifier: "descLabel").label
        XCTAssertEqual(label, "로그인 버튼을 눌렀습니다.")
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
