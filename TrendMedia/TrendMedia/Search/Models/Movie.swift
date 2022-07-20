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
    var description: String
    var runtime: Int
    var rate: Double
}

extension Movie {
    static let sampleData: [Movie] = [
        Movie(title: "암살", releaseDate: "22.22.22", description: "줄거리", runtime: 150, rate: 8.8),
        Movie(title: "괴물", releaseDate: "22.22.22", description: "줄거리", runtime: 150, rate: 8.8),
        Movie(title: "관상", releaseDate: "22.22.22", description: "줄거리", runtime: 150, rate: 8.8),
        Movie(title: "탑건", releaseDate: "22.22.22", description: "줄거리", runtime: 150, rate: 8.8),
        Movie(title: "마녀", releaseDate: "22.22.22", description: "줄거리", runtime: 150, rate: 8.8),
        Movie(title: "기생충", releaseDate: "22.22.22", description: "줄거리", runtime: 150, rate: 8.8),
        Movie(title: "광해", releaseDate: "22.22.22", description: "줄거리", runtime: 150, rate: 8.8),
        Movie(title: "명량", releaseDate: "22.22.22", description: "줄거리", runtime: 150, rate: 8.8),
        Movie(title: "위대한 쇼맨", releaseDate: "22.22.22", description: "줄거리", runtime: 150, rate: 8.8),
    ]
}
