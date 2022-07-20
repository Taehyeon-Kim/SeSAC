//
//  MovieCell.swift
//  TrendMedia
//
//  Created by taekki on 2022/07/19.
//

import UIKit

final class MovieCell: UITableViewCell {
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    func configureCell(data: Movie) {
        self.titleLabel.text = data.title
        self.releaseLabel.text = data.releaseDate
        self.descriptionLabel.text = data.description
    }
}
