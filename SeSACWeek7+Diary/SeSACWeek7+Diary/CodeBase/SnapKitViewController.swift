//
//  SnapKitViewController.swift
//  SeSACWeek7+Diary
//
//  Created by taekki on 2022/08/17.
//

import UIKit

import SnapKit

final class SnapKitViewController: UIViewController {
    
    // 변경이 일어나지 않은 UI 요소에 대하여
    // 1. viewDidLoad 시점에 UI를 적용할 것인가?
    // 2. 인스턴스를 등록할 때 부터 UI를 적용할 것인가? - 뷰 객체를 클로저 형태로 반환하는 형태로 활용
    
    let photoImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.backgroundColor = .lightGray
        return view
    }()
    
    let titleTextField: UITextField = {
        print("뷰 객체에 등록")
        let view = UITextField()
        view.borderStyle = .none
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 1
        view.placeholder = "제목을 입력해주세요"
        view.textAlignment = .center
        view.font = .boldSystemFont(ofSize: 15)
        return view
    }()
    
    let dateTextField: UITextField = {
        let view = UITextField()
        view.borderStyle = .none
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 1
        view.placeholder = "날짜를 입력해주세요"
        view.textAlignment = .center
        view.font = .boldSystemFont(ofSize: 15)
        return view
    }()
    
    let contentTextView: UITextView = {
        let view = UITextView()
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 1
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        print(#function, "viewDidLoad")
        configureUI()
    }
    
    func configureUI() {
        
        // for - in vs forEach
        // Collection을 순회
        [photoImageView, titleTextField, dateTextField, contentTextView].forEach {
            view.addSubview($0)
        }
        
        photoImageView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leadingMargin.equalTo(20)
            $0.trailingMargin.equalTo(-20)
            $0.height.equalTo(view).multipliedBy(0.3)
        }

        titleTextField.snp.makeConstraints {
            $0.top.equalTo(photoImageView.snp.bottom).offset(20)
            $0.leadingMargin.equalTo(20)
            $0.trailingMargin.equalTo(-20)
            $0.height.equalTo(50)
        }
        
        dateTextField.snp.makeConstraints {
            $0.top.equalTo(titleTextField.snp.bottom).offset(20)
            $0.leadingMargin.equalTo(20)
            $0.trailingMargin.equalTo(-20)
            $0.height.equalTo(50)
        }
        
        contentTextView.snp.makeConstraints {
            $0.top.equalTo(dateTextField.snp.bottom).offset(20)
            $0.leadingMargin.equalTo(20)
            $0.trailingMargin.equalTo(-20)
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}
