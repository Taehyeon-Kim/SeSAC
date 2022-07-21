//
//  SearchViewController.swift
//  Library
//
//  Created by taekki on 2022/07/21.
//

import UIKit

final class SearchViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
}

extension SearchViewController {
    private func configureNavigationBar() {
        self.title = "검색 화면"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(xmarkButtonTapped))
    }
    
    @objc func xmarkButtonTapped() {
        self.dismiss(animated: true)
    }
}
