//
//  SearchResultCollectionViewCell.swift
//  NetworkBasic
//
//  Created by taekki on 2022/08/03.
//

import UIKit

final class SearchResultCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var ImageView: UIImageView! {
        didSet {
            ImageView.contentMode = .scaleAspectFill
        }
    }
    
    func configureCell(withImageString imageString: String?) {
        guard let imageURLString = imageString else { return }
        let imageURL = URL(string: imageURLString)
        if let imageData = try? Data(contentsOf: imageURL!) {
            self.ImageView.image = UIImage(data: imageData)
        } else {
            self.ImageView.backgroundColor = .black
        }
    }
}
