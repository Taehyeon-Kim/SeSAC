//
//  WebViewController.swift
//  Library
//
//  Created by taekki on 2022/07/21.
//

import UIKit

final class WebViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.configureNavigationBar()
    }
}

extension WebViewController {
    private func configureNavigationBar() {
        self.title = "웹 화면"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(backButtonTapped))
    }
    
    @objc func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
}
