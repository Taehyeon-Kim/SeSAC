import Foundation

// 옵셔널로 선언된 프로퍼티는 nil을 가질 수 있는 상황. 그래서 나중에 초기화를 해도 됨
// nil을 담을 수 없는 프로퍼티는 값이 무조건 있어야 한다. 그래서 초기화가 필요하다. => 이니셜라이저(<- 초기화가 필요한 함수)
// 값이 없는 상태로 인스턴스가 생성되고, 빈 메모리에 접근하면 에러가 발생할 수 있기 때문에 초기화가 필요한 것이다.
class Monster {
    var name: String
    var level: Int
    
    init(name: String, level: Int) {
        self.name = name
        self.level = level
    }
//    init(a: String, b: Int) {
//        name = a
//        level = b
//    }
}

// 자동으로 초기화 구문 제공 - 멤버와이즈 구문 제공
struct SMonster {
    var name: String = "hello"
    var level: Int
}

let easy = Monster(name: "쉬운 몬스터", level: 1) // 클래스를 초기화 한 것. 인스턴스를 만들었다.
//let easy = Monster(a: "쉬운 몬스터", b: 1)
var hard = easy
let sMonster = SMonster(name: "smonster", level: 100)

hard.name = "보스몬스터"
hard.level = 100

print(easy.name, easy.level)
print(hard.name, hard.level)


/*
 클래스는 let으로 선언하더라도 안에 있는 멤버에 접근해서 값을 변경할 수 있지만
 구조체의 경우 let으로 선언하면 안에 있는 멤버에 접근해서 값을 변경할 수 없다.
 */
let array1: [Int] = [1, 2, 3, 4, 5] // 값 수정 불가
//array1[1] = 5
//print(array1)

var array2: [Int] = [1, 2, 3, 4, 5] // 값 수정 가능
array2[1] = 5
print(array2)
