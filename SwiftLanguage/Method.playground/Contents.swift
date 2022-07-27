import UIKit

// 메서드 : 타입 메서드 & 인스턴스 메서듶

struct Coffee {
    static var name = "인스턴스"
    static var shot = 2
    var price = 4900
    
    // 1. static 함수에서는 인스턴스에 접근할 수 없음
    mutating func plusShot() {
//        shot += 1
        price += 300
    }
  
    // Struct 에서는 class func을 사용할 수 없다. 상속이 안되기 때문에 당연함
//    class func minusShot() {
//        shot -= 1
//    }
}

//class Latte: Coffee {
//    override class func minusShot() { // 슈퍼클래스의 타입 메서드를 재정의해서 쓰고 싶다면 class!
//
//    }
//}
