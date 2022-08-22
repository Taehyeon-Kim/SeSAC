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
import RealmSwift
import SwiftyJSON
import JGProgressHUD

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var navigationTitleString: String = ""
    var backgroundColor: UIColor = .red
    var list: [BoxOfficeModel] = []
    let hud = JGProgressHUD()
    lazy var dateFormatter = DateFormatter()
    
    let realm = try! Realm()
    var tasks: Results<BoxOfficeModel>!
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Realm is located at:", realm.configuration.fileURL!)
        
        // 연결고리 작업: 테이블 뷰가 해야 할 역할 > 뷰 컨트롤러에게 요청
        searchTableView.delegate = self     // 클래스(SearchViewController)의 인스턴스 자체를 의미
        searchTableView.dataSource = self
        
        // 테이블 뷰가 사용할 테이블뷰 셀(XIB) 등록
        // XIB: xml interface builder <= NIB
        // Literal한 문자열은 제거하자
        searchTableView.register(UINib(nibName: ListTableViewCell.reuseidentifier, bundle: nil), forCellReuseIdentifier: ListTableViewCell.reuseidentifier)
        
        searchBar.delegate = self

        // 데이터 로드(Read)
        tasks = realm.objects(BoxOfficeModel.self)
        
        // 처음 실행일때만 네트워크 콜해서 정보 가져오고 저장하기
        // 처음 실행일때 == tasks 비어있을때
        if let tasks = tasks,
           tasks.isEmpty {
            let yesterdayDateString = getYesterdayDate()
            requestBoxOffice(text: yesterdayDateString)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks != nil ? tasks.count : list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.reuseidentifier, for: indexPath) as? ListTableViewCell else {
            return UITableViewCell()
        }
        
        let data = tasks != nil ? tasks[indexPath.row] : list[indexPath.row]
        cell.titleLabel.font = .boldSystemFont(ofSize: 22)
        cell.titleLabel.text = "\(data.movieTitle): \(data.releaseDate)"
        
        return cell
    }
}

extension SearchViewController {
    private func requestBoxOffice(text: String) {
        hud.show(in: self.view)
        list.removeAll()
        searchTableView.reloadData()
        
        let url = "\(EndPoint.boxOfficeURL)key=\(APIKey.BOXOFFICE)&targetDt=\(text)"
        AF.request(url, method: .get).validate().responseData { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                for movie in json["boxOfficeResult"]["dailyBoxOfficeList"].arrayValue {
                    let movieNm = movie["movieNm"].stringValue
                    let openDt = movie["openDt"].stringValue
                    let audiCnt = movie["audiCnt"].stringValue
                    let data = BoxOfficeModel(movieTitle: movieNm, releaseDate: openDt, audienceCount: audiCnt)
                    try! self.realm.write {
                        self.realm.add(data)
                    }
                    self.list.append(data)
                }
                
                self.searchTableView.reloadData()
                self.hud.dismiss(animated: true)
                
            case .failure(let error):
                print(error)
            }
        }
        
        print("call")
    }
    
    func getYesterdayDate() -> String {
        // Date DateFormatter Calendar
        let currentDate = Date()
//        let yesterdayDate = currentDate.addingTimeInterval(3600 * -24)
        let yesterdayDate = Calendar.current.date(byAdding: .day, value: -1, to: currentDate)
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.dateFormat = "yyyyMMdd"
        let yesterdayDateString = dateFormatter.string(from: yesterdayDate ?? currentDate)
        return yesterdayDateString
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text,
        (2...8).contains(text.count) else { return } // 옵셔널 바인딩, 8글자, 숫자, 날짜로 변경 시 유효한 형태의 값인 지 등 체크
        requestBoxOffice(text: text)
    }
}
