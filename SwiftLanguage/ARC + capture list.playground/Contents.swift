import UIKit

class User {
    var nickname = "JACK"
    
    lazy var introduce: () -> String = { [weak self] in
        return "저는 \(String(describing: self?.nickname))입니다."    // self로 접근하기 때문에 순환 참조 발생
    }

    init() {
        print("User init")
    }
    
    deinit {
        print("User deinit")
    }
}

var user: User? = User()
user?.introduce()       // RC + 1
user = nil


func myClosure() {
    
    var number = 0
    print("1: \(number)")
    
    let closure: () -> Void = { [number] in
        print("closure: \(number)")
    }
    
    closure()
    
    number = 100
    print("2: \(number)")
    
    closure()
}

myClosure()
