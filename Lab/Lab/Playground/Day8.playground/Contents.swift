import UIKit

// 1. 선언과 초기화

var email: String = "taekki@taekki.dev" // 선언과 초기화
var email2: String?
email2 = "taekki@taekki.dev"            // 선언만 하고 나중에 초기화

type(of: email)
type(of: email2)

// 2. 배열 초기화

var array = Array(repeating: 0, count: 100)
var array2: [Int]? = [Int](1...100)
type(of: array2)

// 3. 조건문

if array2?.count == 0 {
    print("값이 없습니다")
} else {
    print("값이 있습니다")
}

// 삼항 연산자
// 조건식 ? 참(true)일 경우 결과 : 거짓(false)일 경우 결과
// UI 작업 시 생각보다 자주 쓰임
array2 == nil ? "값이 없습니다" : "값이 있습니다"

// 함수)
// 반환값 : 100% 상황에 대한 대응이 가능해야 함
// 아래의 상황에서 else 부분을 생략하면 50이하의 상황에서는 대응이 되지 않기 때문에 컴파일 에러 발생

// Compile Error
// Error: Missing return in global function expected to return 'String'
func example() -> String {
    let result = Int.random(in: 1...100)
    
    // Bool 값으로 판단이 가능한 요소, 반환값이 Bool 타입인 함수는 조건식으로 사용 가능
    if result > 50 {
        return "UP"
    } else {
        return "DOWN"
    }
}

example()

// Warning: Will never be executed
func calculateBMI() -> (String, Double) {
    let result = Double.random(in: 1...30)
    
    if result < 18.5 {
        return ("고래밥", 1.0)
    } else if result >= 18.5 && result < 23 {
        return ("고래밥", 2.0)
    } else {
        return ("고래밥", 3.0)
    }
//    return 3.0
}

let userBMI = calculateBMI()
type(of: userBMI)

// Raw Strings (Swift 5)
print(#"\#(userBMI.0)님의 BMI 등급은 \#(userBMI.1)입니다."#)
// Strings
print(userBMI.0 + "님의 BMI 등급은" + "\(userBMI.1)" + "입니다.")

// Swift 5.1 return 생략 가능
func randomNumber() -> Int {
    Int.random(in: 1...100)
}

let plusNumber = randomNumber() + 10
print(plusNumber)

// 함수는 호출하나 반환값을 사용하지 않을 시
// 코드를 작성하다 보면 반환값을 선택적으로 사용하는 경우가 생김
// 함수를 100번 호출할 때 70번의 경우는 반환값을 보여준고, 30번은 보여주지 않을 수 있음
@discardableResult
func process() -> String {
    // 배경 컬러 변경 또는 텍스트 필드에 텍스트 교체, 키보드 내리기
    // 내부적인 동작은 모두 실행
    // 다만, 반환값만 사용하지 않음
    return "결과값"
}

// 매개변수 기본값
func sayHello(nickname: String? = "손님", gender: Int? = 2) -> String {
    return nickname! + " 반갑습니다!"
}

sayHello()
sayHello(nickname: "고래밥")
sayHello(nickname: "고래밥", gender: 4)

// 오버로딩의 개념
print("안녕하세요", separator: "123", terminator: "456")
print("안녕히가세요", separator: "123", terminator: "456")


// 열거형(ex. 남/여/안함 -> 블랙/파란/흰)
// 실질적인 데이터로 사용하기 위해서 자료형 지정(상속 관계는 아님, 선언을 해주었다.)
enum Gender: String {
    case man
    case woman
    case nothing
}

var gender: Gender = Gender.man // "남성" "여자" "선택안함" // 10 21 23


//if gender == 0 {
//    print("남성입니다")
//} else if gender == 1 {
//    print("여성입니다")
//} else if gender == 2 {
//    print("아직 선택하지 않았습니다")
//}

// 문법상으로 제약하는 것과 의미상으로 제한을 두는 것은 엄연히 다르다.
// iOS에서는 Enum을 통해서 Case를 나눌 수 있는데
// 다른 플랫폼과 소통하기 위해서는 결국 통일된 자료형을 사용해야 한다.
// 간결하고 가독성 있게 코드를 작성할 수 있다.
switch gender {
case .man:      print("남성입니다.")
case .woman:    print("여성입니다.")
case .nothing:  print("아직 선택하지 않았습니다.")
}

gender.rawValue

enum HTTPCode: Int {
    case OK
    case NO_PAGE
    case NOT_FOUND = 404
    case SERVER_ERROR
    
    func showStatus() -> String {
        switch self {
        case .OK:           return "정상입니다."
        case .NO_PAGE:      return "페이지를 찾을 수 없음"
        case .NOT_FOUND:    return "잘못된 문제"
        case .SERVER_ERROR: return "긴급 점검"
        }
    }
}

var networkStatus: HTTPCode = .OK

switch networkStatus {
case .OK: print("정상", networkStatus.rawValue)
case .NO_PAGE: print("잘못된 URL 주소", networkStatus.rawValue)
default: print("기타", networkStatus.rawValue)
}

// 다음과 같이 한 번에 처리 가능
let result = networkStatus.showStatus()
print(result)
