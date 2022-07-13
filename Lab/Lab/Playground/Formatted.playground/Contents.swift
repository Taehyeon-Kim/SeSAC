import UIKit

let value = Date()

//print(value)
//print(value.formatted())

print(value.formatted(date: .omitted, time: .omitted))
print(value.formatted(date: .omitted, time: .complete))
print(value.formatted(date: .omitted, time: .shortened))
print(value.formatted(date: .omitted, time: .standard))

print()

print(value.formatted(date: .complete, time: .omitted))
print(value.formatted(date: .complete, time: .complete))
print(value.formatted(date: .complete, time: .shortened))
print(value.formatted(date: .complete, time: .standard))

print()

print(value.formatted(date: .abbreviated, time: .omitted))
print(value.formatted(date: .abbreviated, time: .complete))
print(value.formatted(date: .abbreviated, time: .shortened))
print(value.formatted(date: .abbreviated, time: .standard))

print()

print(value.formatted(date: .long, time: .omitted))
print(value.formatted(date: .long, time: .complete))
print(value.formatted(date: .long, time: .shortened))
print(value.formatted(date: .long, time: .standard))

print()

print(value.formatted(date: .numeric, time: .omitted))
print(value.formatted(date: .numeric, time: .complete))
print(value.formatted(date: .numeric, time: .shortened))
print(value.formatted(date: .numeric, time: .standard))


let locale = Locale(identifier: "ko-KR")

let result = value.formatted(.dateTime.locale(locale).day().month(.twoDigits).year())
print(result)

let result2 = value.formatted(.dateTime.day().month(.twoDigits).year())
print(result2)


print(50.formatted(.percent))
print(12345678910.formatted())
print(45665712415.formatted(.currency(code: "krw")))

let result3 = ["올라프", "미키마우스", "뽀로로"].formatted()
print(result3)
