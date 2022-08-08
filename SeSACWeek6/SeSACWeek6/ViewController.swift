//
//  ViewController.swift
//  SeSACWeek6
//
//  Created by taekki on 2022/08/08.
//

import UIKit

import Alamofire
import SwiftyJSON

// 1. html tag <> </> 기능 활용
// 2. replacing 문자열 대체 메서드
// - 활용도 측면에서 response에서 처리하는 것과 보여지는 cell에서 처리하는 것 중 어느 것이 더 나을까?

/*
 테이블 뷰 셀의 높이 조정
 UITableView.AutomaticDimension
 - 컨텐츠의 양에 따라서 셀 높이가 자유롭게
 - 조건: 레이블 numberOfLines 0
 - 조건: tableview automatic dimension
 - 조건: 레이아웃은 잘 잡아놓아야 한다. 특히 위아래/높이에 대한 관계가 잘 설정되어야 한다.
 */

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var blogList: [String] = []
    var cafeList: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBlog(for: "노을")
        configureTableView()
    }

    func searchBlog(for keyword: String) {
        KakaoAPIManager.shared.callRequest(type: .blog, query: keyword, completion: { json in
            for item in json["documents"].arrayValue {
                let value = item["contents"].stringValue
                    .replacingOccurrences(of: "<b>", with: "")
                    .replacingOccurrences(of: "</b>", with: "")
                
                self.blogList.append(value)
            }
            
            self.searchCafe(for: keyword)
        })
    }
    
    func searchCafe(for keyword: String) {
        KakaoAPIManager.shared.callRequest(type: .blog, query: keyword, completion: { json in
            for item in json["documents"].arrayValue {
                let value = item["contents"].stringValue
                    .replacingOccurrences(of: "<b>", with: "")
                    .replacingOccurrences(of: "</b>", with: "")
                
                self.cafeList.append(value)
            }
            
            print(self.blogList)
            print(self.cafeList)
            
            self.tableView.reloadData()
        })
    }
}

extension ViewController {
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        // 모든 섹션의 셀에 대해서 유동적으로 높이를 설정하고 싶다.
        tableView.rowHeight = UITableView.automaticDimension
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // 분기 처리를 해서도 조정할 수 있다.
        // 더 우선적으로 호출된다. (메서드가 우선한다. - viewDidLoad에서 호출되는 것과 비교했을 때!!)
        return UITableView.automaticDimension
    }
}

extension ViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? blogList.count : cafeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "KakaoCell", for: indexPath) as? KakaoCell else {
            return UITableViewCell()
        }
        cell.testLabel.text = indexPath.section == 0 ? blogList[indexPath.row] : cafeList[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "블로그 검색 결과" : "카페 검색 결과"
    }
}

final class KakaoCell: UITableViewCell {
    @IBOutlet weak var testLabel: UILabel!
}
