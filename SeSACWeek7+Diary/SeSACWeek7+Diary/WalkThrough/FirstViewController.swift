//
//  FirstViewController.swift
//  SeSACWeek7+Diary
//
//  Created by taekki on 2022/08/16.
//

import UIKit

final class FirstViewController: UIViewController {
    
    @IBOutlet weak var tutorialLabel: UILabel!
    @IBOutlet weak var starImageView: UIImageView!
    @IBOutlet weak var blackView: UIView!
    @IBOutlet weak var blackViewConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        starImageView.image = UIImage(systemName: "star.fill")
        
        tutorialLabel.numberOfLines = 0
        tutorialLabel.alpha = 0
        tutorialLabel.font = .boldSystemFont(ofSize: 24)
        tutorialLabel.backgroundColor = .red
        tutorialLabel.text = """
        일기를 씁시다.
        잘 써봅시다.
        """
        
        blackView.backgroundColor = .black
        blackView.alpha = 0

        UIView.animate(withDuration: 3) {
            self.tutorialLabel.alpha = 1
            self.tutorialLabel.backgroundColor = .yellow
            
        } completion: { _ in
            self.animateBlackView()
            self.animateImageView()
        }
    }
    
    func animateBlackView() {
        UIView.animate(withDuration: 2) {
            self.blackView.transform = CGAffineTransform(scaleX: 3, y: 0.8)
            self.blackView.alpha = 1
            
        } completion: { _ in

        }
    }
    
    func animateImageView() {
        UIView.animate(withDuration: 1, delay: 1, options: [.repeat, .autoreverse]) {
            self.starImageView.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        }
    }
}
