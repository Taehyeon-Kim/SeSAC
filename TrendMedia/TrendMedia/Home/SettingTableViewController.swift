//
//  SettingTableViewController.swift
//  TrendMedia
//
//  Created by taekki on 2022/07/18.
//

import UIKit

class SettingTableViewController: UITableViewController {
    
    var birthdatFriends = ["뽀로로", "신데렐라", "올라프", "스노기", "모구리", "고래밥"]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.rowHeight = 80
    }
    
    // 섹션의 개수는 default가 1 (그렇기 때문에 선택적인 요소이다)
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        switch section {
        case 0:
            return "생일인 친구"
        case 1:
            return "두 번째 헤더"
        case 2:
            return "세 번째 헤더"
        default:
            return ""
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return "푸터"
    }

    // 1. 셀의 갯수 (필수) : numberOfRowsInSection
    // ex. 카톡 100명 > 셀 100개, 3000명 > 셀 3000개
    // 섹션의 수와 행의 수는 다르다.
    // iOS 시스템에게 정보 전달
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return birthdatFriends.count
        } else if section == 1 {
            return 2
        } else if section == 2 {
            return 10
        } else {
            return 0
        }
    }
    
    // 2. 셀의 디자인과 데이터 (필수) : cellForRowAt
    // ex. 카톡 이름, 프로필 사진, 상태 메시지 등 - 데이터가 셀마다 각각 다름
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        print("cell for row at", indexPath)
        
        if indexPath.section == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "rightDetailCell")!
            cell.textLabel?.text = "2번째 인덱스 섹션의 텍스트"
            cell.textLabel?.textColor = .brown
            cell.textLabel?.font = .boldSystemFont(ofSize: 15)
            cell.detailTextLabel?.text = "디테일 레이블"
            
            // 간단한 조건 판단의 경우 삼항 연산자를 사용해도 괜찮을 것 같다.
            // 너무 남용해서는 안될 것.
            cell.imageView?.image = indexPath.row % 2 == 0 ? UIImage(systemName: "star") : UIImage(systemName: "star.fill")
            cell.backgroundColor = indexPath.row % 2 == 0 ? .white : .systemGray6
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "settingCell")!
            if indexPath.section == 0 {
                cell.textLabel?.text = birthdatFriends[indexPath.row]
                cell.textLabel?.textColor = .systemGreen
                cell.textLabel?.font = .boldSystemFont(ofSize: 20)
            } else if indexPath.section == 1 {
                cell.textLabel?.text = "1번째 인덱스 섹션의 텍스트"
                cell.textLabel?.textColor = .systemPink
                cell.textLabel?.font = .italicSystemFont(ofSize: 25)
            }
            return cell
        }
    }
    
    // 셀의 높이(옵션, 빈도 높은) (feat. tableView.rowHeight)
    // 함수의 우선 순위가 더 높다. 동적으로 높이 조정할 가능성이 더 높기 때문
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
