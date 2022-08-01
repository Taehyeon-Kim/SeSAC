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
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchBeers()
    }
    
    func fetchBeers() {
        let url = "https://api.punkapi.com/v2/beers/random"
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let array = json.array?.first
                print("name", "\(array?["name"])")
                print("description", "\(array?["description"])")
                print("image_url", "\(array?["image_url"])")
            case .failure(let error):
                print(error)
            }
        }
    }
}
