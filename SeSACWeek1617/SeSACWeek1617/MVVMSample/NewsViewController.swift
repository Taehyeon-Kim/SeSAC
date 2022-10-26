//
//  NewsViewController.swift
//  SeSACWeek1617
//
//  Created by taekki on 2022/10/20.
//

import UIKit

import RxCocoa
import RxSwift

final class NewsViewController: UIViewController {
    
    var viewModel = NewsViewModel()
    var dataSource: UICollectionViewDiffableDataSource<Int, News.NewsItem>!
    
    var disposeBag = DisposeBag()
    
    @IBOutlet weak var numberTextField: UITextField!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var loadButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureHierachy()
        configureDataSource()
        bind()
    }
    
    private func bind() {
        viewModel.news
            .withUnretained(self)
            .bind { vc, news in
                var snapshot = NSDiffableDataSourceSnapshot<Int, News.NewsItem>()
                snapshot.appendSections([0])
                snapshot.appendItems(news)
                vc.dataSource.apply(snapshot, animatingDifferences: false)
            }
            .disposed(by: disposeBag)

        viewModel.pageNumber
            .bind(to: numberTextField.rx.text)
            .disposed(by: disposeBag)
        
        numberTextField.rx.text.orEmpty
            .withUnretained(self)
            .subscribe { `self`, text in
                self.viewModel.changePageNumberFormat(of: text)
            }
            .disposed(by: disposeBag)
        
        loadButton.rx.tap
            .withUnretained(self)
            .bind { vc, elem in
                vc.viewModel.loadNews()
            }
            .disposed(by: disposeBag)
        
        resetButton.rx.tap
            .withUnretained(self)
            .bind { vc, elem in
                vc.viewModel.resetNews()
            }
            .disposed(by: disposeBag)
    }
}

extension NewsViewController {
    
    // addSubview, init, SnapKit
    func configureHierachy() {
        collectionView.collectionViewLayout = createLayout()
        collectionView.backgroundColor = .lightGray
    }
    
    func configureDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, News.NewsItem> { cell, indexPath, item in
            var content = UIListContentConfiguration.valueCell()
            content.text = item.title
            content.secondaryText = item.body
            cell.contentConfiguration = content
        }
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
            return cell
        })
    }
    
    func createLayout() -> UICollectionViewLayout {
        let configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        return layout
    }
}
