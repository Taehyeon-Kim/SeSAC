//
//  SimpleTableViewController.swift
//  SeSACWeek1617
//
//  Created by taekki on 2022/10/18.
//

import UIKit

final class SimpleTableViewController: UITableViewController {

    private let burgers = ["슈비버거", "프랭크", "자갈치", "고래밥"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.separatorInset = .zero
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return burgers.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        var content = cell.defaultContentConfiguration()
        content.image = UIImage(systemName: "heart.fill")
        content.text = burgers[indexPath.row]
        content.secondaryText = "Detail"
        cell.contentConfiguration = content
        
        return cell
    }
}
