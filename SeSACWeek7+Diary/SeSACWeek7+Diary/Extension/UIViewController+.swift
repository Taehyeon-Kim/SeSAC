//
//  UIViewController+.swift
//  SeSACWeek7+Diary
//
//  Created by taekki on 2022/08/18.
//

import UIKit

extension UIViewController {
    
    func transitionViewController<T: UIViewController>(storyboard: String, viewController vc: T) {
        
        let storyboard = UIStoryboard(name: storyboard, bundle: nil)
        guard let controller = storyboard.instantiateViewController(withIdentifier: String(describing: vc)) as? T else { return }
        self.present(controller, animated: true)
    }
}
