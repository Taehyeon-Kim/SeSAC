//
//  RecommendCollectionViewController.swift
//  SeSACWeek3
//
//  Created by taekki on 2022/07/20.
//

import UIKit

import Toast
import Kingfisher

/*
 TableView > CollectionView
 Row > Item
 heightForRowAt > ??? FlowLayout (heightForItemAt이 없는 경우)
 */

class RecommendCollectionViewController: UICollectionViewController {
    
    static let identifier = "RecommendCollectionViewController"
    let imageURL = "https://img1.daumcdn.net/thumb/R1280x0/?fname=http://t1.daumcdn.net/brunch/service/user/wXP/image/6j8FvDZzIaPickhD9G5IR-u7yGc.png"
    
    // 1. 값 전달 - 데이터를 받을 공간(프로퍼티) 생성
    var movieTitle: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 3. 값 전달 - 프로퍼티 값을 뷰에 표현
        self.title = self.movieTitle == nil ? "데이터 없음" : movieTitle!
        
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 8
        let width = UIScreen.main.bounds.width - (spacing * 4)
        layout.itemSize = CGSize(width: width / 3, height: 150)
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        collectionView.collectionViewLayout = layout
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecommendCollectionViewCell", for: indexPath) as? RecommendCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let url = URL(string: self.imageURL)
        
        cell.posterImageView.contentMode = .scaleAspectFill
        cell.posterImageView.kf.setImage(with: url)
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // collection view 이름을 view로 지어놓았다. 더 정확히는 collection view 아래에 view가 있다.
        self.view.makeToast("\(indexPath.item)번째 셀을 선택했습니다.", duration: 1, position: .center)
        self.navigationController?.popViewController(animated: true)
    }
}
