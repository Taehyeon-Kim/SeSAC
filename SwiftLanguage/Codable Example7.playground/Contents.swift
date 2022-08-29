/*
 https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=861
 */

import UIKit

let json = """
{"totSellamnt":81032551000,"returnValue":"success","drwNoDate":"2019-06-01","firstWinamnt":4872108844,"drwtNo6":25,"drwtNo4":21,"firstPrzwnerCo":4,"drwtNo5":22,"bnusNo":24,"firstAccumamnt":19488435376,"drwNo":861,"drwtNo2":17,"drwtNo3":19,"drwtNo1":11}
"""

// 서버에서 아무리 데이터가 많이 오더라도 필요한 것만 받아서 사용 가능
struct Lotto: Decodable {
    let totSellamnt: Int
    let returnValue, drwNoDate: String
    let firstWinamnt, drwtNo6, drwtNo4, firstPrzwnerCo: Int
    let drwtNo5, bnusNo, firstAccumamnt, drwNo: Int
    let drwtNo2, drwtNo3, drwtNo1: Int
}

guard let result = json.data(using: .utf8) else { fatalError("Data Error") }
print(result)

let decoder = JSONDecoder()

// Data -> Struct
do {
    let value = try decoder.decode(Lotto.self, from: result)
    print(value)
    
} catch {
    print(error)
}
