//
//  Notification+.swift
//  SeSACWeek7+Diary
//
//  Created by taekki on 2022/08/21.
//

import Foundation

extension Notification.Name {
    
    static let name = Notification.Name("Name")
}

extension Notification.Name {
    
    func post(object: Any? = nil, userInfo: [AnyHashable : Any]? = nil) {
        NotificationCenter.default.post(name: self, object: object, userInfo: userInfo)
    }
    
    @discardableResult
    func addObserver(object: Any? = nil, queue: OperationQueue? = nil, using: @escaping (Notification) -> Void) -> NSObjectProtocol {
        return NotificationCenter.default.addObserver(forName: self, object: object, queue: queue, using: using)
    }
}
