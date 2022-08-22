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
    
    convenience init(title: String) {
        self.init()
        self.isCheck = false
        self.title = title
        self.isBookmark = false
    }
}
