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
    let numberList: [Int] = Array(1...1025).reversed()  // 데이터는 numberList만 관리한다. (역할의 분리)
    var drwNumber = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        numberTextField.inputView = lottoPickerView
        lottoPickerView.delegate = self
        lottoPickerView.dataSource = self
        
        requestLotto(number: 1026)
    }
    
    /*
     // - 중요한 포인트는 1회차부터 돌릴 필요가 없지 않나 생각이 듬.
     1. 개발하는 시점에서 가장 최신회차의 정보는 알고 있으니까 이 회차 정보를 UserDefaults로 가지고 있음.
     2. 해당 회차 정보부터 1씩 증가시키는 반복문을 돌리면서 서버통신을 함.
     3. Fail이 나는 순간 현재 가지고 있는 정보가 최신 회차라는 이야기이고,
     4. 통신이 정상적으로 이루어지면 계속해서 갱신하면 될 것 같음.
     
     // - 이것말고 다른 방법이 있을지는 고민해봐야지
     */
    
    func requestLotto(number: Int) {
        // 알라모파이어에서는 AF: 200 ~ 299를 기본적으로 성공으로 간주한다.
        let url = "\(EndPoint.lottoURL)&drwNo=\(number)"
        AF.request(url, method: .get).validate(statusCode: 200..<400).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                
                let date = json["drwNoDate"].stringValue
                print(date)
                
                self.numberTextField.text = date
                self.firstNumber.text = json["drwtNo1"].stringValue
                self.secondNumber.text = json["drwtNo2"].stringValue
                self.thirdNumber.text = json["drwtNo3"].stringValue
                self.fourthNumber.text = json["drwtNo4"].stringValue
                self.fifthNumber.text = json["drwtNo5"].stringValue
                self.sixthNumber.text = json["drwtNo6"].stringValue
                self.bonusNumber.text = json["bnusNo"].stringValue
                
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
