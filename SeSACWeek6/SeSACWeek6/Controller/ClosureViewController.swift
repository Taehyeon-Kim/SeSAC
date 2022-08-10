//
//  ClosureViewController.swift
//  SeSACWeek6
//
//  Created by taekki on 2022/08/08.
//

import UIKit

final class ClosureViewController: UIViewController {
    
    @IBOutlet weak var cardView: CardView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cardView.posterImageView.backgroundColor = .red
        cardView.likeButton.backgroundColor = .yellow
        cardView.likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
    }
    
    @objc func likeButtonTapped(_ sender: UIButton) {
        print(sender.tag)
    }
    
    @IBAction func colorPickerButtonTapped(_ sender: UIButton) {
        showAlert(title: "컬러 피커를 띄우겠습니까?", message: nil, okTitle: "띄우기") { [weak self] in
            let picker = UIColorPickerViewController()
            self?.present(picker, animated: true)
        }
    }
    
    @IBAction func backgroundColorChanged(_ sender: UIButton) {
        showAlert(title: "배경색을 변경하겠습니까?", message: nil, okTitle: "변경하기") { [weak self] in
            self?.view.backgroundColor = .purple
        }
    }
}

extension UIViewController {
    func showAlert(title: String, message: String?, okTitle: String, okAction: @escaping (() -> ())) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        let ok = UIAlertAction(title: okTitle, style: .default) { action in
            okAction()
        }
        
        alert.addAction(cancel)
        alert.addAction(ok)
        
        present(alert, animated: true)
    }
}
