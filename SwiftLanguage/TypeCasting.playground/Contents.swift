import UIKit

/*
 TypeCasting
 - 형변환 => 타입캐스팅/타입변환 (둘은 엄밀히 다르다.)
 - 타입캐스팅 => 인스턴스의 타입을 확인하거나 인스턴스 자신의 타입을 다른 타입의 인스턴스인 것처럼 사용할 때 활용되는 개념
 */

let a = 3
let value = String(a) // 초기화 구문 - 이니셜라이저 구문을 통해 새롭게 인스턴스를 생성한 것 = 형변환 (타입이 바뀌는 것)

type(of: a)
type(of: value)

// ex. 애플 구글 모바일

class Mobile {
    
    let name: String
    
    var introduce: String {
        return "\(name) 입니다."
    }
    
    init(name: String) {
        self.name = name
    }
}

// Google, Apple이 부모 클래스 Mobile을 상속받고 있음
// 부모의 이니셜라이저를 사용할 수 있음
class Google: Mobile {
    
}

class Apple: Mobile {
    let wwdc = "WWDC22"
}

let mobile = Mobile(name: "phone")
let apple = Apple(name: "apple")
let google = Google(name: "google")

// is : 어떤 클래스의 인스턴스 타입인지 확인, 데이터 타입인지 확인
// ex. Local Notification
// - 특정 화면으로 이동 시
// - 화면에 대한 체크를 할 때 is 사용

mobile is Mobile
mobile is Apple
mobile is Google

apple is Mobile // 부모의 것을 상속받았기 때문에 Mobile 타입도 true
apple is Apple
apple is Google


// Type Cast Operator: as (업캐스팅) / as?, as! (다운캐스팅)
// 타입 캐스팅은 런타임 상황에서 확인 가능

// 업캐스팅: 부모클래스 타입인 걸 알 경우, 항상 성공하는 걸 아는 경우

let iphone: Mobile = Apple(name: "APPLE")
iphone.introduce // Mobile 타입이기 때문에 Mobile의 프로퍼티를 사용할 수 있다.

// 타입은 Mobile이다.
// Apple의 프로퍼티를 사용하고 싶다.
// 다운캐스팅하겠다.

// as? 옵셔널 반환 타입 => 실패한 경우 nil 반환
// as! 옵셔널 X => 실패한 경우 무조건 런타임 오류 발생

if let value = iphone as? Apple {
    print(value)
} else {
    print("타입 캐스팅 실패")
}

if let value = iphone as? Google {
    print(value)
}

//iphone as! Google // 런타임 오류 발생
iphone as? Google
apple as Mobile


// Any vs AnyObject
// - Any를 사용하면 결국 타입 캐스팅이라는 귀찮은 과정을 거친다.
// Any(모든 타입의 인스턴스를 담을 수 있음) vs AnyObject(클래스의 인스턴스만 담을 수 있음)
// 컴파일 시점에선 어떤 타입인지 알 수 없고, 런타임 시점에 타입이 결정된다.

var somethings: [Any] = []

somethings.append(0)
somethings.append(true)
somethings.append("something")
somethings.append(mobile)

print(somethings)
print(somethings[1])

// Any 사용 시 타입 캐스팅의 과정을 거칠 수 밖에 없다.
let example = somethings[1]

if var element = example as? String {
//    print(element.toggle())
    print(element)
} else {
    print("Bool 아님")
}
