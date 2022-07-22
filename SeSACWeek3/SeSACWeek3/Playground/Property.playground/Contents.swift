import UIKit

enum DrinkSize {
    case short, tall, grande, venti
}

class DrinkClass {
    let name: String
    var count: Int
    var size: DrinkSize
    
    // 클래스는 초기화 구문이 필요
    init(name: String, count: Int, size: DrinkSize) {
        self.name = name
        self.count = count
        self.size = size
    }
}

struct DrinkStruct {
    let name: String
    var count: Int
    var size: DrinkSize
}

let drinkClass = DrinkClass(name: "스무디", count: 2000, size: .grande)
drinkClass.count = 5
drinkClass.size = .tall

print(drinkClass.name, drinkClass.count, drinkClass.size)

var drinkStruct = DrinkStruct(name: "스무디", count: 2000, size: .grande)
drinkStruct.count = 10
drinkStruct.size = .venti

print(drinkStruct.name, drinkStruct.count, drinkStruct.size)

// 영화 타이틀, 러닝타임, 영상/화질좋은포스터 => 필요한 시점에 초기화를 할 수 없을까?

struct Poster {
    var image: UIImage = UIImage(systemName: "star") ?? UIImage()
    
    init() {
        print("Poster Initialized")
    }
}

struct MediaInfo {
    var mediaTitle: String
    var mediaRuntime: Int
    var mediaPoster: Poster = Poster()
    // 영화 이미지에 대한 부분을 초기화 할 필요가 없음(용량도 크고, 당장 사용할 필요가 없을 수도 있기 때문)
}

var media = MediaInfo(mediaTitle: "오징어게임", mediaRuntime: 123)

// 100중 1개만 play
// 5분뒤에 접근
// 필요한 시점에 접근하면 메모리에 올라감
// 옵션적인 상황이 있거나, 초반에 초기화하기 부담스러운 상황(용량이 크거나 등등), 정말 사용자가 필요한 상황일 때 사용
// 저장을 지연시킴
// 어차피 써야하는 상황이라면 lazy를 쓸 필요가 없다.

// lazy는 절대 let으로 사용될 수 없다.
// - let은 값이 안바뀐다. 상수는 인스턴스가 생성되기 전에 값을 항상 가지고 있어야 함.
// - 지연 저장 프로퍼티가 처음으로 호출이 돼서 사용되기 전에는 가지고 있는 값이 nil이다.
// - nil이었다가 값이 바뀌게 됨.
// - 클래스 인스턴스가 사라질 때 같이 메모리에서 해제된다.

media.mediaPoster

// 타입 프로퍼티 : 디폴트가 지연 저장 프로퍼티 형태로 동작. 그렇기에 lazy를 안 써도 된다.
// - lazy 키워드를 사용하지 않더라도 나중에 값이 할당된다. 나중에 메모리에 올라간다.
// - 무조건 초기화 필요
// - 프로퍼티 성격 자체가 다르기 때문에 static과 let을 같이 써도 문제가 없다.

struct User {
    static let name = "고래밥"
    static let aga = 33         // 저장 타입 프로퍼티 (호출하는 시점에 메모리 로드)
}

User.name // 호출하는 시점에 메모리에 올라간다.
