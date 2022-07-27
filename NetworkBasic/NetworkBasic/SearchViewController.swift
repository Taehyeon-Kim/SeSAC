//
//  SearchViewController.swift
//  NetworkBasic
//
//  Created by taekki on 2022/07/27.
//

/*
 Swift Protocol
 1. 왼팔 / 오른팔
 - Delegate
 - DataSource
 
 2. 테이블뷰 아웃렛 연결
 3. 1 + 2 연결
 */

import UIKit

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ViewConfigurable {
    
    @IBOutlet weak var searchTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 연결고리 작업: 테이블 뷰가 해야 할 역할 > 뷰 컨트롤러에게 요청
        searchTableView.delegate = self     // 클래스(SearchViewController)의 인스턴스 자체를 의미
        searchTableView.dataSource = self
        
        // 테이블 뷰가 사용할 테이블뷰 셀(XIB) 등록
        // XIB: xml interface builder <= NIB
        // Literal한 문자열은 제거하자
        searchTableView.register(UINib(nibName: ListTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: ListTableViewCell.identifier)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.identifier, for: indexPath) as? ListTableViewCell else {
            return UITableViewCell()
        }
        
        cell.titleLabel.font = .boldSystemFont(ofSize: 22)
        cell.titleLabel.text = "HELLO"
        
        return cell
    }
}
