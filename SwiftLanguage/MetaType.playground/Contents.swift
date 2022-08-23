import UIKit

/*
 Meta Type: 클래스, 구조체, 열거형 유형 그 자체를 가리킴
 String 타입은 String.Type
 */

struct User {
    let name = "고래밥"        // 인스턴스 프로퍼티
    static let originalName = "jack"
}

let user = User()
user.name
user.self.name

User.originalName
User.self.originalName


// "고래밥" - String Value
// user.name - String 타입의 인스턴스
// String - String.Type
type(of: user.name)

let intValue: Int = 9.self  // Int 타입은 사실은 구조체 Int의 인스턴스이더라.
let intType: Int.Type = Int.self
