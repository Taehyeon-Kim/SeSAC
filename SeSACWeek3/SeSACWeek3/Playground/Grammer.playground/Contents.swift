import UIKit

// 1. Optional Binding (옵셔널 바인딩)

// 1️⃣
// ex. 쇼핑 리스트 추가
var shoplist: String? = "신발 사기"
var shoplist2: String? = "모니터 사기"

if shoplist != nil && shoplist2 != nil {
    print("\(shoplist!), \(shoplist2!) 완료!")
} else {
    print("글자를 입력해주세요")
}

// 2️⃣
// 2글자 이상을 꼭 입력해야 한다면?

shoplist = nil

// ex. 잭플릭스 로그인화면
if let jack = shoplist, let value = shoplist2, (2...6).contains(jack.count) { // shoplist: optional string
    // jack: string type
    print("\(jack), \(value) 완료!")
} else {
    print("글자를 입력해주세요")
}

// 3️⃣
func optionalBindingFunction() {
    // nil이 나온다면 return 반환하고 함수 종료
    guard let jack = shoplist else {
        print("글자를 입력해주세요")
        return
    }
    
    print("\(jack) 완료!")
}

// 2. 인스턴스 프로퍼티 vs 타입 프로퍼티
// 인스턴스를 만들지 않고서는 내부에 있는 프로퍼티를 사용할 수 없음

class User {
    var nickname = "고래밥"                // 저장 프로퍼티(상수 저장 프로퍼티, 변수 저장 프로퍼티), 인스턴스 프로퍼티
    static var staticNickname = "고래밥"   // 저장 프로퍼티(상수 저장 프로퍼티, 변수 저장 프로퍼티), 인스턴스에서는 접근 불가, 메모리에서 한군데에 저장, 타입 프로퍼티
}

/*
 - 타입 프로퍼티는 초깃값을 무조건 넣어줘야 한다.
 */

let user = User() // 클래스 초기화, 인스턴스 생성
user.nickname

let user2 = User()
let user3 = User()

// 타입으로서 바로 접근 가능, 호출 시 메모리에 올라감, 인스턴스를 생성한다고 해서 초기화가 되지 않고 사용할 때 초기화가 된다.
// 한 번 메모리에 올라가면 앱을 실행하는 내내 올라가있고 내려오지 않는다.
User.staticNickname
