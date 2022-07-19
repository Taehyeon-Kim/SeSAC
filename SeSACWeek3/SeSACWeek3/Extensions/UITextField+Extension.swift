//
//  UITextField+Extension.swift
//  SeSACWeek3
//
//  Created by taekki on 2022/07/19.
//

import UIKit

extension UITextField {
    
    func borderColor() {
        self.layer.borderColor = UIColor.systemPink.cgColor
        self.layer.borderWidth = 1.0
        self.borderStyle = .none
    }
    
}
