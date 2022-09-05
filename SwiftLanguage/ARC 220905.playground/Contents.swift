import UIKit

class Guild {
    var name: String
    weak var owner: User? // 이 길드장은 누구?
    
    init(name: String) {
        self.name = name
        print("Guild init")
    }
    
    deinit {
        print("Guild deinit")
    }
}

class User {
    var name: String
    var guild: Guild? // 고래밥이 새싹 길드에 있다면?
    
    init(name: String) {
        self.name = name
        print("User init")
    }
    
    deinit {
        print("User deinit")
    }
}

var user: User? = User(name: "고래밥") // User: RC 1
// 메모리에 올라간 상태 = init
// 클래스 -> 참조 타입 -> RC + 1
var guild: Guild? = Guild(name: "SeSAC") // Guild: RC 1

user?.guild = guild // Guild: RC 2
guild?.owner = user // User: RC 2(weak -> 1) owner에 대한 RC가 증가되지 않음 (참조를 하더라도!)

//// 순환참조 중인 요소를 먼저 nil, 인스턴스의 참조 관계를 먼저 해제한다.
//user?.guild = nil
//guild?.owner = nil

// 더이상 필요없어!
// 메모리에서 내려가
//guild = nil // Guild: RC 1
user = nil // User: RC 0 -> Guild: RC 0


// ====================================================

/*
 weak 일때는 문제가 생기지 않는다. -> weak로 참조하고 있는 주소까지 nil로 반영해줌
 unowned 일때는 문제 생김 -> 메모리 주소는 남아있음 / 주소 자체는 남아있게 되는데, 접근할 수 있는 값이 없어서 실제 접근하려고 할 때 에러가 발생
 */
guild?.owner
// user?.guild
