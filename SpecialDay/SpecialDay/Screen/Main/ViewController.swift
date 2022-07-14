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
    var backgroundImageName: String
    
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
        self.configureUI()
        self.configureDateFormatter()
    }
    
    // UI 관련 코드가 너무 길어졌다...
    private func configureUI() {
        for (index, specialDay) in specialDays.enumerated() {
            let dimmedView = UIView()
            dimmedView.frame = backgroundImageViews.first?.frame ?? CGRect.zero
            dimmedView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
            backgroundImageViews[index].image = UIImage(named: specialDay.backgroundImageName)
            backgroundImageViews[index].layer.opacity = 0.95
            backgroundImageViews[index].insertSubview(dimmedView, aboveSubview: backgroundImageViews[index])
            backgroundImageViews[index].contentMode = .scaleAspectFill
            backgroundImageViews[index].layer.cornerRadius = 10
            dDayLabels[index].text = specialDay.dDay
            dDayLabels[index].textColor = .white
            dDayLabels[index].font = .boldSystemFont(ofSize: 24)
            dateLabels[index].text = specialDay.date
            dateLabels[index].textColor = .white
        }
    }
    
    private func configureDateFormatter() {
        self.dateFormatter.locale = Locale(identifier: "ko_KR")
        self.dateFormatter.dateFormat = "yyyy년 MM월 dd일"
    }
    
    @IBAction func dateValueChanged(_ sender: UIDatePicker) {
        for index in 0..<specialDays.count {
            guard let calculatedDate = datePicker.calendar.date(byAdding: .day, value: 100 * (index + 1), to: self.datePicker.date) else { return }
            let newDate = dateFormatter.string(from: calculatedDate)
            dateLabels[index].text = newDate
        }
    }
}

