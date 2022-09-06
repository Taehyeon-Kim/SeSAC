//
//  LocalizableViewController.swift
//  SeSACWeek9
//
//  Created by taekki on 2022/09/06.
//

import UIKit
import CoreLocation
import StoreKit
import MessageUI

final class LocalizableViewController: UIViewController, MFMailComposeViewControllerDelegate {
    
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
        sampleButton.addTarget(self, action: #selector(sendMail), for: .touchUpInside)
        
        CLLocationManager().requestWhenInUseAuthorization()
    }
    
    @objc func sendMail() {
        
        // - 메일을 보낼 수 있는 상황인지
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.setToRecipients(["taekki@taekki.com"])
            mail.setSubject("다이어리 문의사항")
            mail.mailComposeDelegate = self
            present(mail, animated: true)

        } else {
            // 메일 등록을 해주시거나, "~~@~~.com"으로 문의 주세요
            print("alert")
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        
//        switch result {
//        case .cancelled:
//            //
//        case .saved:
//            //
//        case .sent:
//            //
//        case .failed:
//            //
//        }
        controller.dismiss(animated: true)
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
