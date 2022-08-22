//
//  Shopping.swift
//  SeSACWeek3
//
//  Created by taekki on 2022/08/22.
//

import Foundation
import RealmSwift

class Shopping: Object {
    
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var isCheck: Bool
    @Persisted var title: String
    @Persisted var isBookmark: Bool
    @Persisted var createdAt = Date()
    
    convenience init(title: String, createdAt: Date) {
        self.init()
        self.isCheck = false
        self.title = title
        self.isBookmark = false
        self.createdAt = createdAt
    }
}
