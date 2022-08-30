//
//  ViewController.swift
//  SeSACWeek9
//
//  Created by taekki on 2022/08/30.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    @IBOutlet weak var lottoLabel: UILabel!
    
    var list: Person = Person(page: 0, totalPages: 0, totalResults: 0, results: [])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        LottoAPIManager.requestLotto(drwNo: 1011) { lotto, error in
            guard let lotto = lotto else { return }
            self.lottoLabel.text = lotto.drwNoDate
        }
        
        PersonAPIManager.requestPerson(query: "Squid") { person, error in
            guard let person = person else { return }
            self.list = person
            self.tableView.reloadData()
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        cell.textLabel?.text = list.results[indexPath.row].knownForDepartment
        cell.detailTextLabel?.text = list.results[indexPath.row].name
        return cell
    }
    
}
