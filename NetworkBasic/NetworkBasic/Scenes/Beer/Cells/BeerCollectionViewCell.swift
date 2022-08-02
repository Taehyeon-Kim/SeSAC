//
//  BeerCollectionViewCell.swift
//  NetworkBasic
//
//  Created by taekki on 2022/08/02.
//

import UIKit

class BeerCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var beerImageView: UIImageView!
    @IBOutlet weak var beerTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(_ beer: Beer) {
        guard let imageURLString = beer.imageURLString else { return }
        let imageURL = URL(string: imageURLString)
        let imageData = try? Data(contentsOf: imageURL!)
        self.beerImageView.image = UIImage(data: imageData!)
        self.beerTitleLabel.text = beer.name
    }
}
