//
//  TMDBAPIManager.swift
//  SeSACWeek6
//
//  Created by taekki on 2022/08/10.
//

import Foundation

final class TMDBAPIManager {
    
    static let shared = TMDBAPIManager()
    
    private init() {}
    
    let tvList = [
        ("환혼", 135157),
        ("이상한 변호사 우영우", 197067),
        ("인사이더", 135655),
        ("미스터 션사인", 75820),
        ("스카이 캐슬", 84327),
        ("사랑의 불시착", 94796),
        ("이태원 클라스", 96162),
        ("호텔 델루나", 90447)
    ]
    
    let imageURL = "https://image.tmdb.org/t/p/w500"
    let seasonURL = "https://api.themoviedb.org/3/tv/135157/season/1?api_key={YOUR KEY}&language=ko-KR"
}
