//
//  SeSACActivityViewController.swift
//  SeSACUIFramework
//
//  Created by taekki on 2022/08/16.
//

import UIKit

extension UIViewController {

    public func sesacShowActivityViewController(shareImage: UIImage, shareURL: String, shareText: String) {
        
        let viewController = UIActivityViewController(activityItems: [shareImage, shareURL, shareText], applicationActivities: nil)
        viewController.excludedActivityTypes = [.mail, .assignToContact]
        self.present(viewController, animated: true)
    }
}
