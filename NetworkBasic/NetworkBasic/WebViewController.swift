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
    
    var destinationURLString: String = "https://www.apple.com"
    // App Transport Security Settings (ATS 설정)
    // http 보편적으로 보안상의 이유로 막아놓았다.
    
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
    
    @IBAction func openExternalLinkButtonTapped(_ sender: UIBarButtonItem) {
        Utils.openExternalLink(urlString: "https://www.netflix.com")
    }
    
    @IBAction func goBackButtonClicked(_ sender: UIBarButtonItem) {
        if webView.canGoBack {
            webView.goBack()
        }
    }
    
    @IBAction func reloadButtonClicked(_ sender: UIBarButtonItem) {
        webView.reload()
    }
    
    @IBAction func gorForwardButtonClicked(_ sender: UIBarButtonItem) {
        if webView.canGoForward {
            webView.goForward()
        }
    }
    
}

// SearchBar 역시 Action이 없음
extension WebViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let urlString = searchBar.text else { return }
        openWebPage(urlString: urlString)
    }
}
