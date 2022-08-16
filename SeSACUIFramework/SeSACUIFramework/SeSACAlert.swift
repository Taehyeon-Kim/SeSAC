//
//  SeSACAlert.swift
//  SeSACUIFramework
//
//  Created by taekki on 2022/08/16.
//

import UIKit

extension UIViewController {
    
    @objc open func testOpen() {}
    
    public func showSeSACAlert(title: String, message: String, buttonTitle: String, buttonAction: @escaping ((UIAlertAction) -> ())) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        let confirm = UIAlertAction(title: buttonTitle, style: .default, handler: buttonAction)
        
        alert.addAction(cancel)
        alert.addAction(confirm)
        
        present(alert, animated: true)
    }
    
    internal func testInternal() {}
    
    fileprivate func testFilePrivate() {}
    
    private func testPrivate() {}
}
