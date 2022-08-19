//
//  WriteViewController.swift
//  SeSACWeek7+Diary
//
//  Created by taekki on 2022/08/19.
//

import UIKit
import SnapKit

final class WriteViewController: BaseViewController {
    
    var mainView = WriteView()
    
    // MARK: - loadView
    // - 루트뷰 교체
    // - super method(super.loadView()) 호출 금지
    override func loadView() {
        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configure() {
        mainView.titleTextField.addTarget(self, action: #selector(titleTextFieldClicked), for: .editingDidEndOnExit)
    }
    
    @objc func titleTextFieldClicked(_ textField: UITextField) {
        guard let text = textField.text, text.count > 0 else {
            showAlertMessage(title: "제목을 입력해주세요", buttonTitle: "확인")
            return
        }
    }
}
