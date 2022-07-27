//
//  BucketlistTableViewController.swift
//  SeSACWeek3
//
//  Created by taekki on 2022/07/19.
//

import UIKit

struct Todo {
    var title: String
    var done: Bool
}

class BucketlistTableViewController: UITableViewController {
    
    static let identifier = "BucketlistTableViewController"

    // list 프로퍼티가 추가, 삭제 등 변경 되고 나서 테이블뷰를 항상 갱신!
    // 갱신은 didSet으로 처리하는 빈도가 더 높음 = 권장
    var list = [
        Todo(title: "범죄도시2", done: true), Todo(title: "토르", done: false), Todo(title: "탑건", done: false),
        Todo(title: "범죄도시2", done: true), Todo(title: "토르", done: false), Todo(title: "탑건", done: false),
        Todo(title: "범죄도시2", done: true), Todo(title: "토르", done: false), Todo(title: "탑건", done: false),
        Todo(title: "범죄도시2", done: true), Todo(title: "토르", done: false), Todo(title: "탑건", done: false),
        Todo(title: "범죄도시2", done: true), Todo(title: "토르", done: false), Todo(title: "탑건", done: false),
        Todo(title: "범죄도시2", done: true), Todo(title: "토르", done: false), Todo(title: "탑건", done: false),
    ] {
        didSet {
            self.tableView.reloadData()
            print("리스트가 변경됨 \(list), \(oldValue)")
        }
    }
    var placeholder: String?
    
    // 옵셔널 스트링 타입으로 선언하더라도 오류가 뜨지 않는 이유는?
    // placeholder 자체가 옵셔널이라면? o (가능)
    // 하지만 String Interplation이라면? x (컴파일 에러 발생)
    
    // Outlet은 언제 변경이 되는가
    // 필요한 시점에 단 한번 변경이 일어남
    // 클래스는 Ref Type -> 인스턴스 자체를 변경하지 않는 이상 한 번만 될 거다!
    // IBOutlet ViewDidLoad 호출 되기 직전에 nil이 아닌지 nil인지 알 수 있음
    @IBOutlet weak var userTextField: UITextField! {
        didSet {
            userTextField.textAlignment = .center
            userTextField.font = .boldSystemFont(ofSize: 22)
            userTextField.textColor = .systemRed
            print("텍스트 필드 didset")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.userTextField.placeholder = "\(placeholder ?? "nil value")"
        
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
//        if let value = sender.text?.trimmingCharacters(in: .whitespaces),
//           !value.isEmpty,
//           (2...6).contains(value.count)
//        {
//            self.list.append(value)
//            self.tableView.reloadData()
//        } else {
//            // 토스트 메시지 띄우기
//        }
//
//        // ✅ case 3. guard else
//        // 해당 구문의 빈도가 high
//        guard let value = sender.text?.trimmingCharacters(in: .whitespaces), !value.isEmpty, (2...6).contains(value.count) else {
//            return
//            // Alert, Toast를 통해 빈칸을 입력했다. 글자수가 많다.
//        }
        
        // ✅ case 1.
//        self.list.append(sender.text!)
//        self.tableView.reloadData()
//        self.tableView.reloadSections(IndexSet(), with: .fade)
//        self.tableView.reloadRows(at: [IndexPath(row: 0, section: 0), IndexPath(row: 1, section: 0)], with: .fade)
        
        list.append(Todo(title: "마녀", done: false))
    }
}

// MARK: - Methods

extension BucketlistTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.list.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BucketlistTableViewCell.identifier, for: indexPath) as! BucketlistTableViewCell
        
        // 셀의 뷰(UI)와 관련된 요소 처리
        cell.bucketlistLabel.text = self.list[indexPath.row].title
        cell.bucketlistLabel.font = .boldSystemFont(ofSize: 18)
        
        let checkboxButtonImage = self.list[indexPath.row].done ? UIImage(systemName: "checkmark.square.fill") : UIImage(systemName: "checkmark.square")
        cell.checkboxButton.setImage(checkboxButtonImage, for: .normal)
        
        cell.checkboxButton.tag = indexPath.row
        cell.checkboxButton.addTarget(self, action: #selector(checkboxButtonTapped), for: .touchUpInside)
        
        return cell
    }
    
    @objc func checkboxButtonTapped(_ sender: UIButton) {
        print("\(sender.tag) 버튼 클릭")
        
        // 배열 인덱스를 찾아서 done을 바꿔야 한다, 그리고 테이블뷰를 갱신 해야 한다.
        list[sender.tag].done.toggle()
        tableView.reloadRows(at: [IndexPath(row: sender.tag, section: 0)], with: .fade)
        
        
        // 재사용 셀 오류 확인용 코드
        // sender.setImage(UIImage(systemName: "checkmark.square.fill"), for: .normal)
    }
    
    // 편집 가능한 상태로 만들 수 있음
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // 배열 삭제 후에 테이블 뷰 갱신
            list.remove(at: indexPath.row)
//            tableView.reloadSections(IndexSet(0...0), with: .automatic)
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
