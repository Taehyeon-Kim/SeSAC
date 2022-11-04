//
//  ToDoItemTableViewCell.swift
//  BasicToDo
//
//  Created by taekki on 2022/11/05.
//

import UIKit


final class ToDoItemTableViewCell: UITableViewCell {
    @IBOutlet var isDone: UISwitch!
    @IBOutlet var itemTitle: UILabel!
    @IBOutlet var updatedAt: UILabel!
    
    var todo: ToDo? {
        didSet {
            guard let todo = todo else { return }
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy.MM.dd HH:mm:ss"

            itemTitle.text = todo.title
            isDone.isOn = todo.done
            updatedAt.text = formatter.string(from: todo.createdAt)
        }
    }

    @IBAction func onToggle() {

    }
}

