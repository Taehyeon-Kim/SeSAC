//
//  APIService.swift
//  InAppPurchase
//
//  Created by taekki on 2022/12/01.
//

import Foundation

struct Lotto: Codable {
    let totSellamnt: Int
    let returnValue, drwNoDate: String
    let firstWinamnt, drwtNo6, drwtNo4, firstPrzwnerCo: Int
    let drwtNo5, bnusNo, firstAccumamnt, drwNo: Int
    let drwtNo2, drwtNo3, drwtNo1: Int
}

final class APIService {
    
    let urlString = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=1043"
    
    var number = 0
    
    func callRequest(completionHandler: @escaping (Int) -> Void) {
        
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else { return }
            
            guard let data = data, error == nil else { return }
            
            do {
                let value = try JSONDecoder().decode(Lotto.self, from: data)
                // self.number = value.drwtNo1
                completionHandler(self.number)
            } catch {
                return
            }
        }
        task.resume()
    }
    
}
