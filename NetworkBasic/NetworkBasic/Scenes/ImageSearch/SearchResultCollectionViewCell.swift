//
//  SearchResultCollectionViewCell.swift
//  NetworkBasic
//
//  Created by taekki on 2022/08/03.
//

import UIKit

import Kingfisher

final class SearchResultCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var ImageView: UIImageView! {
        didSet {
            ImageView.contentMode = .scaleAspectFill
        }
    }
    
    func configureCell(withImageString imageString: String?) {
        if let url = URL(string: imageString!) {
            ImageView.kf.setImage(with: url)
        }
    }
}
