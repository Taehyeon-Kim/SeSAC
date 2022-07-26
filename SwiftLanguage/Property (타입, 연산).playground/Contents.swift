//: [Previous](@previous)

import UIKit

// 인스턴스 프로퍼티는 각각 다른 값을 사용할 수 있다.
// 타입 저장 프로퍼티는 오직 하나의 값만 사용할 수 있다. (let이 아닌 var를 사용하면 값 또한 일괄 수정이 가능하다.
struct User {
    static var originalName = "진짜 이름"   // 타입 저장 프로퍼티
    var nickname = "고래밥"                // 인스턴스 저장 프로퍼티
}

var user1 = User()
user1.nickname = "올라프"
User.originalName = "리JACK"
print(user1.nickname, User.originalName)

var user2 = User()
print(user2.nickname, User.originalName)

var user3 = User()
print(user3.nickname, User.originalName)

var user4 = User()
print(user4.nickname, User.originalName)

/*
 연산 프로퍼티(인스턴스 연산 프로퍼티 / 타입 프로퍼티)
 */

struct BMI {
    var nickname: String
    var weight: Double
    var height: Double
    
    // 저장 프로퍼티는 메모리를 차지하고 있음
    // 연산 프로퍼티는 메모리를 차지하고 있지 않음, 저장 프로퍼티를 활용해서 원하는 값을 반환하는 용도로 주로 사용
    // 자기 자신이 가지고 있는 프로퍼티(저장 프로퍼티)를 활용하는 경우라면 연산 프로퍼티를 사용하는 것이 나아보임
    // 실제 연산 시에 메모리에 올라감
    // 저장 프로퍼티 값에 따라서 항상 연산 프로퍼티는 값이 변경되기 때문에 var로 선언되어야 한다.
    // get만 쓰는 것은 읽기 전용(read-only) 프로퍼티가 맞음. (위의 문장 때문에 var를 사용해야 한다.)
    
    // 타입 연산 프로퍼티는 초기화가 안되어있으면 에러가 발생한다.(항상 초기값을 가지고 있어야 함.)
    // 초기화는 인스턴스와 관련이 있음 - 따라서 타입 / 타입 연산 프로퍼티와 무관
    
    var BMIResult: String {
        get {
            let BMIValue = (weight * weight) / height
            let BMIStatus = BMIValue < 18.5 ? "저체중" : "정상 이상"
            return "\(nickname)님의 BMI 지수는 \(BMIValue)로 \(BMIStatus)입니다!"
        }
        set {
            nickname = newValue // newValue는 원시 데이터 하나만 받을 수 있다. 단, 여러 저장 프로퍼티에 영향은 줄 수 있다.
        }
    }
    
    // 연산 프로퍼티와 매우 유사
    func BMIResultFunction() -> String {
        let BMIValue = (weight * weight) / height
        let BMIStatus = BMIValue < 18.5 ? "저체중" : "정상 이상"
        return "\(nickname)님의 BMI 지수는 \(BMIValue)로 \(BMIStatus)입니다!"
    }
    
    // 이런 경우는 연산 프로퍼티의 목적성에 부합할까? 고민
    var sample: String {
        return "\(Int.random(in: 1...100))"
    }
}

var bmi = BMI(nickname: "고래밥", weight: 50, height: 180)
print(bmi.BMIResult)

bmi.BMIResult = "올라프"
print(bmi.BMIResult)

class FoodRestaurant {
    let name = "잭치킨"
    var totalOrderCount = 10
    
    var nowOrder: Int {
        // get만 쓰는 경우 생략 가능
        get {
            print("get")
            return totalOrderCount * 5000
        }
        set {
            print("set")
            totalOrderCount += newValue // 기본 파라미터 명이 newValue, 변경 가능
        }
    }
}

let food = FoodRestaurant()
print(food.nowOrder)

//food.totalOrderCount += 5
//food.totalOrderCount += 20
//food.totalOrderCount += 100

food.nowOrder = 5
food.nowOrder = 20
food.nowOrder = 100  // set 동작

print(food.nowOrder) // get 동작

/*
 label.text = "hello"   // set
 print(label.text)      // get
 
 sampleButton.setTitle()
 sampleButton.titleLabel?.text  // get set 프로퍼티
 sampleButton.currentTitle      // get 프로퍼티 (currentTitle is a get-only property)
 */

// let button = UIButton()
// button.setTitle("hello", for: .normal)
// button.titleLabel?.text
// button.currentTitle

// 읽기 전용 프로퍼티로 사용하려면 계산 프로퍼티로 사용해야 한다? private(set)과 차이는?

// 열거형은 타입 자체 (값 타입) // > 열거형은 인스턴스 생성이 불가능하다. > 따라서 초기화 구문이 없다.
// 인스턴스 생성을 통해서 접근할 수 있는 인스턴스 저장 프로퍼티가 사용 불가하다.
// 연산 프로퍼티는 왜 사용이 가능할까?
// - 메모리의 관점 + 열거형은 컴파일 타임에 확정되어야 한다! > 인스턴스 연산 프로퍼티는 열거형에서 사용할 수 있다.
// 타입 저장 프로퍼티 => 열거형에서 사용 가능!

// 열거형은 빌드되는 순간에 모두 메모리에 올라가 있음
enum ViewType {
    case start
    case change
    
    // var nickname: String = "고래밥" (X - 동작 불가)
    
    // 사용하지 않으면 메모리에 올라가지 않음
    // 열거형은 컴파일 상에서 에러를 탐지한다.
    // 컴파일 상에서 문제가 없기 때문에 사용할 수 있음
    var nickname: String {
        return "aa"
    }
    
    // 타입 프로퍼티는 인스턴스 생성 없이 접근 가능
    static var title = "시작하기"
}

print(ViewType.title)

// 타입 프로퍼티는 인스턴스랑 상관없이 접근 가능 따라서 열거형에서 타입 저장 프로퍼티, 타입 연산 프로퍼티는 모두 사용 가능
// 인스턴스 저장 프로퍼티는 메모리에 올라감, 값이 달라질 수 있음, 열거형에서 사용 불가, 초기화 구문을 만들 수 없기 때문

//: [Next](@next)
