import UIKit


// ===========================
// 인스턴스 프로퍼티
// ===========================

// 인스턴스 프로퍼티는 인스턴스를 생성해야만 접근이 가능하다.
// ➡️ (static 키워드가 없다면 인스턴스 프로퍼티)
struct Poster {
    var image: UIImage = UIImage(named: "star") ?? UIImage()
    
    // 어떻게 init 초기화 구문을 작성할 수 있는 것일까요?
    // 멤버와이즈 이니셜라이저를 가지고 있지만, 추가적인 구현도 가능
    // 필요에 따라 초기화 구문을 여러 가지로 만들어서 사용할 수 있다.
    // 메서드 오버로딩 특성을 활용해 하나의 초기화 구문인데 여러 구문처럼 쓸 수도 있다.
    init() {
        print("Print Initialized")
    }
    
    init(defaultImage: UIImage) {
        self.image = defaultImage
    }
    
    init(customImage: UIImage) {
        self.image = customImage
    }
}

// ===========================
// 지연 저장 프로퍼티 (lazy var)
// ===========================

// 인스턴스마다 image 프로퍼티가 다른 값을 가질 수 있을까? ⭕️
// 구조체(값 타입)이기 때문
var one = Poster()
var two = Poster()
var three = Poster()

struct MediaInfo {
    var mediaTitle: String
    let mediaRuntime: Int
    lazy var mediaPoster: Poster = Poster()
}

var media = MediaInfo(mediaTitle: "오징어게임", mediaRuntime: 123)

// 만약 mediaPoster를 호출하지 않았다면 메모리에 올라가지 않은 상태
media.mediaPoster
// 호출시에 메모리에 올라감

