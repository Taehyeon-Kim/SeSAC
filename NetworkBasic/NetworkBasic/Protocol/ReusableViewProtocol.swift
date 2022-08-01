//
//  ReusableViewProtocol.swift
//  NetworkBasic
//
//  Created by taekki on 2022/08/01.
//

import UIKit

protocol ReusableViewProtocol: AnyObject {
    static var reuseidentifier: String { get }
}

extension UIViewController: ReusableViewProtocol {
    // 연산 프로퍼티의 형태로 나옴.
    // 연산 프로퍼티 get만 사용한다면 get 생략 가능.
    static var reuseidentifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell: ReusableViewProtocol {
    static var reuseidentifier: String {
        return String(describing: self)
    }
}
