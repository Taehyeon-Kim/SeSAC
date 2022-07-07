//
//  BoardViewController.swift
//  LEDBoard
//
//  Created by taehy.k on 2022/07/06.
//

import UIKit

class BoardViewController: UIViewController {

    @IBOutlet weak var userTextField: UITextField!
    
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var textColorButton: UIButton!
    @IBOutlet weak var resultLabel: UILabel!
    
    @IBOutlet var buttonList: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.userTextField.delegate = self
        self.designTextField()
        self.designButton(buttonOutletVariableName: sendButton, for: "글자 버튼", highlightedTitle: "글자 바뀜", backgroundColor: .red)
        self.designButton(buttonOutletVariableName: textColorButton, for: "색상 버튼", highlightedTitle: "색상 바뀜", backgroundColor: .blue)
    }
    
    func designTextField() {
        self.userTextField.placeholder = "내용을 작성해주세요."
        self.userTextField.text = "안녕하세요."
        self.userTextField.keyboardType = .emailAddress
    }
    
    // buttonOutletVariableName: 외부 매개변수, Argument Label
    // buttonName: 내부 매개변수, Parameter Name
    // buttonName(Parameter): UIButton(Argument)
    // 앞에 있는 이름을 Parameter라고 함.
    // 실제로 들어가는 값을 Argument라고 부름.
    // 외부 매개변수의 경우 실제 들어가는 값의 이름이기 때문에 Argument Label이라고 부름.
    func designButton(buttonOutletVariableName buttonName: UIButton, for title: String, highlightedTitle: String, backgroundColor: UIColor) {
        buttonName.setTitle(title, for: .normal)
        buttonName.setTitle(highlightedTitle, for: .highlighted)
        buttonName.backgroundColor = backgroundColor
        buttonName.layer.cornerRadius = 8
        buttonName.layer.borderColor = UIColor.gray.cgColor
        buttonName.layer.borderWidth = 3
        buttonName.setTitleColor(.white, for: .normal)
        buttonName.setTitleColor(.black, for: .highlighted)
    }
    
    func studyOutletCollection() {
        let buttonArray: [UIButton] = [sendButton, textColorButton]
        
        // 1. 반복문
        for button in buttonArray {
            button.backgroundColor = .blue
            button.layer.cornerRadius = 4
        }
        
        // 2. 아웃렛 컬렉션
        for button in buttonList {
            button.backgroundColor = .blue
            button.layer.cornerRadius = 4
        }
    }
    
    @IBAction func sendButtonDidTapped(_ sender: UIButton) {
        resultLabel.text = userTextField.text
        resultLabel.text = (userTextField.text ?? "") + "\(Int.random(in: 0...100))"
        
        print(userTextField.text?.count)
        print(sendButton.currentTitle)
    }
    
    
    @IBAction func colorChangeButtonDidTapped(_ sender: UIButton) {
        
    }
    
    @IBAction func tapGestureDidTapped(_ sender: UITapGestureRecognizer) {
        print("super view tapped")
        view.backgroundColor = .red
        view.endEditing(true) // 모든 편집이 끝났다. 본질적으로 키보드를 내리는 코드는 아니다.
    }
    
    
    @IBAction func exampleButtonDidTapped(_ sender: UIButton) {
        view.endEditing(true)
    }
}

extension BoardViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
    }
}
