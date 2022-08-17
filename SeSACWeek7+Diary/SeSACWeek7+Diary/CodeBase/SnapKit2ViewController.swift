//
//  SnapKit2ViewController.swift
//  SeSACWeek7+Diary
//
//  Created by taekki on 2022/08/17.
//

import UIKit

class SnapKit2ViewController: UIViewController {
    
    let blackView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    let redView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        return view
    }()
    
    let yellowView: UIView = {
        let view = UIView()
        view.backgroundColor = .yellow
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        [redView, blackView].forEach {
            view.addSubview($0)
        }
        
        redView.addSubview(yellowView) // cf) containerView, stackView -> 다른 메서드 사용 바람
        
        redView.snp.makeConstraints {
            $0.width.height.equalTo(200)
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.centerX.equalTo(view)
        }
        
        blackView.snp.makeConstraints {
            $0.edges.equalTo(redView).inset(50)
        }
    }
}
