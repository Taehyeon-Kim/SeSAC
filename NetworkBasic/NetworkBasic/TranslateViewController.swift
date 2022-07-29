//
//  TranslateViewController.swift
//  NetworkBasic
//
//  Created by taekki on 2022/07/28.
//

import UIKit

// UIButton, UITextField > Action O
// UITextView, UISearchBar, UIPickerView > Action X
// Why?
// UIControl
// UIResponderChain > resignFirstResponder() / becomeFirstResponder()

class TranslateViewController: UIViewController {

    @IBOutlet weak var userInputTextView: UITextView!
    let textViewPlaceholderText = "번역하고 싶은 문장을 작성해보세요."
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userInputTextView.delegate = self
        userInputTextView.text = textViewPlaceholderText
        userInputTextView.textColor = .lightGray
        userInputTextView.font = UIFont(name: "Galmuri11-Regular", size: 17)
        
//        userInputTextView.resignFirstResponder()
//        userInputTextView.becomeFirstResponder()
    }
    
    @IBAction func completeButtonTapped(_ sender: Any) {
        userInputTextView.resignFirstResponder()
    }
}

extension TranslateViewController: UITextViewDelegate {
    // 텍스트뷰의 텍스트가 변할 때마다 호출
    func textViewDidChange(_ textView: UITextView) {
        // 글자 수 체크
        print(textView.text.count)
    }
    
    // 편집이 시작될 때. 커서가 시작될 때
    // 텍스트 뷰 글자 : 플레이스 홀더랑 글자가 같으면 clear, 컬러 변경
    func textViewDidBeginEditing(_ textView: UITextView) {
        print("begin")
        
        if textView.textColor == .lightGray {
            textView.text = nil
            textView.textColor = .black
        }
    }
    
    // 편집이 끝났을 때, 커서가 없어지는 순간
    // 텍스트 뷰 글자 : 사용자가 아무 글자도 안 썼으면 플레이스 홀더 글자를 보이게 해라
    func textViewDidEndEditing(_ textView: UITextView) {
        print("end")
        
        if textView.text.isEmpty {
            textView.text = textViewPlaceholderText
            textView.textColor = .lightGray
        }
    }
}
