//
//  DiffableViewController.swift
//  SeSACWeek1617
//
//  Created by taekki on 2022/10/19.
//

import UIKit

import Kingfisher

final class DiffableViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var viewModel = DiffableViewModel()
    
    /// <SectionIdentifierType, ItemIdentifierType>
    /// <Section, Row에 들어갈 아이템>
    /// Model 기반
    private var dataSource: UICollectionViewDiffableDataSource<Int, SearchResult>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.collectionViewLayout = createLayout()
        configureDataSource()
        collectionView.delegate = self
        searchBar.delegate = self
        
        bind()
    }
    
    func bind() {
        viewModel.photoList.bind { photo in
            var snapshot = NSDiffableDataSourceSnapshot<Int, SearchResult>()
            snapshot.appendSections([0])
            snapshot.appendItems(photo.results)
            self.dataSource.apply(snapshot)
        }
    }
}

extension DiffableViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // DataSource에서 itemIdentifier를 이용해서 데이터를 가져오게 된다.
        // 데이터 리스트에 직접 접근을 하지 않더라도 원하는 데이터를 가져올 수 있음.
        guard let item = dataSource.itemIdentifier(for: indexPath) else { return }
        let alert = UIAlertController(title: "좋아요 수", message: "\(item.likes)개", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .cancel))
        present(alert, animated: true)
    }
}

extension DiffableViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel.requestSearchPhoto(query: searchBar.text!)
    }
}

extension DiffableViewController {
    
    private func createLayout() -> UICollectionViewLayout {
        let config = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        let layout = UICollectionViewCompositionalLayout.list(using: config)
        return layout
    }
    
    private func configureDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, SearchResult> { cell, indexPath, item in
            
            var contentConfig = UIListContentConfiguration.valueCell()
            contentConfig.text = "\(item.likes)"
            
            // String > URL > Data(Binary) > Image
            // 왜 글로벌 큐에 보내놓을까? - 다운로드, 이미지 변환하는 동안에 동작이 멈추지 않도록 하기 위함
            DispatchQueue.global().async {
                let url = URL(string: item.urls.thumb)!
                let data = try? Data(contentsOf: url)

                DispatchQueue.main.async {
                    contentConfig.image = UIImage(data: data!)
                    
                    // 해당 라인을 바깥에 꺼내놓으면 정상 동작 안 함, 왜냐하면 비동기적으로 동작이 진행되기 때문
                    cell.contentConfiguration = contentConfig
                }
            }
            
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
    }
}
