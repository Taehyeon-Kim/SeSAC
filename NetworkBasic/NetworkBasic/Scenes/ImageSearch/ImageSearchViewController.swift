//
//  ImageSearchViewController.swift
//  NetworkBasic
//
//  Created by taekki on 2022/08/03.
//

import UIKit

import Alamofire
import SwiftyJSON

class ImageSearchViewController: UIViewController {
    
    var list: [String] = []
    var startPage = 1
    var totalCount = 0
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        configureCollectionView()
    }
    
    // fetchImage, requestImage, callRequestImage, getImage -> response에 따라 네이밍을 설정해주기도 함.
    func fetchImage(query: String) {
        ImageSearchAPIManager.shared.fetchImageData(query: query, startPage: startPage) { totalCount, list in
            self.totalCount = totalCount
            self.list.append(contentsOf: list)
            
            print(list)
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
}

extension ImageSearchViewController: UISearchBarDelegate {
    
    // 검색 버튼 클릭 시 실행. (키보드 Return키에 디폴트 구현)
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        list.removeAll()
        if let text = searchBar.text {
            // 검색 결과가 계속 바뀌기 때문에, 그럴 때마다 초기화 해줄 필요가 있음
            startPage = 1
            collectionView.scrollsToTop = true
            fetchImage(query: text)
        }
        
        view.endEditing(true)
    }
    
    // 취소 버튼 눌렀을 때 실행
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        list.removeAll()
        collectionView.reloadData()
        searchBar.text = ""
        searchBar.setShowsCancelButton(false, animated: true)
    }
    
    // 서치바에 커서가 깜빡이기 시작할 때 실행
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }
}

extension ImageSearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    private func configureCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.prefetchDataSource = self // pagenation 사용 위함
        
        let layout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.width - 20
        layout.itemSize = CGSize(width: width / 2, height: width / 2)
        collectionView.collectionViewLayout = layout
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchResultCollectionViewCell.reuseidentifier, for: indexPath) as? SearchResultCollectionViewCell else {
            return UICollectionViewCell()
        }
        print("cell")
        cell.configureCell(withImageString: list[indexPath.row])
        return cell
    }
 
    // 페이지네이션 방법1. 컬렉션뷰가 특정 셀을 그리려는 시점에 호출되는 메서드.
    // 마지막 셀에 사용자가 위치해있는지 명확하게 확인하기가 어려움.
    // 잘못호출이되면 불필요한 호출이 여러번 일어날 수 있음.
    // 이전에는 많이 사용되었던 방법임.
//    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//        <#code#>
//    }
    
    // 페이지네이션 방법2. UIScrollViewDelegate 프로토콜 활용
    // 테이블 뷰 / 컬렉션 뷰는 스크롤뷰를 상속받고 있음, 스크롤뷰 프로토콜을 사용할 수 있음.
    // contentOffset.y으로 얼마만큼 스크롤했는지 파악할 수 있음.
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        print(scrollView.contentOffset)
//    }
}

// 페이지네이션 방법3.
// 용량이 큰 이미지를 다운받아 셀에 보여주려고 하는 경우에 효과적.
// 셀이 화면에 보이기 전에 미리 필요한 리소스를 다운받을 수도 있고, 필요하지 않다면 데이터를 취소할 수도 있음.
// iOS 10 이상부터 사용 가능, 스크롤 성능이 향상됨.
extension ImageSearchViewController: UICollectionViewDataSourcePrefetching {
    
    // 셀이 화면에 보이기 직전에 필요한 리소스를 미리 다운 받는 기능
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            if list.indices.last == indexPath.item && list.count < totalCount {
                startPage += 30
                fetchImage(query: searchBar.text!)
            }
        }
//        print("===\(indexPaths)")
    }
    
    // 취소
    func collectionView(_ collectionView: UICollectionView, cancelPrefetchingForItemsAt indexPaths: [IndexPath]) {
//        print("취소, ===\(indexPaths)")
    }
}
