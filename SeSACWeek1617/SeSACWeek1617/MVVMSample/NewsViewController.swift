//
//  NewsViewController.swift
//  SeSACWeek1617
//
//  Created by taekki on 2022/10/20.
//

import UIKit

final class NewsViewController: UIViewController {
    
    var viewModel = NewsViewModel()
    var dataSource: UICollectionViewDiffableDataSource<Int, News.NewsItem>!
    
    @IBOutlet weak var numberTextField: UITextField!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addTarget()
        configureHierachy()
        configureDataSource()
        bind() // datasource 초기화 전에 bind하려고 하면 문제 발생
    }
    
    // numberTextField.text = "3000"
    private func bind() {
        viewModel.pageNumber.bind { value in
            print("bind == \(value)")
            self.numberTextField.text = value
        }
        
        viewModel.news.bind { news in
            var snapshot = NSDiffableDataSourceSnapshot<Int, News.NewsItem>()
            snapshot.appendSections([0])
            snapshot.appendItems(news)
            self.dataSource.apply(snapshot, animatingDifferences: false)
        }
    }
    
    private func addTarget() {
        numberTextField.addTarget(
            self,
            action: #selector(numberTextFieldChanged),
            for: .editingChanged
        )
    }
}

extension NewsViewController {
    // 이벤트, 액션
    @objc func numberTextFieldChanged() {
        guard let text = numberTextField.text else { return }
        viewModel.changePageNumberFormat(of: text)
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
