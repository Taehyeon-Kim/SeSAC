//
//  MainViewController.swift
//  SeSACWeek6
//
//  Created by taekki on 2022/08/09.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var bannerCollectionView: UICollectionView!
    @IBOutlet weak var mainTableView: UITableView!
    
    let color: [UIColor] = [.systemPurple, .systemRed, .systemGreen, .systemYellow, .systemMint]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        setupTableView()
    }
}

// MARK: - Helpers + Private Functions
extension MainViewController {
    private func setupCollectionView() {
        bannerCollectionView.delegate = self
        bannerCollectionView.dataSource = self
        bannerCollectionView.register(UINib(nibName: "CardCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CardCollectionViewCell")
        bannerCollectionView.collectionViewLayout = collectionViewLayout()
    }
    
    private func collectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: bannerCollectionView.frame.height)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        // device width 기준으로 환산 처리 - 셀의 너비가 디바이스 너비와 같을 때 잘 동작
        bannerCollectionView.isPagingEnabled = true
        return layout
    }
    
    private func setupTableView() {
        mainTableView.delegate = self
        mainTableView.dataSource = self
    }
}

// MARK: - Collection View Data Delegate
extension MainViewController: UICollectionViewDelegate {
    
}

// MARK: - Collection View Data Source
extension MainViewController: UICollectionViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCollectionViewCell", for: indexPath) as? CardCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.cardView.posterImageView.backgroundColor = color[indexPath.row]
        return cell
    }
}

// MARK: - MainViewController Delegate
extension MainViewController: UITableViewDelegate {
    
}

// MARK: - MainViewController DataSource
extension MainViewController: UITableViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = mainTableView.dequeueReusableCell(withIdentifier: "MainTableViewCell", for: indexPath) as? MainTableViewCell else {
            return UITableViewCell()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 190
    }
}