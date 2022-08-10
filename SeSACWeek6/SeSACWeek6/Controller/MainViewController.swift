//
//  MainViewController.swift
//  SeSACWeek6
//
//  Created by taekki on 2022/08/09.
//

import UIKit

import Kingfisher

/*
 tableView - CollectionView > 프로토콜
 tag
 */

/*
 awakeFromNib - 셀 UI 초기화, 재사용 매커니즘에 의해 일정 횟수 이상 호출되지 않음
 
 cellForRowAt
 - 재사용될때마다 사용자에게 보여질 때마다 항상 실행됨
 - 화면과 데이터는 별개, 모든 indexPath.item에 대한 조건이 없다면 재사용 시 오류가 발생할 수 있음.
 
 prepareForReuse
 - 셀이 재사용 될 때 초기화 하고자 하는 값을 넣으면 오류를 해결할 수 있음
 - 즉, cellForRowAt에서 모드누 indexPath.item에 대한 조건을 작성하지 않아도 됨!
 
 CollectionView in TableView
 - 하나의 컬렉션뷰나 테이블뷰라면 문제 X
 - 복합적인 구조라면, 테이블셀도 재사용되어야 하고 컬렉션셀도 재사용 되여야 함.
 - Index > reloadData(cell for row at 쪽에 들어가야 함)
 - 개수가 아예 적은 상황이면 재사용될 셀이 없기 때문에 오류가 생기지 않을 수 있음.
 */

class MainViewController: UIViewController {

    @IBOutlet weak var bannerCollectionView: UICollectionView!
    @IBOutlet weak var mainTableView: UITableView!
    
    let color: [UIColor] = [.systemPurple, .systemRed, .systemGreen, .systemYellow, .systemMint]
    let numberList: [[Int]] = [
        [Int](100...110),
        [Int](55...75),
        [Int](5000...5006),
        [Int](51...60),
        [Int](61...70),
        [Int](51...60),
        [Int](61...70),
        [Int](51...60),
        [Int](61...70)
    ]
    
    var episodeList: [[String]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        setupTableView()
        
        TMDBAPIManager.shared.requestEpisodeImage { [weak self] value in
//            dump(value)
            
            // 1. 네트워크 통신 2. 배열 생성 3. 배열 담기
            // 4. 뷰 등에 표현
            // - 테이블뷰 섹션, 컬렉션 뷰 셀
            // 5. 뷰 갱신
            guard let self = self else { return }
            self.episodeList = value
            self.mainTableView.reloadData()
        }
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
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: 200)
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

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionView == bannerCollectionView ? color.count : episodeList[collectionView.tag].count
    }
    
    // bannerCollectionView or 테이블뷰 안에 들어있는 컬렉션 뷰
    // 내부 매개변수가 아닌 명확한 아웃렛을 사용할 경우, 셀이 재사용 되면 특정 collectionView 셀을 재사용하게 될 수 있음
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        print("MainViewController", #function, indexPath)
        // bannerCollectionView - 다른 컬렉션뷰에서 사용하는 셀을 재사용하려고 했을 때 레이아웃 이슈가 발생한다.
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCollectionViewCell", for: indexPath) as? CardCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        if collectionView == bannerCollectionView {
            cell.cardView.posterImageView.backgroundColor = color[indexPath.item]
        } else {
//            cell.cardView.contentLabel.text = "\(episodeList[collectionView.tag][indexPath.item])"
//            cell.cardView.posterImageView.backgroundColor = collectionView.tag.isMultiple(of: 2) ? .blue : .red
            
            let url = URL(string: "\(TMDBAPIManager.shared.imageURL)\(episodeList[collectionView.tag][indexPath.item])")
            cell.cardView.contentLabel.text = ""
            cell.cardView.posterImageView.kf.setImage(with: url)
            cell.cardView.contentLabel.textColor = .white
                    
            // - 화면과 데이터는 별개, 모든 indexPath.item에 대한 조건이 없다면 재사용 시 오류가 발생할 수 있음.
//            if indexPath.item < 2 {
//                cell.cardView.contentLabel.text = "\(numberList[collectionView.tag][indexPath.item])"
//            }
//            else {
//                cell.cardView.contentLabel.text = "HAPPY"
//            }
        }
    
        return cell
    }
}

// MARK: - MainViewController Delegate
extension MainViewController: UITableViewDelegate {
    
}

// MARK: - MainViewController DataSource
extension MainViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return episodeList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    // 내부 매개변수 tableView를 통해 테이블뷰를 특정
    // 테이블뷰 객체가 하나 일 경우에는 내부 매개변수를 활용하지 않아도 문제가 생기지 않는다.
    // 내부 매개변수는 이름을 변경해도 상관없다.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MainTableViewCell", for: indexPath) as? MainTableViewCell else {
            return UITableViewCell()
        }
        
//        print("MainViewController", #function, indexPath)
        
        cell.titleLabel.text = TMDBAPIManager.shared.tvList[indexPath.section].0
        cell.collectionView.delegate = self
        cell.collectionView.dataSource = self
        cell.collectionView.tag = indexPath.section
        cell.collectionView.register(UINib(nibName: "CardCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CardCollectionViewCell")
        cell.collectionView.reloadData() // Index Out of Range 해결
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 240
    }
}
