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
    
    let realm = try! Realm()
    var shoppingList: Results<Shopping>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Get on-disk location of the default Realm
        let realm = try! Realm()
        print("Realm is located at:", realm.configuration.fileURL!)
        
        shoppingList = realm.objects(Shopping.self)
    }
    
    @IBAction func textFieldInputDidFinish(_ sender: UITextField) {
        addShoppingList()
        self.tableView.reloadData()
    }
    
    @IBAction func addButtonDidTap(_ sender: UIButton) {
        addShoppingList()
        self.tableView.reloadData()
    }
    
    func addShoppingList() {
        let task = Shopping(title: inputTextField.text!, createdAt: Date())
        
        try! realm.write {
            realm.add(task)
            print("Realm Succeed")
        }
    }
}

// MARK: - UITableView Methods
extension ShoppingTableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingList != nil ? shoppingList.count : 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShoppingTableViewCell") as! ShoppingTableViewCell
        cell.shoppingListLabel.text = self.shoppingList[indexPath.row].title
        
        cell.completionHandler = {
            try! self.realm.write {
                self.shoppingList[indexPath.row].isCheck = cell.isCheck
                self.shoppingList[indexPath.row].isBookmark = cell.isBookmark
                print("Realm Updated")
            }
        }
        
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
            try! realm.write {
                realm.delete(shoppingList[indexPath.row])
            }
            self.tableView.reloadData()
        }
    }
}
