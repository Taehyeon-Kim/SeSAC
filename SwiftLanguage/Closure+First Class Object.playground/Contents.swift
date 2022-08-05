import UIKit

// 함수, 일급 객체, 클로저

/*
 1급 객체
 1. 변수나 상수에 함수를 대입할 수 있다.
 2. 함수의 반환 타입으로 함수를 사용할 수 있다.
 3. 함수의 인자값으로 함수를 사용할 수 있다.
 */

func checkBankInformation(bank: String) -> Bool {
    let bankArray = ["우리", "국민", "신한"]
//    return bankArray.contains(bank) ? true : false
    return bankArray.contains(bank) ? true : false
}

// ⬇️ 변수나 상수에 함수를 실행해서 반환된 반환값을 대입한 것. (함수를 대입한 것 x - 1급 객체의 특성은 아님)
let checkResult = checkBankInformation(bank: "우리")              // checkResult Bool
print(checkResult)

// ⬇️ 변수나 상수에 함수 '자체'를 대입할 수 있다. (함수의 이름만 넣음 - 1급 객체의 특성)
// 단지 함수만 대입한 것으로, 실행된 상태는 아님
let checkAccount = checkBankInformation


// - 매개변수명이 없다?!
// - 타입이 (String) -> Bool => 함수 타입(Function Type)이다! (cf. Tuple)
let tupleExample: (Int, Int, String, Bool) = (1, 2, "Hello", true)      // Tuple도 유동적으로 타입이 달라짐
tupleExample.2


// 함수를 호출을 해주어야 실행 된다.
checkAccount("신한")



// 오버로딩: 함수의 이름은 동일

// Swift3 괄호 명시
// 1. Function Type: (String) -> String
func hello(username: String) -> String {
    return "저는 \(username)입니다."
}

// 2. Function Type: (String, Int) -> String
func hello(nickname: String, age: Int) -> String {
    return "저는 \(nickname), \(age)살 입니다."
}

// 오버로딩 특성으로 함수를 구분하기 힘들 때, 타입 어노테이션을 통해서 함수를 구별할 수 있다.
// 하지만 타입 어노테이션만으로 함수를 구별할 수 없는 상황도 있다.
// 함수 표기법을 사용한다면 타입 어노테이션을 생략하더라도 함수를 구별할 수 있다. (매개변수명으로 타입을 구분 가능)
let result: (String) -> String = hello(username:)
result("고래밥")

let ageResult: (String, Int) -> String = hello
ageResult("고래밥", 25)

// 파라미터 명이 동일하다면?
func hello(nickname: String) -> String {
    return "저는 \(nickname)님 입니다."
}

// 이러한 형태는 #selector에서도 보았던 것 같다.
let result2 = hello(nickname:) // 함수 표기법 사용
result2("상어밥")


// 2. 함수의 반환 타입으로 함수를 사용할 수 있다.

func currentAccount() -> String {
    return "계좌 있음"
}

func noCurrentAccount() -> String {
    return "계좌 없음"
}

// 가장 왼쪽에 위치한 -> 를 기준으로 오른쪽에 놓인 모든 타입은 반환값을 의미한다.
func checkBank(bank: String) -> () -> String {
    let bankArray = ["우리", "국민", "신한"]
    return bankArray.contains(bank) ? currentAccount : noCurrentAccount // 함수를 호출하는 것은 아니고 함수를 던져준다.
}

let jack = checkBank(bank: "농협") // 함수 자체 대입
jack()                            // 함수 호출 연산자 필요
checkBank(bank: "우리")()


// 2-1. Calculate

func plus(a: Int, b: Int) -> Int {
    return a + b
}

func minus(a: Int, b: Int) -> Int {
    return a - b
}

func multiply(a: Int, b: Int) -> Int {
    return a * b
}

func divide(a: Int, b: Int) -> Int {
    return a / b
}

func calculate(operand: String) -> (Int, Int) -> Int {
    
    switch operand {
    case "+": return plus
    case "-": return minus
    case "*": return multiply
    case "/": return divide
    default: return plus
    }
    
}

calculate(operand: "+")     // 함수가 실행되고 있는 상태가 아님.
let resultCalculate = calculate(operand: "+")
resultCalculate(3, 5)

/*
 // 2번 특성
 // () -> ()
 // typealias Void = ()
 */

func oddNumber() {
    print("홀수")
}

func evenNumber() {
    print("짝수")
}

func plusNumber() {
    
}

func minusNumber() {
    
}

// 어떤 함수가 들어가던 상관이 없고, 타입만 잘 맞으면 된다.
func resultNumber(number: Int, odd: () -> (), even: () -> ()) {
    return number.isMultiple(of: 2) ? even() : odd() // 호출 연산자 () 사용
}

// 매개변수로 함수를 전달한다.
resultNumber(number: 9, odd: oddNumber, even: evenNumber)

resultNumber(number: 10, odd: plusNumber, even: minusNumber)    // 의도하지 않은 함수가 들어갈 수 있음. 필요 이상의 함수가 자꾸 생김

