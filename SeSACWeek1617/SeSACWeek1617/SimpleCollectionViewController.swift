//
//  SimpleCollectionViewController.swift
//  SeSACWeek1617
//
//  Created by taekki on 2022/10/18.
//

import UIKit

struct Food {
    let id: UUID = UUID()
    let emoji: String
    let title: String
    
    static func dummy() -> [Food] {
        return [
            Food(emoji: "☀️", title: "해"),
            Food(emoji: "🌱", title: "새싹"),
            Food(emoji: "☁️", title: "구름"),
            Food(emoji: "🌧", title: "비"),
        ]
    }
}

final class SimpleCollectionViewController: UICollectionViewController {
    
    private var foods: [Food] = Food.dummy()
    
    // cellForItemAt 전에 생성되어야 한다. register 코드와 유사한 역할
    // cellForItemAt에서 사용될 프로퍼티
    var cellRegistration: UICollectionView.CellRegistration<UICollectionViewListCell, Food>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 14+ 컬렉션뷰를 테이블뷰 스타일처럼 사용 가능(List Configuration)
        //
        // - 더욱 테이블뷰가 필요할지에 대한 생각이 든다.
        // - Layout 설정
        var configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        configuration.showsSeparators = false
        configuration.backgroundColor = .systemGray6
        
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        collectionView.collectionViewLayout = layout
        
        // itemIdentifier: 데이터
        cellRegistration = UICollectionView.CellRegistration { cell, indexPath, itemIdentifier in
            var content = UIListContentConfiguration.valueCell()
            content.text = itemIdentifier.title
            
            // valueCell에서는 secondaryText가 우측으로 감
            // default configuration에서는 secondaryText가 하단으로 감
            content.secondaryText = itemIdentifier.emoji
            content.prefersSideBySideTextAndSecondaryText = false
            content.textToSecondaryTextVerticalPadding = 10
            
            content.image = indexPath.item < 3 ? UIImage(systemName: "arrowshape.right.fill") : UIImage(systemName: "arrowshape.right")
            content.imageProperties.tintColor = .darkGray
            cell.contentConfiguration = content
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return foods.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = foods[indexPath.row]
        let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: item)
        return cell
    }
}
