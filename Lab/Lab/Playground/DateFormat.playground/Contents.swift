import UIKit

// DateFormatter: 알아보기 쉬운 날짜 + 시간대 (yyyy MM dd hh:mm:ss)
let format = DateFormatter()
format.dateFormat = "M월 d일, yy년"
//format.locale = Locale(identifier: "ko_KR")

print(Date())

let resultFromDate = format.string(from: Date())
print(resultFromDate)

let resultFromString = format.date(from: "3월 6일, 21년")
print(resultFromString)
