//
//  WriteView.swift
//  SeSACWeek7+Diary
//
//  Created by taekki on 2022/08/19.
//

import UIKit
import SnapKit

// MARK: - 뷰와 관련된 작업을 UIView를 상속 받는 쪽에서 처리하도록 변경
final class WriteView: BaseView {
    
    // MARK: - 뷰 객체 선언 등록
    
    let photoImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.backgroundColor = .lightGray
        return view
    }()
    
    let titleTextField: UITextField = {
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

    override func configureUI() {
        [photoImageView, titleTextField, dateTextField, contentTextView].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        photoImageView.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide)
            $0.leadingMargin.equalTo(20)
            $0.trailingMargin.equalTo(-20)
            $0.height.equalTo(self).multipliedBy(0.3)
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
            $0.bottom.equalTo(self.safeAreaLayoutGuide)
        }
    }
}
