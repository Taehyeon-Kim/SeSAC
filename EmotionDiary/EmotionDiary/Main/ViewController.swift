//
//  ViewController.swift
//  EmotionDiary
//
//  Created by taekki on 2022/07/11.
//

import UIKit

enum EmotionType: String, CaseIterable {
    case happy = "행복해"
    case love = "사랑해"
    case like = "좋아해"
    case angry = "화가나"
    case worry = "속상해"
    case relief = "안도해"
    case confused = "당황해"
    case annoying = "짜증나"
    case crying = "눈물나"
}

struct Emotion {
    private let title: String
    private(set) var emotionCount: Int = 0
    private(set) var emotionType: EmotionType
    
    init(title: String, emotionType: EmotionType) {
        self.title = title
        self.emotionType = emotionType
    }
    
    mutating func increaseEmotionCount() {
        self.emotionCount += 1
    }
}

class ViewController: UIViewController {
    
    // MARK: - Properties
    
    private var emotions: [Emotion] = []
    
    // MARK: - Outlets

    @IBOutlet var emotionIconButtons: [UIButton]!
    @IBOutlet var emotionTitleLabels: [UILabel]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initialSetup()
        self.configureUI()
        self.configureButtonTags()
    }
}

// MARK: - Functions

extension ViewController {
    
    private func initialSetup() {
        for emotionType in EmotionType.allCases {
            let emotion = Emotion(title: emotionType.rawValue, emotionType: emotionType)
            self.emotions.append(emotion)
        }
    }

    private func configureUI() {
        for (index, emotionTitleLabel) in emotionTitleLabels.enumerated() {
            emotionTitleLabel.text = self.configureEmotionTitleLabel(for: index)
        }
    }
    
    private func configureButtonTags() {
        for (index, button) in emotionIconButtons.enumerated() {
            button.tag = index
        }
    }

    @IBAction func emotionButtonDidTapped(_ sender: UIButton) {
        let index = sender.tag
        self.emotions[index].increaseEmotionCount()
        emotionTitleLabels[index].text = self.configureEmotionTitleLabel(for: index)
    }
    
    private func configureEmotionTitleLabel(for index: Int) -> String {
        self.emotions[index].emotionType.rawValue + "\(self.emotions[index].emotionCount)"
    }
}
