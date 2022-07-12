//
//  SegmentedViewController.swift
//  SeSACWeek2
//
//  Created by taekki on 2022/07/12.
//

import UIKit

enum MusicType: Int {
    case all = 0
    case korea
    case other
}

class SegmentedViewController: UIViewController {

    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        segmentControlValueChanged(segmentControl)
    }
    
    @IBAction func segmentControlValueChanged(_ sender: UISegmentedControl) {
        
        if segmentControl.selectedSegmentIndex == MusicType.all.rawValue {
            resultLabel.text = "첫번째 세그먼트 선택"
        } else if segmentControl.selectedSegmentIndex == MusicType.korea.rawValue {
            resultLabel.text = "두번째 세그먼트 선택"
        } else if segmentControl.selectedSegmentIndex == MusicType.other.rawValue {
            resultLabel.text = "세번째 세그먼트 선택"
        } else {
            resultLabel.text = "오류"
        }
        
//        if segmentControl.selectedSegmentIndex == 0 {
//            resultLabel.text = "첫번째 세그먼트 선택"
//        } else if segmentControl.selectedSegmentIndex == 1 {
//            resultLabel.text = "두번째 세그먼트 선택"
//        } else if segmentControl.selectedSegmentIndex == 2 {
//            resultLabel.text = "세번째 세그먼트 선택"
//        } else {
//            resultLabel.text = "오류"
//        }
    }
}
