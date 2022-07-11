//
//  ViewController.swift
//  EmotionDiary
//
//  Created by taekki on 2022/07/11.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Properties
    
    private let titles: [String] = [
        "행복해", "사랑해", "좋아해",
        "화가나", "속상해", "안도해",
        "당황해", "짜증나", "눈물나"
    ]
    
    private var emotionCount: [Int] = [
        0, 0, 0,
        0, 0, 0,
        0, 0, 0
    ]
    
    // MARK: - Outlets

    @IBOutlet var emotionIconButtons: [UIButton]!
    @IBOutlet var emotionTitleLabels: [UILabel]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureUI()
    }
}

// MARK: - Functions

extension ViewController {

    private func configureUI() {
        for (index, emotionTitleLabel) in emotionTitleLabels.enumerated() {
            emotionTitleLabel.text = titles[index] + "\(emotionCount[index])"
        }
    }

    @IBAction func emotionButtonDidTapped(_ sender: UIButton) {
        let index = sender.tag
        self.emotionCount[index] += 1
        emotionTitleLabels[index].text = titles[index] + "\(self.emotionCount[index])"
    }
}
