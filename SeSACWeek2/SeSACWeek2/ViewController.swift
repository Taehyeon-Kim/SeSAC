//
//  ViewController.swift
//  SeSACWeek2
//
//  Created by taekki on 2022/07/11.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var emotionFirstLabel: UILabel!
    @IBOutlet weak var emotionSecondLabel: UILabel!
    @IBOutlet weak var emotionFirstButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.emotionFirstLabel.text = self.setUserNickname()
        self.view.backgroundColor = self.example().0
        self.emotionFirstButton.setImage(UIImage(named: example().2), for: .normal)
        
        self.presentAlert()
    }
    
    // - 이렇게만 함수를 작성하게 되면 어느 레이블에 텍스트를 보여주는지 알기 어렵다.
    // - 그렇기에 String을 반환하는 함수의 형태로 변경한다.
    // - 해당 기능은 nickname을 랜덤으로 뽑아주는 역할을 하고, 실제로 화면에 표시하는 부분은 호출부에서 담당한다.
    func setUserNickname() -> String {
        let nickname = ["고래밥", "칙촉", "격투가"]
        let select = nickname.randomElement()!
        
        return "저는 \(select)입니다." // 해당 라인에서 코드가 종료된다.
    }
    
    // 배경색, 레이블, 이미지
    // - 타입이 각각 다르다.
    // - 타입에 상관없이 정보를 넘겨줄 수 없을까?
    // - Tuple 형태로 반환
    func example() -> (UIColor, String, String) {
        let color: [UIColor] = [.yellow, .red, .blue]
        let image: [String] = ["sesac_slime6", "sesac_slime7", "sesac_slime8"]
        
        return (color.randomElement()!, "고래밥", image.randomElement()!)
    }
    
    func presentAlert() {
//        let alert = UIAlertController(title: "타이틀", message: "여기는 메시지가 들어갑니다." , preferredStyle: .alert)
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        let webAction = UIAlertAction(title: "새 창으로 열기", style: .destructive, handler: nil)
        let copyAction = UIAlertAction(title: "복사", style: .default, handler: nil)
        
        alert.addAction(copyAction)
        alert.addAction(webAction)
        alert.addAction(cancelAction)
        alert.addAction(okAction)
        
        self.present(alert, animated: true) {
            print("내부적인 처리/통계 등")
            print("Screen Shot Capture")
        }
    }
}

