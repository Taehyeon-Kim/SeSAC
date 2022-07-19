//
//  BucketlistTableViewController.swift
//  SeSACWeek3
//
//  Created by taekki on 2022/07/19.
//

import UIKit

class BucketlistTableViewController: UITableViewController {

    var list = ["범죄도시", "탑건", "토르"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 90
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.list.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: BucketlistTableViewCell.self), for: indexPath) as! BucketlistTableViewCell
        cell.bucketlistLabel.text = self.list[indexPath.row]
        cell.bucketlistLabel.font = .boldSystemFont(ofSize: 18)
        return cell
    }
}
