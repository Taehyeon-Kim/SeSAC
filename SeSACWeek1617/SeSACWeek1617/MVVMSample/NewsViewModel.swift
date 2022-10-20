//
//  NewsViewModel.swift
//  SeSACWeek1617
//
//  Created by taekki on 2022/10/20.
//

import Foundation

/// 글자(데이터)를 ViewModel에서 가지도록 구현한다.
class NewsViewModel {
    
    var pageNumber: CObservable<String> = CObservable("3000")
    var news: CObservable<[News.NewsItem]> = CObservable(News.items)
    
    /// PageNumber의 Format을 변경해주는 메서드
    func changePageNumberFormat(of text: String) {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        
        /// String -> Int로 변환할 수 있도록 콤마 제거
        let text = text.replacingOccurrences(of: ",", with: "")
        guard let number = Int(text) else { return }
        let result = numberFormatter.string(for: number)!
        pageNumber.value = result
    }
    
    /*
     Data handling
     */
    
    func resetNews() {
        news.value = []
    }
    
    func loadNews() {
        news.value = News.items
    }
}
