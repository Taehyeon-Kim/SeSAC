//
//  MigrationViewController.swift
//  FirebaseSample
//
//  Created by taekki on 2022/10/13.
//

import UIKit
import RealmSwift

final class MigrationViewController: UIViewController {

    let localRealm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard
            let schemaURL = localRealm.configuration.fileURL
        else { return }
        
        // 1. Fetch fileURL
        print("FileURL: \(schemaURL)")
        
        // 2. Check Schema version
        // 오랜 시간 후에 작업을 진행했을 때, Migration을 몇 버전까지 진행했는지 체크할 때 용이
        do {
            let version = try schemaVersionAtURL(schemaURL)
            print("Schema version: \(version)")
        } catch {
            print(error)
        }
        
        // // 3. 반복문으로 작업 추가
        // (1...100).forEach { index in
        //     let task = Todo(title: "태끼의 할 일 \(index)", importance: Int.random(in: 1...5))
        //
        //     try! localRealm.write {
        //         localRealm.add(task)
        //     }
        // }
        //
        // // 4. DetailTodo 반복문으로 작업 추가
        // for i in 1...10 {
        //     let task = DetailTodo(detailTitle: "양파 \(i)개", favorite: true)
        //
        //     try! localRealm.write {
        //         localRealm.add(task)
        //     }
        // }
        
        // 특정 Todo 테이블에 DetailTodo 추가
        // 문자열에 대한 부분은 작은 따옴표 사용
        // guard let task = localRealm.objects(Todo.self).filter("title = '태끼의 할 일 7'").first else { return }
        //
        // let detail = DetailTodo(detailTitle: "잠자기", favorite: false)
        //
        // try! localRealm.write {
        //     task.detail.append(detail)
        // }
        
        // 특정 Todo 테이블에 DetailTodo 여러개 추가
        // guard let task = localRealm.objects(Todo.self).filter("title = '태끼의 할 일 3'").first else { return }
        //
        // let detail = DetailTodo(detailTitle: "아이스크림 \(Int.random(in: 1...5))개 먹기", favorite: false)
        //
        // for _ in 1...10 {
        //     try! localRealm.write {
        //         task.detail.append(detail)
        //     }
        // }
        
        guard let task = localRealm.objects(Todo.self).filter("title = '태끼의 할 일 7'").first else { return }

        try! localRealm.write {
            localRealm.delete(task.detail)
            localRealm.delete(task)
        }
    }
}
