//
//  Todo.swift
//  FirebaseSample
//
//  Created by taekki on 2022/10/13.
//

import Foundation
import RealmSwift

final class Todo: Object {
    
    @Persisted var title: String
    @Persisted var favorite: Double
    @Persisted var userDescription: String
    @Persisted var count: Double
    
    @Persisted(primaryKey: true) var objectId: ObjectId
    
    convenience init(
        title: String,
        importance: Int
    ) {
        self.init()
        self.title = title
        self.favorite = Double(importance)
    }
}
