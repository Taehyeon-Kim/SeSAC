//
//  NewsViewController.swift
//  SeSACWeek1617
//
//  Created by taekki on 2022/10/20.
//

import UIKit

final class NewsViewController: UIViewController {
    
    var viewModel = NewsViewModel()
    
    @IBOutlet weak var numberTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bind()
        addTarget()
    }
    
    // numberTextField.text = "3000"
    private func bind() {
        viewModel.pageNumber.bind { value in
            print("bind == \(value)")
            self.numberTextField.text = value
        }
    }
    
    private func addTarget() {
        numberTextField.addTarget(
            self,
            action: #selector(numberTextFieldChanged),
            for: .editingChanged
        )
    }
}

extension NewsViewController {
    // 이벤트, 액션
    @objc func numberTextFieldChanged() {
        guard let text = numberTextField.text else { return }
        viewModel.changePageNumberFormat(of: text)
    }
}
