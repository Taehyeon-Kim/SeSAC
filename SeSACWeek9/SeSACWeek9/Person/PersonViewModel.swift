//
//  PersonViewModel.swift
//  SeSACWeek9
//
//  Created by taekki on 2022/08/31.
//

// UIKit에 대한 것을 다루지 않음
import Foundation

class PersonViewModel {
    
    var list: Observable<Person> = Observable(Person(page: 0, totalPages: 0, totalResults: 0, results: []))
    
    func fetchPerson(query: String) {
        PersonAPIManager.requestPerson(query: query) { person, error in
            guard let person = person else { return }
            self.list.value = person
        }
    }
    
    var numberOfRowsInSection: Int {
        return list.value.results.count
    }
    
    func cellForRowAt(at indexPath: IndexPath) -> Results {
        return list.value.results[indexPath.row]
    }
}
