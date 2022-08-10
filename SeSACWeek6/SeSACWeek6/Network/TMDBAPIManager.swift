//
//  TMDBAPIManager.swift
//  SeSACWeek6
//
//  Created by taekki on 2022/08/10.
//

import Alamofire
import SwiftyJSON

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

    func callRequest(query: Int, completion: @escaping (([String]) -> ())) {
        let seasonURL = "https://api.themoviedb.org/3/tv/\(query)/season/1?api_key=\(APIKey.tmdb)&language=ko-KR"

        AF.request(seasonURL, method: .get).validate().responseData { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
//                print("JSON: \(json)")
//                dump(json)
                
                
                let stillPathList = json["episodes"].arrayValue.map { $0["still_path"].stringValue }.filter { $0 != "" }
                completion(stillPathList)
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func requestImage() {

        // 어떤 문제가 생길까
        // 1. 순서가 보장되지 않는다.
        // 2. 언제 끝날 지 모른다.
        // 3. Limit (ex. 1초 5번 Block) => 다음주에 해결해보자
        for item in tvList {
            TMDBAPIManager.shared.callRequest(query: item.1) { stillPathList in
                dump(stillPathList)
            }
        }

//        let id = tvList[7].1 // 90447
    }
    
    func requestEpisodeImage(completionHandler: @escaping ([[String]]) -> ()) {
        
        var posterList: [[String]] = []
        
        // 나~중에 배울 것: async/await (iOS 13.0+)
        TMDBAPIManager.shared.callRequest(query: tvList[0].1) { value in
            posterList.append(value)

            TMDBAPIManager.shared.callRequest(query: self.tvList[1].1) { value in
                posterList.append(value)

                TMDBAPIManager.shared.callRequest(query: self.tvList[2].1) { value in
                    posterList.append(value)
                   
                    TMDBAPIManager.shared.callRequest(query: self.tvList[3].1) { value in
                        posterList.append(value)
                     
                        TMDBAPIManager.shared.callRequest(query: self.tvList[4].1) { value in
                            posterList.append(value)
                           
                            TMDBAPIManager.shared.callRequest(query: self.tvList[5].1) { value in
                                posterList.append(value)
                                
                                TMDBAPIManager.shared.callRequest(query: self.tvList[6].1) { value in
                                    posterList.append(value)
                                    
                                    TMDBAPIManager.shared.callRequest(query: self.tvList[7].1) { value in
                                        posterList.append(value)
                                        completionHandler(posterList)
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
