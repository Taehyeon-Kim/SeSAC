//
//  ShoppingTableViewCell.swift
//  SeSACWeek3
//
//  Created by taekki on 2022/07/20.
//

import UIKit

final class ShoppingTableViewCell: UITableViewCell {
    
    var isCheck = false {
        didSet {
            let checkButtonImage = isCheck ? UIImage(systemName: "checkmark.square.fill") : UIImage(systemName: "checkmark.square")
            checkButton.setImage(checkButtonImage, for: .normal)
        }
    }
    var isBookmark = false {
        didSet {
            let bookmarkImage = isBookmark ? UIImage(systemName: "star.fill") : UIImage(systemName: "star")
            bookmarkButton.setImage(bookmarkImage, for: .normal)
        }
    }
    
    var completionHandler: (() -> ())?
    
    @IBOutlet weak var checkButton: UIButton!
    @IBOutlet weak var shoppingListLabel: UILabel!
    @IBOutlet weak var bookmarkButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        checkButton.addTarget(self, action: #selector(checkButtonClicked(_:)), for: .touchUpInside)
        bookmarkButton.addTarget(self, action: #selector(bookmarkButtonClicked(_:)), for: .touchUpInside)
    }
    
    @objc func checkButtonClicked(_ sender: UIButton) {
        isCheck.toggle()
        completionHandler?()
    }
    
    @objc func bookmarkButtonClicked(_ sender: UIButton) {
        isBookmark.toggle()
        completionHandler?()
    }
}
