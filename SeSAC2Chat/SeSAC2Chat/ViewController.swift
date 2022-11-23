//
//  ViewController.swift
//  SeSAC2Chat
//
//  Created by jack on 2022/11/21.
//

import UIKit
import Alamofire

/*
 - 과거의 채팅 내용 - DB
 +-----------+      +-----------+      +---------------+
 |.DB(Realm).| ===> |  .fetch.  | ===> | Socket server |
 +-----------+      +-----------+      +---------------+
 */

/// scrollToBottom
/// pagenation + database
class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var contentTextField: UITextField!
    
    // var dummy: [String] = []
    var chat: [Chat] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // dummyChat()
        
        fetchChats()
        configureTableView()
        
        SocketIOManager.shared.listener = { [weak self] dict in
            print("🚕", dict)
            self?.getMessage(dict: dict)
        }
    }
    
    func getMessage(dict: NSDictionary) {
            
        let chat = dict["chat"] as! String
        let name = dict["name"] as! String
        let createdAt = dict["createdAt"] as! String
        let userID = dict["userId"] as! String
        
        let value = Chat(text: chat, userID: userID, name: name, username: "", id: "", createdAt: createdAt, updatedAt: "", v: 0, ID: "")
        
        self.chat.append(value)
        tableView.reloadData()
        tableView.scrollToRow(at: IndexPath(row: self.chat.count - 1, section: 0), at: .bottom, animated: false)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        SocketIOManager.shared.closeConnection()
    }
    
    @IBAction func sendButtonClicked(_ sender: UIButton) {
        postChat(text: contentTextField.text ?? "")
        contentTextField.text?.removeAll()
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print ("enter")
        return true
    }
}
    
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chat.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // let data = dummy[indexPath.row]
        let data = chat[indexPath.row]
         
        // if indexPath.row.isMultiple(of: 2) {
        if data.userID == APIKey.userId {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MyChatTableViewCell", for: indexPath) as! MyChatTableViewCell
            cell.chatLabel.text = data.text
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "YourChatTableViewCell", for: indexPath) as! YourChatTableViewCell
            cell.chatLabel.text = data.text
            cell.profileNameLabel.text = data.name
            return cell
        }
    }
    
}

extension ViewController {
    
    // private func dummyChat() {
    //     dummy = ["안녕하세요", "반갑습니다", "별명이 왜 고래밥인가요?", "세상에서\n고래밥 과자가 젤\n맛있더라구요", "아..."]
    // }
    
    private func fetchChats() {
        let header: HTTPHeaders = [
            "Authorization": "Bearer \(APIKey.header)",
            "Content-Type": "application/json"
        ]

        AF.request(APIKey.url, method: .get, headers: header).responseDecodable(of: [Chat].self) { [weak self] response in
            switch response.result {
            case .success(let value):
                self?.chat = value
                self?.tableView.reloadData()
                self?.tableView.scrollToRow(at: IndexPath(row: self!.chat.count - 1, section: 0), at: .bottom, animated: false)
                
                /// 쌓여있는 데이터를 모두 처리한 뒤 소켓 통신 시작
                /// ex) 카카오톡 안 읽은 메시지 처리 후에 통신 시작 (시점 맞추기 위해)
                SocketIOManager.shared.establishConnection()
                
            case .failure(let error):
                print("FAIL", error)
            }
        }
    }
    
    private func postChat(text: String) {
        let header: HTTPHeaders = [
            "Authorization": "Bearer \(APIKey.header)",
            "Content-Type": "application/json"
        ]
        AF.request(APIKey.url, method: .post, parameters: ["text": text], encoder: JSONParameterEncoder.default, headers: header).responseString { data in
            print("POST CHAT SUCCEED", data)
        }
    }
}
