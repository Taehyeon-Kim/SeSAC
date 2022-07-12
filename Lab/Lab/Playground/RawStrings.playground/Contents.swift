import UIKit

// 기존 이스케이프 문자 사용
var notice = "온라인 라이브 수업은 \"Zoom\"으로 진행합니다."
print(notice)

// # 사용
var newNotice = #"온라인 라이브 수업은 "Zoom"으로 진행합니다."#
print(newNotice)

var rawNotice = #"온라인 \\\ 라이브 수업은 \#n\#n\#n Zoom으로 진행합니다."#
print(rawNotice)

var onlineService = "WhaleOn"
var finalNotice = ##"온라인 라이브 수업은 \##(onlineService)으로 진행합니다."##
