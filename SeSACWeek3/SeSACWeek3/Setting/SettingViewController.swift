//
//  SettingViewController.swift
//  SeSACWeek3
//
//  Created by taekki on 2022/07/18.
//

import UIKit

enum SettingType: CaseIterable, CustomStringConvertible {
    case total
    case personal
    case etc

    var contents: [String] {
        switch self {
        case .total:
            return ["공지사항", "실험실", "버전 정보"]
        case .personal:
            return ["개인/보안", "알림", "채팅", "멀티프로필"]
        case .etc:
            return ["고객센터/도움말"]
        }
    }
    
    var numberOfRowInSections: Int {
        return contents.count
    }
    
    var description: String {
        switch self {
        case .total:
            return "전체 설정"
        case .personal:
            return "개인 설정"
        case .etc:
            return "기타"
        }
    }
}

final class SettingViewController: UITableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return SettingType.allCases.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return SettingType.allCases[section].description
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SettingType.allCases[section].numberOfRowInSections
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "settingCell") else { return UITableViewCell() }
        cell.textLabel?.text = SettingType.allCases[indexPath.section].contents[indexPath.row]
        return cell
    }
}
