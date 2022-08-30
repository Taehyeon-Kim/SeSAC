//
//  LottoAPIManager.swift
//  SeSACWeek9
//
//  Created by taekki on 2022/08/30.
//

import Foundation

// shared - 단순, 커스텀 불가, 응답은 클로저 형태로 전달, 백그라운드 형태는 처리 불가
// default configuration - shared 설정 유사, 커스텀O (셀룰러 연결 여부 - 너 LTE로 변경되었는 데 괜찮아?, 타임 아웃 간격 설정), 응답을 클로저 또는 델리케이트 형태로 할 수 있다.
// : - ex. 요청 후 5초가 지나더라도 응답이 오지 않으면 다음에 다시 시도해달라 알림, 또는 어떤 처리를 해줄 수 있다. 무한 로딩 등 사용자 경험을 저해하는 등의 UX를 만들 수는 없으니까.

enum APIError: Error {
    case invaildResponse
    case noData
    case failedRequest
    case invaildData
}

final class LottoAPIManager {
    
    // - (Data, Error)
    // - Result<>
    // - Async, Await
    static func requestLotto(drwNo: Int, completion: @escaping ((Lotto?, APIError?) -> Void)) {
        
        let url = URL(string: "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=\(drwNo)")!
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            // 아예 구현부에서 메인 스레드로 바꿔주는 처리를 해주기도 한다.
            DispatchQueue.main.async {
                guard error == nil else {
                    completion(nil, .failedRequest)
                    return
                }
                
                guard let data = data else {
                    completion(nil, .noData)
                    return
                }

                // HTTPURLResponse로 타입 캐스팅
                // URLResponse > HTTPURLResponse는 상속 관계
                guard let response = response as? HTTPURLResponse else {
                    completion(nil, .invaildResponse)
                    return
                }
                
                guard response.statusCode == 200 else {
                    completion(nil, .failedRequest)
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode(Lotto.self, from: data)
                    completion(result, nil)
                    
                } catch {
                    completion(nil, .invaildData)
                }
            }

        }.resume()
    }
}
