//
//  AlbumViewController.swift
//  SeSACWeek1617
//
//  Created by taekki on 2022/10/26.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit

final class AlbumViewController: UIViewController {
    
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.createLayout())
    
    private var dataSource: UICollectionViewDiffableDataSource<Int, Photo>!
    private var photos: [Photo] = Photo.dummy()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureHierarchy()
        configureDataSource()
        bind()
    }
}

extension AlbumViewController {
    
    private func configureHierarchy() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func createLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(0.5))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
    private func configureDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<PhotoCell, Photo> { cell, indexPath, item in
            cell.configure(with: "hello")
            cell.contentView.backgroundColor = [UIColor.red, UIColor.yellow, UIColor.green, UIColor.systemPink][indexPath.row % 4]
        }
        
        dataSource = UICollectionViewDiffableDataSource<Int, Photo>(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
            return cell
        })
        
        var snapshot = NSDiffableDataSourceSnapshot<Int, Photo>()
        snapshot.appendSections([0])
        snapshot.appendItems(photos)
        dataSource.apply(snapshot, animatingDifferences: false)
    }
}

extension AlbumViewController {
    
    private func bind() {
        
    }
}
