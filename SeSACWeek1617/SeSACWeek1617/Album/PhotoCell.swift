//
//  PhotoCell.swift
//  SeSACWeek1617
//
//  Created by taekki on 2022/10/26.
//

import UIKit

import SnapKit

final class PhotoCell: UICollectionViewCell {
    
    let nameLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func layout() {
        nameLabel.textColor = .blue
        nameLabel.textAlignment = .center
        
        contentView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(10)
        }
    }
}

extension PhotoCell {
    
    func configure(with name: String) {
        nameLabel.text = name
    }
}
