//
//  CardCollectionViewCell.swift
//  SeSACWeek6
//
//  Created by taekki on 2022/08/09.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var cardView: CardView!
    
    // 변경되지 않는 UI
    override func awakeFromNib() {
        super.awakeFromNib()
//        print("CardCollectionViewCell", #function)
        configureUI()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        cardView.contentLabel.text = "A"
    }
    
    private func configureUI() {
        cardView.backgroundColor = .clear
        cardView.posterImageView.layer.cornerRadius = 10
        cardView.likeButton.tintColor = .systemBlue
        cardView.posterImageView.contentMode = .scaleAspectFill
    }
}
