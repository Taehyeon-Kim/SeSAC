//
//  APIServiceTests.swift
//  InAppPurchaseTests
//
//  Created by taekki on 2022/12/01.
//

import XCTest
@testable import InAppPurchase

final class APIServiceTests: XCTestCase {
    
    var sut: APIService!

    override func setUpWithError() throws {
        sut = APIService()
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    func test_callAPIService_return() throws {
        
        sut.number = 100
        
        sut.callRequest { value in
            XCTAssertLessThanOrEqual(value, 45)
            XCTAssertGreaterThanOrEqual(value, 1)
        }
    }
    
    /*
     네트워크: 아이폰 네트워크 응답x, api 서버 점검, api 지연
     효율적/속도/같은 조건에서 테스트 해야 하는데 그 조건이 깨짐
     테스트 대상이 외부 격리 X - 예측 불가능한 상황을 만들면 안됨
     => 실제 네트워크 동작이 되는 것처럼 보이게 별개의 객체를 만듬
     => 테스트 더블(Test Double) 테스트 코드랑 상호작용 할 수 있는 가짜 객체 생성(ex. 스턴트맨)
     ex. dummy, mock, fake, stub, spy...
     
     F.I.R.S.T 원칙
     */
    
    // 비동기: expectation, fulfill, wait
    // 테스트는 비동기를 신경쓰지 않는다.
    // 핸들러가 기다리지 않는다.
    // 네트워크쪽 처리시에 특히 주의
    func test_APILottoResponse_AsyncCover() throws {
        /// 1
        print("testExample Start")
        let promise = expectation(description: "waiting lotto number, completion handler invoked")
        
        sut.number = 44
        
        /// 3
        sut.callRequest { value in
            XCTAssertLessThanOrEqual(value, 45)
            XCTAssertGreaterThanOrEqual(value, 1)
            print("call request")
            
            /// expectation으로 정의된 테스트 조건을 충족(바로 종료)
            /// 시간이 지나지 않았더라도 조건 충족 후 종료
            promise.fulfill()
        }
        
        /// 2
        print("testExample End")
        
        wait(for: [promise], timeout: 5) // 5초 동안 기다림 (응답이 올때까지 기다림)
    }
}
