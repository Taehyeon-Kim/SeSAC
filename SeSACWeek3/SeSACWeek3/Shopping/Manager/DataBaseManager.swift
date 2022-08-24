//
//  DataBaseManager.swift
//  SeSACWeek3
//
//  Created by taekki on 2022/08/24.
//

import UIKit
import RealmSwift

protocol DataBase {
    func read<T: Object>(_ object: T.Type) -> Results<T>
    func write<T: Object>(_ object: T)
    func delete<T: Object>(_ object: T)
    func sort<T: Object>(_ object: T.Type, by keyPath: String, ascending: Bool) -> Results<T>
}

final class DataBaseManager: DataBase {

    static let shared = DataBaseManager()
    
    private let database: Realm
    
    private init() {
        self.database = try! Realm()
    }
    
    func getLocationOfDefaultRealm() {
        print("Realm is located at:", database.configuration.fileURL!)
    }
    
    func read<T: Object>(_ object: T.Type) -> Results<T> {
        return database.objects(object)
    }
    
    func write<T: Object>(_ object: T) {
        do {
            try database.write {
                database.add(object, update: .modified)
                print("New Item")
            }
            
        } catch let error {
            print(error)
        }
    }
    
    func update<T: Object>(_ object: T, completion: @escaping ((T) -> ())) {
        do {
            try database.write {
                completion(object)
            }
            
        } catch let error {
            print(error)
        }
    }
    
    func delete<T: Object>(_ object: T) {
        do {
            try database.write {
                database.delete(object)
                print("Delete Success")
            }
            
        } catch let error {
            print(error)
        }
    }
    
    func sort<T: Object>(_ object: T.Type, by keyPath: String, ascending: Bool = true) -> Results<T> {
        return database.objects(object).sorted(byKeyPath: keyPath, ascending: ascending)
    }
}
