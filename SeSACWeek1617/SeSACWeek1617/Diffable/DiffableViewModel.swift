//
//  DiffableViewModel.swift
//  SeSACWeek1617
//
//  Created by taekki on 2022/10/20.
//

import Foundation

import RxSwift

enum SearchError: Error {
    case noPhoto
    case serverError
}

final class DiffableViewModel {
    
    // var photoList: CObservable<SearchPhoto> = CObservable(SearchPhoto(total: 0, totalPages: 0, results: []))
    var photoList = PublishSubject<SearchPhoto>()
    
    func requestSearchPhoto(query: String) {
        APIService.searchPhoto(query: query) { [weak self] photo, statusCode, error in
            
            guard let statusCode = statusCode, statusCode == 200 else {
                self?.photoList.onError(SearchError.serverError)
                return
            }
            
            guard let photo else {
                self?.photoList.onError(SearchError.noPhoto)
                return
            }
            // self.photoList.value = photo
            self?.photoList.onNext(photo)
            // 일주일에 한번씩 업데이트 되는 정보라거나,, 그런 상황에서는 종료를 해줘도 좋다.
            // self?.photoList.onCompleted()
        }
    }
}
