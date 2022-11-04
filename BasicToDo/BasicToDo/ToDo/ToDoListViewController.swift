//
//  ToDoListViewController.swift
//  BasicToDo
//
//  Created by taekki on 2022/11/05.
//

import UIKit
import Swinject

final class ToDoListViewController: UITableViewController {
    
    private let service = Inject(ToDoService.self)!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CreateNewItem", let toVC = segue.destination as? AddItemViewController {
            toVC.createdItem = { [weak self] title, createdAt in
                //2.
                self?.service.create(withTitle: title)
                self?.tableView.reloadData()
            }
        }
    }
}

extension ToDoListViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return service.count()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath) as? ToDoItemTableViewCell else {
            fatalError("tableViewCell has not dequeued!")
        }

        let item = service.item(at: indexPath.row)
        cell.todo = item
        
        return cell
    }
}
