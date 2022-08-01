//
//  LottoViewController.swift
//  NetworkBasic
//
//  Created by taekki on 2022/07/28.
//

import UIKit

import Alamofire
import SwiftyJSON

class LottoViewController: UIViewController {
    @IBOutlet weak var numberTextField: UITextField!
//    @IBOutlet weak var lottoPickerView: UIPickerView!
    
    @IBOutlet weak var firstNumber: UILabel!
    @IBOutlet weak var secondNumber: UILabel!
    @IBOutlet weak var thirdNumber: UILabel!
    @IBOutlet weak var fourthNumber: UILabel!
    @IBOutlet weak var fifthNumber: UILabel!
    @IBOutlet weak var sixthNumber: UILabel!
    @IBOutlet weak var bonusNumber: UILabel!
    
    var lottoPickerView = UIPickerView()
    // 코드로 뷰를 만드는 기능이 훨씬 더 많이 남아있음.
    
    let numberList: [Int] = Array(1...1025).reversed()  // 데이터는 numberList만 관리한다. (역할의 분리)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        numberTextField.inputView = lottoPickerView
        lottoPickerView.delegate = self
        lottoPickerView.dataSource = self
        
        requestLotto(number: 1025)
    }
    
    func requestLotto(number: Int) {
        // 알라모파이어에서는 AF: 200 ~ 299를 기본적으로 성공으로 간주한다.
        let url = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=\(number)"
        AF.request(url, method: .get).validate(statusCode: 200..<400).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                
                let bonus = json["bnusNo"].stringValue
                let firstNumber = json["drwtNo1"].stringValue
                let secondNumber = json["drwtNo2"].stringValue
                let thirdNumber = json["drwtNo3"].stringValue
                let fourthNumber = json["drwtNo4"].stringValue
                let fifthNumber = json["drwtNo5"].stringValue
                let sixthNumber = json["drwtNo6"].stringValue
                
                let date = json["drwNoDate"].stringValue
                print(date)
                
                self.numberTextField.text = date
                self.firstNumber.text = firstNumber
                self.secondNumber.text = secondNumber
                self.thirdNumber.text = thirdNumber
                self.fourthNumber.text = fourthNumber
                self.fifthNumber.text = fifthNumber
                self.sixthNumber.text = sixthNumber
                self.bonusNumber.text = bonus
                
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension LottoViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return numberList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        requestLotto(number: numberList[row])
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(numberList[row])회차"
    }
}
