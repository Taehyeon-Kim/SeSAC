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
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return burgers.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        cell.textLabel?.text = burgers[indexPath.row]
        return cell
    }
}
