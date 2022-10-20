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
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var loadButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addTarget()
        configureHierachy()
        configureDataSource()
        bind() // datasource 초기화 전에 bind하려고 하면 문제 발생
    }
    
    /// 액션이 트리거될 때마다 ViewModel에 신호 전달
    /// 변화가 있으면 bind 함수 실행
    private func bind() {
        viewModel.pageNumber.bind { value in
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
        numberTextField.addTarget(self, action: #selector(numberTextFieldChanged), for: .editingChanged)
        resetButton.addTarget(self, action: #selector(resetButtonDidTap), for: .touchUpInside)
        loadButton.addTarget(self, action: #selector(loadButtonDidTap), for: .touchUpInside)
    }
}

extension NewsViewController {
    // 이벤트, 액션
    @objc func numberTextFieldChanged() {
        guard let text = numberTextField.text else { return }
        viewModel.changePageNumberFormat(of: text)
    }
    
    @objc func resetButtonDidTap() {
        viewModel.resetNews()
    }
    
    @objc func loadButtonDidTap() {
        viewModel.loadNews()
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
