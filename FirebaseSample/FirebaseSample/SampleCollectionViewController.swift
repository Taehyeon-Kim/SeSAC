//
//  SampleCollectionViewController.swift
//  FirebaseSample
//
//  Created by taekki on 2022/10/18.
//

import UIKit
import RealmSwift

final class SampleCollectionViewController: UICollectionViewController {
        
    var tasks: Results<Todo>!
    let localRealm = try! Realm()
    
    var cellRegistration: UICollectionView.CellRegistration<UICollectionViewListCell, Todo>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 1. Load Realm Data
        tasks = localRealm.objects(Todo.self)
        
        // 2. Layout Configuration
        let configuration = UICollectionLayoutListConfiguration(appearance: .plain)
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        collectionView.collectionViewLayout = layout
        
        // 3. Cell Registration
        cellRegistration = UICollectionView.CellRegistration { cell, indexPath, itemIdentifier in
            var content = cell.defaultContentConfiguration()
            content.image = itemIdentifier.importance < 2 ? UIImage(systemName: "heart.fill") : UIImage(systemName: "sun")
            content.text = itemIdentifier.title
            content.secondaryText = "\(itemIdentifier.detail.count)개의 세부 항목"
            cell.contentConfiguration = content
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tasks.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = tasks[indexPath.item]
        let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: item)
        return cell
    }
}
