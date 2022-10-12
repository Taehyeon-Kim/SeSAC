import Foundation

// Date String
let targetDateString = "2022-08-10"
let comparisonDateString = "2022-12-08"

let dateFormatter = DateFormatter()
dateFormatter.dateFormat = "yyyy-MM-dd"

// Optional Binding
guard
    let pastDate = dateFormatter.date(from: targetDateString),
    let futureDate = dateFormatter.date(from: comparisonDateString)
else { fatalError() }

// compare(_:) 메서드
// - return Enumeration(ComparisonResult)
switch pastDate.compare(futureDate) {
case .orderedSame:
    print("\(futureDate)와 같아요.")
case .orderedAscending:
    print("\(futureDate)보다 과거예요.")
case .orderedDescending:
    print("\(futureDate)보다 미래예요.")
}
