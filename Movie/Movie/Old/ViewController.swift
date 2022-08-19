//
//  ViewController.swift
//  Movie
//
//  Created by taehy.k on 2022/07/06.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet var posterImageViews: [UIImageView]!
    
    private let posters: [String] = [
        "7번방의선물", "겨울왕국2", "괴물", "국제시장",
        "극한직업", "도둑들", "명량", "베테랑",
        "부산행", "신과함께인과연", "신과함께죄와벌", "아바타",
        "알라딘", "암살", "어벤져스엔드게임", "왕의남자",
        "태극기휘날리며", "택시운전사", "해운대"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        posterImageViews.forEach {
            $0.layer.cornerRadius = $0.frame.width / 2
            $0.layer.borderWidth = 2.0
            $0.layer.borderColor = UIColor.systemGray3.cgColor
        }
    }
    
    @IBAction func playButtonDidTapped(_ sender: Any) {
        backgroundImageView.image = UIImage(named: posters.randomElement() ?? "알라딘")
        posterImageViews.forEach {
            $0.image = UIImage(named: posters.randomElement() ?? "알라딘")
        }
    }
}

