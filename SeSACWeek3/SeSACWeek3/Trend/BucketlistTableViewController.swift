//
//  BucketlistTableViewController.swift
//  SeSACWeek3
//
//  Created by taekki on 2022/07/19.
//

import UIKit

class BucketlistTableViewController: UITableViewController {
    
    static let identifier = "BucketlistTableViewController"

    var list = ["범죄도시", "탑건", "토르"]
    var placeholder: String?
    
    // 옵셔널 스트링 타입으로 선언하더라도 오류가 뜨지 않는 이유는?
    // placeholder 자체가 옵셔널이라면? o (가능)
    // 하지만 String Interplation이라면? x (컴파일 에러 발생)
    
    @IBOutlet weak var userTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.userTextField.placeholder = "\(placeholder ?? "nil value")"
        
        self.navigationItem.title = "버킷리스트"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(xmarkButtonTapped))
        
        self.tableView.rowHeight = 90
    }
    
    @objc
    func xmarkButtonTapped() {
        self.dismiss(animated: true)
    }
    
    @IBAction func userTextFieldDidFinish(_ sender: UITextField) {
        
        // 중복 영화, white space(공백), 글자 수 제한 처리 등 많은 처리 코드가 붙음
        // string -> trimming character
        
        // ✅ case 2. if let
        if let value = sender.text?.trimmingCharacters(in: .whitespaces),
           !value.isEmpty,
           (2...6).contains(value.count)
        {
            self.list.append(value)
            self.tableView.reloadData()
        } else {
            // 토스트 메시지 띄우기
        }
        
        // ✅ case 3. guard else
        // 해당 구문의 빈도가 high
        guard let value = sender.text?.trimmingCharacters(in: .whitespaces), !value.isEmpty, (2...6).contains(value.count) else {
            return
            // Alert, Toast를 통해 빈칸을 입력했다. 글자수가 많다.
        }
        
        // ✅ case 1.
//        self.list.append(sender.text!)
//        self.tableView.reloadData()
//        self.tableView.reloadSections(IndexSet(), with: .fade)
//        self.tableView.reloadRows(at: [IndexPath(row: 0, section: 0), IndexPath(row: 1, section: 0)], with: .fade)
    }
}

// MARK: - Methods

extension BucketlistTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.list.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BucketlistTableViewCell.identifier, for: indexPath) as! BucketlistTableViewCell
        
        cell.bucketlistLabel.text = self.list[indexPath.row]
        cell.bucketlistLabel.font = .boldSystemFont(ofSize: 18)
        return cell
    }
    
    // 편집 가능한 상태로 만들 수 있음
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // 배열 삭제 후에 테이블 뷰 갱신
            list.remove(at: indexPath.row)
            tableView.reloadSections(IndexSet(0...0), with: .automatic)
        }
    }
    
//    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
//        // 셀 이동
//    }
//
//    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        // 삭제
//    }
//
//    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        // 즐겨찾기 핀 고정
//    }
}
