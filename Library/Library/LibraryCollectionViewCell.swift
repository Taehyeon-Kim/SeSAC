//
//  LibraryCollectionViewCell.swift
//  Library
//
//  Created by taekki on 2022/07/21.
//

import UIKit

class LibraryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var bookTitleLabel: UILabel!
    @IBOutlet weak var bookRateLabel: UILabel!
    @IBOutlet weak var bookImageView: UIImageView!
    
    func configureCell(book: Book) {
        self.bookTitleLabel.text = book.bookTitie
        self.bookRateLabel.text = book.bookRate
    }
}
