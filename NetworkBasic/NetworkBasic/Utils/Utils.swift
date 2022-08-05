//
//  Utils.swift
//  NetworkBasic
//
//  Created by taekki on 2022/07/28.
//

import UIKit

class Utils {
    static func openExternalLink(urlString: String, _ handler: (() -> Void)? = nil) {
        
        guard let url = URL(string: urlString) else { return }
        
        UIApplication.shared.open(url, options: [:]) { _ in
            handler?()
        }
    }
}
