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
