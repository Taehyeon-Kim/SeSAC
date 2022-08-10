//
//  ClosureViewController.swift
//  SeSACWeek6
//
//  Created by taekki on 2022/08/08.
//

import UIKit

final class ClosureViewController: UIViewController {
    
    @IBOutlet weak var purpleView: UIView!
    @IBOutlet weak var cardView: CardView!
    
    // Frame-based
    var sampleButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 위치, 크기, 추가
        /*
         오토리사이징을 오토레이아웃 제약조건처럼 설정해주는 기능이 내부적으로 구현되어 있음
         - 기능은 기본적으로 true, 오토레이아웃을 지정해주면 오토리사이징을 안 쓰겠다. 따라서 false로 상태가 내부적으로 변경됨.
         - 이 기능은 코드로 짜여져 있냐, 인터페이스 기반으로 짜여져 있느냐에 따라서 디폴트값이 달라짐.
         오토리사이징 + 오토레이아웃 = 충돌 발생
         
         코드 기반 UI = true
         인터페이스 빌더 기반 UI = false
         
         autoresizing -> autolayout constraints
         */
        print(purpleView.translatesAutoresizingMaskIntoConstraints)   // true
        print(sampleButton.translatesAutoresizingMaskIntoConstraints) // true
        print(cardView.translatesAutoresizingMaskIntoConstraints)     // false
        
        sampleButton.frame = CGRect(x: 100, y: 400, width: 100, height: 100)
        sampleButton.backgroundColor = .red
        view.addSubview(sampleButton)
        
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
