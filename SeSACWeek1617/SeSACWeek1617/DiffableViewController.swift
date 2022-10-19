//
//  DiffableViewController.swift
//  SeSACWeek1617
//
//  Created by taekki on 2022/10/19.
//

import UIKit

final class DiffableViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    private var list = ["아이폰", "아이패드", "에어팟", "맥북", "애플 워치"]
    
    /// <SectionIdentifierType, ItemIdentifierType>
    /// <Section, Row에 들어갈 아이템>
    /// Model 기반
    private var dataSource: UICollectionViewDiffableDataSource<Int, String>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.collectionViewLayout = createLayout()
        configureDataSource()
        collectionView.delegate = self
        
        searchBar.delegate = self
    }
}

extension DiffableViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // DataSource에서 itemIdentifier를 이용해서 데이터를 가져오게 된다.
        // 데이터 리스트에 직접 접근을 하지 않더라도 원하는 데이터를 가져올 수 있음.
        guard let item = dataSource.itemIdentifier(for: indexPath) else { return }
        let alert = UIAlertController(title: item, message: item, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .cancel))
        present(alert, animated: true)
    }
}

extension DiffableViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        var snapshot = dataSource.snapshot()
        snapshot.appendItems([searchBar.text!])
        dataSource.apply(snapshot, animatingDifferences: true)
        
        searchBar.text = nil
    }
}

extension DiffableViewController {
    
    private func createLayout() -> UICollectionViewLayout {
        let config = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        let layout = UICollectionViewCompositionalLayout.list(using: config)
        return layout
    }
    
    private func configureDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, String> { cell, indexPath, item in
            
            var contentConfig = UIListContentConfiguration.valueCell()
            contentConfig.text = item
            contentConfig.secondaryText = "\(item.count)" // 글자 수 출력
            cell.contentConfiguration = contentConfig
            
            var backgroundConfig = UIBackgroundConfiguration.listPlainCell()
            backgroundConfig.strokeWidth = 3
            backgroundConfig.strokeColor = .green
            cell.backgroundConfiguration = backgroundConfig
        }
        
        /// collectionView.dataSource = self
        /// - numberOfItemInSection, cellForItemAt
        /// - cell 반환
        /// - 해당 코드에서 cellRegistration을 수행할 수 있도록 트리거
        dataSource = UICollectionViewDiffableDataSource(
            collectionView: collectionView,
            cellProvider: { collectionView, indexPath, itemIdentifier in
                let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
                return cell
            })
        
        /// Initial
        /// 최초의 스냅샷 생성 그 이후부터는 차이를 비교하는 연산 수행 후 업데이트
        /// 그래서 어떤 데이터가 나오는데?
        var snapshot = NSDiffableDataSourceSnapshot<Int, String>()
        snapshot.appendSections([0])
        snapshot.appendItems(list)
        dataSource.apply(snapshot)
    }
}
