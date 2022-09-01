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
    
    private var viewModel = PersonViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let example = User("태현")
        example.bind { value in
            print("이름이 \(value)으로 수정되었습니다.")
        }
        example.value = "칙촉"
        
        let sample = User([1, 2, 3, 4, 5])
        sample.bind { numbers in
            print(numbers)
        }
        sample.value = [1, 2]
        
        
        var number1 = 10
        var number2 = 3
        print(number1 - number2)
        
        number1 = 3
        number2 = 1
        
        var number3 = Observable(10)
        var number4 = Observable(3)
        
        number3.bind { a in
            print("Observable", number3.value - number4.value)
        }
        
        number3.value = 100
        number3.value = 200
        number3.value = 50

        viewModel.fetchPerson(query: "kim")
        
        viewModel.list.bind { person in
            print("viewController bind")
            self.tableView.reloadData()
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        
        let data = viewModel.cellForRowAt(at: indexPath)
        cell.textLabel?.text = data.knownForDepartment
        cell.detailTextLabel?.text = data.name
        return cell
    }
    
}
