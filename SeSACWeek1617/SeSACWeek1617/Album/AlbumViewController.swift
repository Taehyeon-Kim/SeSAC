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
    
    private var disposeBag = DisposeBag()
    private var dataSource: UICollectionViewDiffableDataSource<Int, Photo>!
    private let viewModel = AlbumViewModel()
    
    private var photos: [Photo] = Photo.dummy()
    private var selectedPhotos: [Photo] = []
    
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
        item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(0.5))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
    private func configureDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<PhotoCell, Photo> { cell, indexPath, item in
            cell.configure(with: item.index)
            cell.backgroundColor = .systemGray5
        }
        
        dataSource = UICollectionViewDiffableDataSource<Int, Photo>(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
            return cell
        })
    }
}

extension AlbumViewController {
    
    private func bind() {
        collectionView.rx.itemSelected
            .asDriver()
            .drive { indexPath in
                self.viewModel.photoDidTap(index: indexPath.item)
            }
            .disposed(by: disposeBag)
        
        viewModel.photos
            .asDriver()
            .drive { photos in
                var snapshot = NSDiffableDataSourceSnapshot<Int, Photo>()
                snapshot.appendSections([0])
                snapshot.appendItems(photos)
                self.dataSource.apply(snapshot, animatingDifferences: true)
            }
            .disposed(by: disposeBag)
    }
}
