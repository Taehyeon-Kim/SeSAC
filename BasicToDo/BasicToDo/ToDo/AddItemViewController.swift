//
//  AddItemViewController.swift
//  BasicToDo
//
//  Created by taekki on 2022/11/05.
//

import UIKit

final class AddItemViewController: UIViewController {
    
    var createdItem: ((String, Date) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        itemTitle.becomeFirstResponder()
    }

    @IBOutlet var itemTitle: UITextView!

    @IBAction func onDone() {
        createdItem?(itemTitle.text ?? "", Date())
        dismiss(animated: true, completion: nil)
    }
}

extension AddItemViewController {
    
}
