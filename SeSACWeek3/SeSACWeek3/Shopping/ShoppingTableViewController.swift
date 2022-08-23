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
    var shoppingList: Results<Shopping>! { didSet { tableView.reloadData() } }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
        
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

extension ShoppingTableViewController {

    func configureNavigationBar() {
        let sortItem = UIBarButtonItem(
            image: UIImage(systemName: "slider.horizontal.3"),
            style: .plain,
            target: self,
            action: nil
        )
        
        let todo = UIAction(title: "한 일 기준 정렬", image: nil, handler: { _ in
            self.shoppingList = self.realm.objects(Shopping.self).sorted(byKeyPath: "isCheck", ascending: false)
        })
        
        let title = UIAction(title: "제목순 정렬", image: nil, handler: { _ in
            self.shoppingList = self.realm.objects(Shopping.self).sorted(byKeyPath: "title", ascending: true)
        })
        
        let favorite = UIAction(title: "즐겨찾기 목록만 보기", image: nil, handler: { _ in
            self.shoppingList = self.realm.objects(Shopping.self).filter("isBookmark == true")
//            self.shoppingList = self.realm.objects(Shopping.self).sorted(byKeyPath: "isBookmark", ascending: false)
        })
        
        let date = UIAction(title: "작성일 기준 정렬", image: nil, handler: { _ in
            self.shoppingList = self.realm.objects(Shopping.self).sorted(byKeyPath: "createdAt", ascending: true)
        })
        
        sortItem.menu = UIMenu(
            title: "",
            image: UIImage(systemName: "heart.fill"),
            identifier: nil,
            options: .displayInline,
            children: [todo, title, favorite, date]
        )
        
        navigationItem.rightBarButtonItems = [sortItem]
    }
}

// MARK: - UITableView Methods
extension ShoppingTableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingList != nil ? shoppingList.count : 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShoppingTableViewCell") as! ShoppingTableViewCell
        cell.shoppingListLabel.text = shoppingList[indexPath.row].title
        cell.isCheck = shoppingList[indexPath.row].isCheck
        cell.isBookmark = shoppingList[indexPath.row].isBookmark
        
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
