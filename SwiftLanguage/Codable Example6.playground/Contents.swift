import UIKit

struct User: Encodable {
    let name: String
    let signDate: Date
    let age: Int
}

let users: [User] = [
    User(name: "Jack", signDate: Date(), age: 33),
    User(name: "Elsa", signDate: Date(timeInterval: -86400, since: Date()), age: 18),
    User(name: "Emily", signDate: Date(timeIntervalSinceNow: 86400*2), age: 11)
]

print(users)

let date: DateFormatter = {
    let df = DateFormatter()
    df.locale = Locale(identifier: "ko_KR")
    df.timeZone = TimeZone(abbreviation: "KST")
    df.dateFormat = "yyyy년 MM월 dd일 EEEE, hh시 mm분"
    return df
}()

let encoder = JSONEncoder()
encoder.outputFormatting = .prettyPrinted   // 제일 많이 사용하는 아웃풋 포맷팅
encoder.dateEncodingStrategy = .formatted(date)     // 제일 많이 사용하는 시간 포맷

do {
    let result = try encoder.encode(users)
    print(result)
    
    guard let jsonString = String(data: result, encoding: .utf8) else {
        fatalError("ERROR")
    }

    print(jsonString)
    
} catch let error {
    print(error)
}
