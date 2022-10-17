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
    @Persisted var importance: Int
    
    @Persisted(primaryKey: true) var objectId: ObjectId
    
    // 배열 형태로 다루고 싶을 때
    @Persisted var detail: List<DetailTodo>
    
    convenience init(
        title: String,
        importance: Int
        
    ) {
        self.init()
        self.title = title
        self.importance = importance
    }
}

final class DetailTodo: Object {
    @Persisted var detailTitle: String
    @Persisted var favorite: Bool
    
    @Persisted(primaryKey: true) var objectId: ObjectId
    
    convenience init(
        detailTitle: String,
        favorite: Bool
        
    ) {
        self.init()
        self.detailTitle = detailTitle
        self.favorite = favorite
    }
}
