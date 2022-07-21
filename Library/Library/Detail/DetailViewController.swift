//
//  DetailViewController.swift
//  Library
//
//  Created by taekki on 2022/07/21.
//

import UIKit

final class DetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.configureNavigationBar()
    }
}

extension DetailViewController {
    private func configureNavigationBar() {
        self.title = "상세 화면"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(backButtonTapped))
    }
    
    @objc func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
}

