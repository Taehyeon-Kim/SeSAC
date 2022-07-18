//
//  MainViewController.swift
//  Lab
//
//  Created by taekki on 2022/07/18.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var dateLabel2: UILabel!
    @IBOutlet var dateLabelCollection: [UILabel]!
    
    @IBOutlet weak var yellowViewLeadingConstant: NSLayoutConstraint!
    
    let format = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        format.dateFormat = "YYYY/MM/dd"
        yellowViewLeadingConstant.constant = 120
    }
    
    func configureLabelDesign() {
        // 1. Outlet Collection (ex. UIView)
        for dateLabel in dateLabelCollection {
            dateLabel.font = .boldSystemFont(ofSize: 20)
            dateLabel.textColor = .blue
        }
        
        dateLabelCollection[0].text = "첫번째 텍스트"
        dateLabelCollection[1].text = "두번째 텍스트"
        
        // 2. UILabel
        let labelArray = [dateLabel, dateLabel2]
        for dateLabel in labelArray {
            dateLabel?.font = .boldSystemFont(ofSize: 20)
            dateLabel?.textColor = .blue
        }
        
        dateLabel.text = "첫번째 텍스트"
        dateLabel2.text = "두번째 텍스트"
    }
    
    @IBAction func datePickerValueChanged(_ sender: UIDatePicker) {
        let format = DateFormatter()
        format.dateFormat = "YYYY.MM.dd"
        
        dateLabel.text = format.string(from: sender.date)
    }
}
