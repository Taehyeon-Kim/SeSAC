//
//  TransitionSecondViewController.swift
//  SeSACWeek2
//
//  Created by taekki on 2022/07/15.
//

import UIKit

class TransitionSecondViewController: UIViewController {

    @IBOutlet weak var mottoTextView: UITextView!
    
    @IBOutlet weak var countLabel: UILabel!
    @IBAction func emotionButtonClicked(_ sender: UIButton) {
        let oldCount = UserDefaults.standard.integer(forKey: "emotionCount")
        let newCount = oldCount + 1
        UserDefaults.standard.set(newCount, forKey: "emotionCount")
        
        // 시각적으로 상관은 없으나, 실제 데이터를 기반으로 보여줘야하기 때문에 데이터에 접근하는 것이 더 나아보임. (처음에는 접근, 호출을 계속하는 문제라고 생각을 해서 비효율적이라고 느꼈는데 멘토님의 말씀을 듣고 맥락상 전자가 맞다는 생각이 들었음
//        self.countLabel.text = "\(newCount)"
        self.countLabel.text = "\(UserDefaults.standard.set(newCount, forKey: "emotionCount"))"
    }
    /*
     1. 앱 켜면 데이터를 가지고 와서 텍스트 뷰에 보여주어야 함.
     2. 바뀐 데이터를 저장해주어야 함.
     => UserDefaults(key:value)
     */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("TransitionSecondViewController", #function)
        
        if UserDefaults.standard.string(forKey: "nickname") != nil {
            // 가져오기
            mottoTextView.text = UserDefaults.standard.string(forKey: "nickname")
        } else {
            // 데이터가 없는 경우 처리
            mottoTextView.text = "고래밥"
        }

        self.countLabel.text = "\(UserDefaults.standard.integer(forKey: "emotionCount"))"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("TransitionSecondViewController", #function)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("TransitionSecondViewController", #function)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("TransitionSecondViewController", #function)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("TransitionSecondViewController", #function)
    }
    
    deinit {
        print("TransitionSecondViewController - deinit")
//        UserDefaults.standard.removeObject(forKey: "nickname")
    }
    
    @IBAction func saveButtonClicked(_ sender: UIButton) {
        UserDefaults.standard.set(mottoTextView.text, forKey: "nickname")
        print("저장되었습니다!")
    }
}
