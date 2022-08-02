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

import Alamofire
import SwiftyJSON

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var navigationTitleString: String = ""
    var backgroundColor: UIColor = .red
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 연결고리 작업: 테이블 뷰가 해야 할 역할 > 뷰 컨트롤러에게 요청
        searchTableView.delegate = self     // 클래스(SearchViewController)의 인스턴스 자체를 의미
        searchTableView.dataSource = self
        
        // 테이블 뷰가 사용할 테이블뷰 셀(XIB) 등록
        // XIB: xml interface builder <= NIB
        // Literal한 문자열은 제거하자
        searchTableView.register(UINib(nibName: ListTableViewCell.reuseidentifier, bundle: nil), forCellReuseIdentifier: ListTableViewCell.reuseidentifier)
        
        searchBar.delegate = self
        requestBoxOffice(text: "20220801")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.reuseidentifier, for: indexPath) as? ListTableViewCell else {
            return UITableViewCell()
        }
        
        cell.titleLabel.font = .boldSystemFont(ofSize: 22)
        cell.titleLabel.text = "HELLO"
        
        return cell
    }
}

extension SearchViewController {
    private func requestBoxOffice(text: String) {
        let url = "http://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=ba371c92e519dd60e2a78ed1df301638&targetDt=\(text)"
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text,
        (2...8).contains(text.count) else { return } // 옵셔널 바인딩, 8글자, 숫자, 날짜로 변경 시 유효한 형태의 값인 지 등 체크
        requestBoxOffice(text: text)
    }
}
