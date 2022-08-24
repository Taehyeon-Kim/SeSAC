//
//  ShoppingTableViewController.swift
//  SeSACWeek3
//
//  Created by taekki on 2022/07/20.
//

import UIKit

import PhotosUI
import RealmSwift

class ShoppingTableViewController: UITableViewController {
    
    @IBOutlet weak var imageView: UIImageView! {
        didSet { imageView.contentMode = .scaleAspectFill }
    }
    @IBOutlet weak var selectButton: UIButton!
    @IBOutlet weak var inputTextField: UITextField!
    
    private let database = DataBaseManager.shared
    
    let realm = try! Realm()
    var shoppingList: Results<Shopping>! { didSet { tableView.reloadData() } }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
        
        database.getLocationOfDefaultRealm()
        shoppingList = database.read(Shopping.self)
    }
    
    @IBAction func textFieldInputDidFinish(_ sender: UITextField) {
        addShoppingList()
        resetInputState()
        self.tableView.reloadData()
    }
    
    @IBAction func addButtonDidTap(_ sender: UIButton) {
        guard imageView.image != nil else {
            print("이미지를 추가해주세요.")
            return
        }
        
        guard inputTextField.text != "" else {
            print("항목을 적어주세요.")
            return
        }
    
        addShoppingList()
        resetInputState()
        self.tableView.reloadData()
    }
    
    func resetInputState() {
        imageView.image = nil
        selectButton.setImage(UIImage(systemName: "camera"), for: .normal)
        inputTextField.text = nil
    }
    
    @IBAction func selectImageButtonTapped(_ sender: UIButton) {
        print("click")
        
        var configuration = PHPickerConfiguration()
        configuration.selectionLimit = 1
        configuration.filter = .images
        
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        self.present(picker, animated: true)
    }
    
    func addShoppingList() {
        let task = Shopping(title: inputTextField.text!, createdAt: Date())
        database.write(task)
        database.saveImageFromDocument(fileName: "\(task._id).jpg", image: imageView.image!)
    }
}

extension ShoppingTableViewController: PHPickerViewControllerDelegate, UINavigationControllerDelegate {

    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        
        let itemProvider = results.first?.itemProvider
        if let itemProvider = itemProvider,
           itemProvider.canLoadObject(ofClass: UIImage.self) {
            itemProvider.loadObject(ofClass: UIImage.self) { image, error in
                DispatchQueue.main.sync { [weak self] in
                    self?.imageView.image = image as? UIImage
                    self?.selectButton.setImage(nil, for: .normal)
                }
            }
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
            self.shoppingList = self.database.sort(Shopping.self, by: "isCheck", ascending: false)
        })
        
        let title = UIAction(title: "제목순 정렬", image: nil, handler: { _ in
            self.shoppingList = self.database.sort(Shopping.self, by: "title")
        })
        
        let favorite = UIAction(title: "즐겨찾기 목록만 보기", image: nil, handler: { _ in
            self.shoppingList = self.realm.objects(Shopping.self).filter("isBookmark == true")
        })
        
        let date = UIAction(title: "작성일 기준 정렬", image: nil, handler: { _ in
            self.shoppingList = self.database.sort(Shopping.self, by: "createdAt")
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
        cell.shoppingimageView.image = database.loadImageFromDocument(fileName: "\(shoppingList[indexPath.row]._id).jpg")
        
        let task = shoppingList[indexPath.row]
        
        cell.completionHandler = {
            self.database.update(task) { task in
                task.isCheck = cell.isCheck
                task.isBookmark = cell.isBookmark
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
            self.database.removeImageFromDocument(fileName: "\(self.shoppingList[indexPath.row]._id).jpg")
            self.database.delete(self.shoppingList[indexPath.row])
            self.tableView.reloadData()
        }
    }
}
