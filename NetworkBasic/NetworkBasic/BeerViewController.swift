//
//  BeerViewController.swift
//  NetworkBasic
//
//  Created by taekki on 2022/08/01.
//

import UIKit

import Alamofire
import SwiftyJSON

final class BeerViewController: UIViewController {
    
    @IBOutlet weak var beerImageView: UIImageView!
    @IBOutlet weak var beerNameLabel: UILabel!
    @IBOutlet weak var beerDescriptionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func fetchBeers() {
        let url = "https://api.punkapi.com/v2/beers/random"
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let array = json.array?.first
                
                guard let imageURLString = (array?["image_url"] ?? "").rawValue as? String else { return }
                let imageURL = URL(string: imageURLString)
                let imageData = try! Data(contentsOf: imageURL!)
                self.beerImageView.image = UIImage(data: imageData)
                
                self.beerNameLabel.text = "\(array?["name"] ?? "")"
                self.beerDescriptionLabel.text = "\(array?["description"] ?? "")"
            case .failure(let error):
                print(error)
            }
        }
    }
    
    @IBAction func fetchBeerButtonTapped(_ sender: UIButton) {
        fetchBeers()
    }
}
