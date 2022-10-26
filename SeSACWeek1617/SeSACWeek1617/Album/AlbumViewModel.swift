//
//  AlbumViewModel.swift
//  SeSACWeek1617
//
//  Created by taekki on 2022/10/26.
//

import Foundation

import RxSwift
import RxRelay

final class AlbumViewModel {

    private var photoData = Photo.dummy()
    private var selectedPhotos: [Int] = []

    lazy var photos = BehaviorRelay(value: photoData)

    func photoDidTap(index: Int) {
        if selectedPhotos.contains(index) {
            guard let order = selectedPhotos.firstIndex(of: index) else { return }
            selectedPhotos.remove(at: order)
        } else {
            selectedPhotos.append(index)
        }
        
        // 선택 번호 초기화
        for index in 0..<photoData.count {
            photoData[index].index = 0
        }
        
        for (i, v) in selectedPhotos.enumerated() {
            photoData[v].index = i + 1
        }
        
        photos.accept(photoData)
    }
}
