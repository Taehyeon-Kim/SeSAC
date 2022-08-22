//
//  ShoppingTableViewController.swift
//  SeSACWeek3
//
//  Created by taekki on 2022/07/20.
//

import UIKit
import RealmSwift

class ShoppingTableViewController: UITableViewController {
    
    @IBOutlet weak var inputTextField: UITextField!
    
    private var shoppingList: [String] = [
        "그립톡 구매하기",
        "사이다 구매",
        "아이패드 케이스 최저가 알아보기",
        "양말"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func textFieldInputDidFinish(_ sender: UITextField) {
        self.shoppingList.append(sender.text!)
        self.tableView.reloadData()
    }
    
    @IBAction func addButtonDidTap(_ sender: UIButton) {
        self.shoppingList.append(inputTextField.text!)
        self.tableView.reloadData()
    }
}

// MARK: - UITableView Methods
extension ShoppingTableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.shoppingList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShoppingTableViewCell") as! ShoppingTableViewCell
        cell.shoppingListLabel.text = self.shoppingList[indexPath.row]
        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.shoppingList.remove(at: indexPath.row)
            self.tableView.reloadData()
        }
    }
}
