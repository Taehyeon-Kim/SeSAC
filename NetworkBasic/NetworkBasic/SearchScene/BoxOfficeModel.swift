//
//  BoxOfficeModel.swift
//  NetworkBasic
//
//  Created by taekki on 2022/08/02.
//

import Foundation
import RealmSwift

class BoxOfficeModel: Object {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var movieTitle: String
    @Persisted var releaseDate: String
    @Persisted var audienceCount: String
    
    convenience init(movieTitle: String, releaseDate: String, audienceCount: String) {
        self.init()
        self.movieTitle = movieTitle
        self.releaseDate = releaseDate
        self.audienceCount = audienceCount
    }
}
