//
//  LibraryCollectionViewCell.swift
//  Library
//
//  Created by taekki on 2022/07/21.
//

import UIKit

class LibraryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var bookTitleLabel: UILabel!
    @IBOutlet weak var bookRateLabel: UILabel!
    @IBOutlet weak var bookImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.configureUI()
    }
    
    func configureUI() {
        self.containerView.backgroundColor = .black
        self.containerView.layer.opacity = 0.5
        self.bookTitleLabel.textColor = .white
        self.bookTitleLabel.font = .boldSystemFont(ofSize: 16)
        self.bookRateLabel.textColor = .white
    }
    
    func configureCell(book: Book) {
        self.bookTitleLabel.text = book.bookTitie
        self.bookRateLabel.text = book.bookRate
    }
}
