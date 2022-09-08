import Foundation

/*
 https://beepeach.tistory.com/606
 
 reduce(into:_)
 - Array 또는 Dictionary된 결과값을 얻고 싶을 때 사용
 */

// 공식 문서 예시
let letters = "abracadabra"
let letterCount = letters.reduce(into: [:]) { counts, letter in
    counts[letter, default: 0] += 1
}
// letterCount == ["a": 5, "b": 2, "r": 2, "c": 1, "d": 1]


// 개선 전
let genre1 = ["comedy", "romance", "comedy" , "comedy" , "action"]
var dict = [String: Int]()

genre1.forEach {
    if let count = dict[$0] {
        dict[$0] = count + 1
    } else {
        dict[$0] = 1
    }
}

print(dict)


// 개선 1: dictionary default 값 활용
let genre2 = ["comedy", "romance", "comedy" , "comedy" , "action"]
var dict2 = [String: Int]()

genre2.forEach { dict2[$0, default: 0] += 1 }

print(dict2)


// 개선 2: reduce(into:_) 사용
// 빈도 계산에 용이

// initialResult는 초기값을 의미
// 첫번째 인자가 inout 파라미터이기 때문에 initialResult로 전달 받은 값을 클로저 안에서 직접 변경 가능
let genre3 = ["comedy", "romance", "comedy" , "comedy" , "action"]
let genreCount = genre3.reduce(into: [:]) { $0[$1, default: 0] += 1 }

print(genreCount)


// 인접한 동일 항목 필터링

let numArr1 = [1, 2, 2, 2, 2, 1, 3, 3, 3, 2, 2, 3, 5, 5, 5, 3, 4, 4, 4, 7, 4, 4]
let numArr2 = [1, 2, 1, 6, 2, 2, 3, 5, 4, 5, 3, 4, 4, 7, 4, 4]

let filterd = numArr1.reduce(into: [Int]()) { partialResult, currentValue in
    // partialResult 배열의 길이가 0이거나, partialResult 배열의 마지막 원소가 현재 원소랑 같지 않다면
    if (partialResult.isEmpty || partialResult.last != currentValue) {
        partialResult.append(currentValue)
    }
}

print(numArr1)
print(filterd)
