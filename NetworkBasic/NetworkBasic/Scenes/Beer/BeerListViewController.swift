//
//  BeerListViewController.swift
//  NetworkBasic
//
//  Created by taekki on 2022/08/02.
//

import UIKit

import Alamofire
import SwiftyJSON

final class BeerListViewController: UIViewController {
    
    var beerList: [Beer] = []

    @IBOutlet weak var outlineView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureStyle()
        configureCollectionView()
        requestBeerList()
    }
}

extension BeerListViewController {
    
    private func configureStyle() {
        outlineView.layer.borderColor = UIColor.brown.cgColor
        outlineView.layer.borderWidth = 1.0
    }
    
    private func requestBeerList() {
        let url = EndPoint.beerListURL
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json.arrayValue)")
                
                for beer in json.arrayValue {
                    let beer = Beer(imageURLString: beer["image_url"].string, name: beer["name"].stringValue, description: beer["description"].stringValue)
                    self.beerList.append(beer)
                }
                
                self.collectionView.reloadData()
                
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension BeerListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    private func configureCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "BeerCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: BeerCollectionViewCell.reuseidentifier)
        
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 8
        let width: CGFloat = UIScreen.main.bounds.width - (spacing * 4) - 40
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: width / 3, height: 150)
        layout.minimumLineSpacing = 8
        collectionView.collectionViewLayout = layout
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return beerList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BeerCollectionViewCell.reuseidentifier, for: indexPath) as? BeerCollectionViewCell else { return UICollectionViewCell() }
        cell.configureCell(beerList[indexPath.row])
        return cell
    }
}
