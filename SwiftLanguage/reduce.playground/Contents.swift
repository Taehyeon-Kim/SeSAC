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


