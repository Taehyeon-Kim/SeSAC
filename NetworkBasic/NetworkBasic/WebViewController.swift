//
//  WebViewController.swift
//  NetworkBasic
//
//  Created by taekki on 2022/07/28.
//

import UIKit
import WebKit

class WebViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var webView: WKWebView!
    
    var destinationURLString: String = "https://www.apple.com" // App Transport Security Settings
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchBar.delegate = self
        openWebPage(urlString: destinationURLString)
    }
    
    func openWebPage(urlString: String) {
        // 유효한 URL인지 확인
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        let request = URLRequest(url: url)
        webView.load(request)
    }
}

// SearchBar 역시 Action이 없음
extension WebViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let urlString = searchBar.text else { return }
        openWebPage(urlString: urlString)
    }
}
