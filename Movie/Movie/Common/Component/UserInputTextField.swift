//
//  UserInputTextField.swift
//  Movie
//
//  Created by taekki on 2022/08/19.
//

import UIKit

final class UserInputTextField: UITextField {
    
    var placeholderText: String? {
        didSet {
            configurePlaceholder()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initialUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func initialUI() {
        backgroundColor = .gray
        textColor = .white
        textAlignment = .center
        font = .boldSystemFont(ofSize: 15)
        borderStyle = .none
        layer.cornerRadius = 4
    }
    
    func configurePlaceholder() {
        attributedPlaceholder = NSAttributedString(
            string: placeholderText ?? "",
            attributes: [.foregroundColor: UIColor.systemGray5]
        )
    }
}
