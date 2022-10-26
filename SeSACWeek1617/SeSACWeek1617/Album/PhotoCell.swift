//
//  PhotoCell.swift
//  SeSACWeek1617
//
//  Created by taekki on 2022/10/26.
//

import UIKit

import SnapKit

final class PhotoCell: UICollectionViewCell {
    
    var index: Int = 0 {
        didSet {
            if index != 0 {
                contentView.layer.borderColor = UIColor.systemPink.cgColor
            } else {
                contentView.layer.borderColor = UIColor.gray.cgColor
            }
            contentView.layer.borderWidth = 5
            nameLabel.text = "\(index)"
        }
    }
    
    let nameLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func layout() {
        nameLabel.backgroundColor = .systemPink
        nameLabel.textColor = .black
        nameLabel.textAlignment = .center
        
        contentView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints {
            $0.size.equalTo(48)
            $0.top.trailing.equalToSuperview().inset(10)
        }
    }
}

extension PhotoCell {
    
    func configure(with index: Int) {
        self.index = index
    }
}
