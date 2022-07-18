//
//  ViewController.swift
//  SpecialDay
//
//  Created by taekki on 2022/07/13.
//

import UIKit

struct SpecialDay {
    var dDay: String
    var date: String
    let backgroundImageName: String
    
    static let sampleData: [SpecialDay]  = [
        SpecialDay(dDay: "D+100", date: "2021년 03월 27일", backgroundImageName: "bgImage1"),
        SpecialDay(dDay: "D+200", date: "2021년 07월 05일", backgroundImageName: "bgImage2"),
        SpecialDay(dDay: "D+300", date: "2021년 10월 13일", backgroundImageName: "bgImage3"),
        SpecialDay(dDay: "D+400", date: "2022년 01월 21일", backgroundImageName: "bgImage4")
    ]
}

class ViewController: UIViewController {
    private var specialDays: [SpecialDay] = SpecialDay.sampleData
    private lazy var dateFormatter = DateFormatter()
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet var backgroundImageViews: [UIImageView]!
    @IBOutlet var dDayLabels: [UILabel]!
    @IBOutlet var dateLabels: [UILabel]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initialize()
    }
    
    private func initialize() {
        self.configureUI()
        self.configureDateFormatter()
        self.updateDate(self.datePicker.date)
    }
    
    private func configureUI() {
        self.configureBackgroundImageViews()
        self.configureLabels()
    }
    
    // preferredDatePickerStyle이상에서만 동작하기 때문에 작성해줌.
    @available(iOS 13.4, *)
    private func configureDatePicker() {
        if #available(iOS 14.0, *) {
            self.datePicker.preferredDatePickerStyle = .inline
        } else {
            self.datePicker.preferredDatePickerStyle = .wheels
        }
    }
    
    private func configureBackgroundImageViews() {
        for (index, specialDay) in specialDays.enumerated() {
            self.backgroundImageViews[index].image = UIImage(named: specialDay.backgroundImageName)
            self.backgroundImageViews[index].contentMode = .scaleAspectFill
            self.backgroundImageViews[index].layer.cornerRadius = 10
            self.backgroundImageViews[index].addDimmedView()
        }
    }
    
    private func configureLabels() {
        for (index, specialDay) in specialDays.enumerated() {
            self.dDayLabels[index].text = specialDay.dDay
            self.dDayLabels[index].textColor = .white
            self.dDayLabels[index].font = .boldSystemFont(ofSize: 24)
            self.dateLabels[index].textColor = .white
        }
    }
    
    private func configureDateFormatter() {
        self.dateFormatter.locale = Locale(identifier: "ko_KR")
        self.dateFormatter.dateFormat = "yyyy년 MM월 dd일"
    }
    
    @IBAction func dateValueChanged(_ sender: UIDatePicker) {
        self.updateDate(sender.date)
    }
    
    private func updateDate(_ date: Date) {
        for index in 0..<specialDays.count {
            guard let calculatedDate = datePicker.calendar.date(byAdding: .day,
                                                                value: 100 * (index + 1),
                                                                to: date)
            else { return }
            let newDate = dateFormatter.string(from: calculatedDate)
            self.dateLabels[index].text = newDate
        }
    }
}

extension UIView {
    func addDimmedView() {
        let dimmedView = UIView()
        dimmedView.frame = self.frame
        dimmedView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        self.insertSubview(dimmedView, aboveSubview: self)
    }
}
