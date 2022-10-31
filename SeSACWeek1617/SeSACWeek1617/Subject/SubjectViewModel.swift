//
//  SubjectViewModel.swift
//  SeSACWeek1617
//
//  Created by taekki on 2022/10/25.
//

import Foundation
import RxSwift

struct Contact {
    var name: String
    var age: Int
    var number: String
}

final class SubjectViewModel {

    private var contactData: [Contact] = [
        Contact(name: "Jack", age: 21, number: "01012344566"),
        Contact(name: "Meta Jack", age: 21, number: "01015264577"),
        Contact(name: "Hue", age: 21, number: "01034534562")
    ]
    
    var list = PublishSubject<[Contact]>()  // 구독 전에 이벤트를 전달한다면?

    func fetchData() {
        list.onNext(contactData)
    }
    
    func resetData() {
        list.onNext([])
    }
    
    func newData() {
        let new = Contact(name: "new", age: Int.random(in: 10...50), number: "010xxxxbbbb")
        contactData.append(new)
        list.onNext(contactData)    // next로만 전달하면 대입 연산이 되기 때문에 하나씩만 추가가 된다.
    }
    
    func filterData(query: String) {
        /// let filterd = contactData.filter { $0.name.contains(query) }
        let filterd = contactData.filter { $0.name == query }
        list.onNext(query.isEmpty ? contactData : filterd)
    }
}
