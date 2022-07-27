import UIKit

struct ExchangeRate {
    
    var currencyRate: Double {
        willSet {
            print("환율 변동 예정: \(currencyRate) ➡️ \(newValue)")
        }
        didSet {
            print("환율 변동 완료: \(oldValue) ➡️ \(currencyRate)")
        }
    }
    
    var USD: Double {
        willSet {
            print("USD willSet - 🇺🇸 USD: \(newValue)달러로 환전될 예정")
        }
        didSet {
            print("USD didSet - 🇰🇷 KRW: \(KRW)원이 🇺🇸 USD: \(USD)달러로 환전되었음")
        }
    }
    
    // 📌 KRW의 set이 일어나면 - USD의 willSet과 didSet에 차례대로 영향을 준다.
    var KRW: Double {
        get {
            return USD * currencyRate
        }
        set {
            USD = newValue / currencyRate
        }
    }
}

var rate = ExchangeRate(currencyRate: 1100, USD: 1)
rate.KRW = 500000
rate.currencyRate = 1350
rate.KRW = 500000
