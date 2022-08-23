import UIKit

func validateUserInput(text: String) -> Bool {
    
    // 입력한 값이 비었는지
    guard !(text.isEmpty) else {
        print("빈 값")
        return false
    }
    
    // 입력한 값이 숫자인지 아닌지
    guard Int(text) != nil else {
        print("숫자가 아닙니다.")
        return false
    }
    
    return true
}

if validateUserInput(text: "20200101") {
    print("검색 가능")
} else {
    print("검색 불가능")
}

enum ValidationError: Error {
    case emptyString
    case inNotInt
    case isNotDate
    case callLimit
    case serverError
}

func validateUserInputError(text: String) throws -> Bool {
    
    // 입력한 값이 비었는지
    guard !(text.isEmpty) else {
        throw ValidationError.emptyString
    }
    
    // 입력한 값이 숫자인지 아닌지
    guard Int(text) != nil else {
        throw ValidationError.inNotInt
    }
    
    return true
}

do {
    let result = try validateUserInputError(text: "20220202")
    print(result, "성공")
    
} catch ValidationError.emptyString {
    print("빈 값 안 돼!!!")
    
} catch ValidationError.inNotInt {
    print("숫자 아니면 안 돼!!!")
    
} catch {
    print("ERROR")

}
