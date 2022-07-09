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
    
    private var newWords: [String] = ["윰차", "실매", "만만잘부"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialConfiguration()
        configureContainerView()
        configureTextField()
        configureButtons(words: newWords)
    }
    
    private func initialConfiguration() {
        hashTagButtons.forEach { $0.isHidden = true }
    }
    
    private func configureContainerView() {
        searchContainerView.layer.borderWidth = 3
        searchContainerView.layer.borderColor = UIColor.black.cgColor
    }
    
    private func configureTextField() {
        searchTextField.placeholder = "검색어를 입력하세요."
    }
    
    private func configureButtons(words: [String]) {
        for (index, word) in words.enumerated() {
            hashTagButtons[index].isHidden = false
            hashTagButtons[index].setTitle(word, for: .normal)
            hashTagButtons[index].setTitleColor(.black, for: .normal)
            hashTagButtons[index].layer.cornerRadius = 8
            hashTagButtons[index].layer.borderWidth = 1
            hashTagButtons[index].layer.borderColor = UIColor.black.cgColor
            hashTagButtons[index].contentEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        }
    }
}
