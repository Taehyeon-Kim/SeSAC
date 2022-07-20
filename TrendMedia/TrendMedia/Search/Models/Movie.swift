//
//  Movie.swift
//  TrendMedia
//
//  Created by taekki on 2022/07/19.
//

// 다음 구조체는 생성 이후에 프로퍼티가 변경될일이 없을 것 같은데
// var 대신 let을 사용하는 것은 어떨까?

struct Movie {
    var title: String
    var releaseDate: String
    var runtime: Int
    var description: String
    var rate: Double
}