// 이름 없는 함수 = 익명 함수 = 클로저 -> 이름 없이 함수의 기능을 사용함
resultNumber(number: 11, odd: {
    print("홀수")
}, even: {
    print("짝수")
})

resultNumber(number: 20) {
    //
} even: {
    //
}

oddNumber // () -> ()


/*
 클로저: 이름 없는 함수
 */

// () -> ()

func studyiOS() {
    print("주말에도 공부하기")
}

let studyiOSHarder: () -> () = {
    print("주말에도 공부하기")
}

// '클로저 헤더' in '클로저 바디'
let studyiOSHarder2 = { () -> () in
    print("주말에도 공부하기")
}

studyiOSHarder2()

func getStudyWithMe(study: () -> ()) {
    print("getStudyWithMe")
    study()
}

// 코드를 생략하지 않고 클로저 구문 씀, 함수의 매개변수 내에 클로저가 그대로 들어간 형태
// => 인라인 클로저
getStudyWithMe(study: { () -> () in
    print("주말에도 공부하기")
})

// 함수 뒤에 클로저가 실행
// => 트레일링 클로저(= 후행 클로저)
getStudyWithMe() { () -> () in
    print("주말에도 공부하기")
}

func example(number: Int) -> String {
    return "\(number)"
}

func randomNumber(result: (Int) -> String) {
    result(Int.random(in: 1...100))
}

// 인라인 클로저
randomNumber(result: { (number: Int) -> String in
    return "행운의 숫자는 \(number)입니다."
})

randomNumber(result: { (number) in
    return "행운의 숫자는 \(number)입니다."
})

randomNumber(result: { (number) in
    "행운의 숫자는 \(number)입니다."
})

// 매개변수가 생략되면 할당되어 있는 내부 상수 $0을 이용할 수 있다. ($0, $1, $2 ...)
randomNumber(result: {
    "행운의 숫자는 \($0)입니다."
})

randomNumber {
    "행운의 숫자는 \($0)입니다."
}

//randomNumber { _ in
//    "행운의 숫자는 0입니다."
//}


// 고차함수: filter map reduce

func processTime(code: () -> ()) {
    let start = CFAbsoluteTimeGetCurrent()
    code()
    let end = CFAbsoluteTimeGetCurrent() - start
    print(end)
}


// ex. 4.0 이상인 학생 고르기
let student = [2.2, 4.5, 3.2, 4.9, 1.8, 3.2, 3.3, 4.5, 2.2, 4.5, 3.2, 4.9, 1.8, 3.2, 3.3, 4.5, 2.2, 4.5, 3.2, 4.9, 1.8, 3.2, 3.3, 4.5]

processTime {
    var newStudent: [Double] = []

    for student in newStudent {
        if student >= 4.0 {
            newStudent.append(student)
        }
    }

    print(newStudent)
}

let filterStudent = student.filter { value in
    value >= 4.0
}

processTime {
    let filterStudent2 = student.filter { $0 >= 4.0 } // 클로저 축약 사용
    print(filterStudent2)
}



// map: 기존 요소를 클로저를 통해 원하는 결과값으로 변경
let number = [Int](1...100)
var newNumber: [Int] = []

for number in number {
    newNumber.append(number * 3)
}

print(newNumber)

let mapNumber = number.map { $0 * 3 }
print(newNumber)


let movieList = [
    "괴물" : "박찬욱",
    "기생충" : "봉준호",
    "인터스텔라" : "크리스토퍼 놀란",
    "인셉션" : "크리스토퍼 놀란",
    "옥자" : "봉준호"
]

// 특정 감독의 영화만 출력
let movieResult = movieList.filter { $0.value == "봉준호" }
print(movieResult)

// 영화 이름 배열로 변환
let movieResult2 = movieList.filter { $0.value == "봉준호" }.map { $0.key }
print(movieResult2)

// reduce
let examScore: [Double] = [100, 20, 40, 77, 75, 91, 80, 95]
var totalCount: Double = 0

for score in examScore {
    totalCount += score
}

print(totalCount / 8)

// 다 더하는데 일반적으로 사용
let totalCountUsingReduce = examScore.reduce(0) { $0 + $1 }
print(totalCountUsingReduce / 8)


// - drawingGame: 외부함수
// - luckyNumber: 내부함수
func drawingGame(item: Int) -> String {
    
    func luckyNumber(number: Int) -> String {
        return "\(number * Int.random(in: 1...10))"
    }
    
    let result = luckyNumber(number: item)
    return result
}

drawingGame(item: 10)   // 외부 함수의 생명 주기가 끝났다. -> 내부 함수의 생명 주기도 끝났다!

// 내부 함수를 반환하는 외부 함수로 만들 수 있다.
func drawingGame2(item: Int) -> () -> String {
    
    func luckyNumber() -> String {
        return "\(item * Int.random(in: 1...10))"
    }
    
    return luckyNumber
}

drawingGame2(item: 5) // 내부 함수는 아직 동작하지 않음. , 함수 자체만 리턴.

let numberResult = drawingGame2(item: 10) // 외부 함수의 생명주기는 끝남.
numberResult()  // 외부 함수의 생명주기가 끝났는데 내부 함수는 사용이 가능한 상황이 됨.

