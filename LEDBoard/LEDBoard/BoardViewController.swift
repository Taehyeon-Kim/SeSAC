//
//  BoardViewController.swift
//  LEDBoard
//
//  Created by taehy.k on 2022/07/06.
//

import UIKit

class BoardViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var userTextField: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var textColorButton: UIButton!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet var buttonList: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureInitialUI()
        self.designTextField()
        self.designButton(buttonOutletVariableName: sendButton, for: "전송", highlightedTitle: "완료", backgroundColor: .red)
        self.designButton(buttonOutletVariableName: textColorButton, for: "색상 변경", highlightedTitle: "색상 바뀜", backgroundColor: .blue)
    }
    
    func configureInitialUI() {
        containerView.layer.cornerRadius = 8
        resultLabel.text = ""
    }
    
    func designTextField() {
        self.userTextField.placeholder = "내용을 작성해주세요."
        self.userTextField.keyboardType = .emailAddress
    }
    
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
        for button in buttonList {
            button.backgroundColor = .blue
            button.layer.cornerRadius = 4
        }
    }
    
    @IBAction func sendButtonDidTapped(_ sender: UIButton) {
        resultLabel.text = userTextField.text
        view.endEditing(true)
    }
    
    
    @IBAction func colorChangeButtonDidTapped(_ sender: UIButton) {}
    
    
    @IBAction func textFieldDidTapped(_ sender: UITextField) {
        print("textField - DidEndOnExit")
    }
    
    @IBAction func tapGestureDidTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
        self.containerView.isHidden.toggle()
    }
    
    
    @IBAction func exampleButtonDidTapped(_ sender: UIButton) {
        view.endEditing(true)
    }
}
