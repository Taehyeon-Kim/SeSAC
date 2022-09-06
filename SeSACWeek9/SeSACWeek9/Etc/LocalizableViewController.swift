//
//  LocalizableViewController.swift
//  SeSACWeek9
//
//  Created by taekki on 2022/09/06.
//

import UIKit
import CoreLocation

final class LocalizableViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var myLabel: UILabel!
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var sampleButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "navigation_title".localized
        
        myLabel.text = "introduce".localized(with: "고래밥")
        inputTextField.text = "number_test".localized(with: 12)
        
        searchBar.placeholder = NSLocalizedString("search_placeholder", comment: "")
        
        inputTextField.placeholder = NSLocalizedString("main_age_placeholder", comment: "")
        
        let buttonTitle = NSLocalizedString("common_cancel", comment: "")
        sampleButton.setTitle(buttonTitle, for: .normal)
        
        CLLocationManager().requestWhenInUseAuthorization()
    }
}

extension String {
    
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }

    func localized<T: CVarArg>(with argument: T) -> String {
        return String(format: self.localized, argument)
    }
}
