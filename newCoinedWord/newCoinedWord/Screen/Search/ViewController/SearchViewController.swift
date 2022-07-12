//
//  SearchViewController.swift
//  newCoinedWord
//
//  Created by taehy.k on 2022/07/09.
//

import UIKit

final class SearchViewController: UIViewController {

    @IBOutlet weak var searchContainerView: UIView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet var hashTagButtons: [UIButton]!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    private var newWords: [String: String] = [
        "쫌쫌따리": "아주 조금씩 적고 하찮은 양을 모으는 모습",
        "억텐": "억지 텐션",
        "스불재": "스스로 불러온 재앙",
        "좋댓구알": "좋아요, 댓글, 구독, 알림설정",
        "어쩔티비": "어쩌라고 가서 TV나봐",
        "갓생": "갓(God) + 생",
        "점메추": "점심 메뉴 추천",
        "다꾸": "다이어리 꾸미기",
        "킹받다": "열받다",
        "군싹": "군침이 싹도네"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialConfiguration()
        configureContainerView()
        configureTextField()
        configureButtons(words: newWords)
    }
    
    private func initialConfiguration() {
        hashTagButtons.forEach { $0.isHidden = true }
        descriptionLabel.text = ""
    }
    
    private func configureContainerView() {
        searchContainerView.layer.borderWidth = 3
        searchContainerView.layer.borderColor = UIColor.black.cgColor
    }
    
    private func configureTextField() {
        searchTextField.placeholder = "검색어를 입력하세요."
    }
    
    private func configureButtons(words: [String: String]) {
        for index in 0..<4 {
            hashTagButtons[index].isHidden = false
            hashTagButtons[index].setTitle(words.keys.randomElement(), for: .normal)
            hashTagButtons[index].setTitleColor(.black, for: .normal)
            hashTagButtons[index].layer.cornerRadius = 8
            hashTagButtons[index].layer.borderWidth = 1
            hashTagButtons[index].layer.borderColor = UIColor.black.cgColor
            hashTagButtons[index].contentEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        }
    }
    
    private func showSearchResult() {
        guard searchTextField.hasText,
              let text = searchTextField.text
        else { return }
        
        descriptionLabel.text = newWords[text] ?? "검색 결과가 없습니다."
    }
    
    @IBAction func tapGestureDidTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @IBAction func textFieldDidEndOnExit(_ sender: UITextField) {
        showSearchResult()
    }
    
    @IBAction func searchButtonDidTapped(_ sender: Any) {
        showSearchResult()
        view.endEditing(true)
    }
    
}
