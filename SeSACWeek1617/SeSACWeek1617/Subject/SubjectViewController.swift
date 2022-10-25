//
//  SubjectViewController.swift
//  SeSACWeek1617
//
//  Created by taekki on 2022/10/25.
//

import UIKit

import RxCocoa
import RxSwift

final class SubjectViewController: UIViewController {
    
    // 초기값 없는 빈 상태
    private let publish = PublishSubject<Int>()
    
    // 초기값 있는 상태(초기값 필수) (ex. 손님1234 기본 닉네임 부여)
    private let behavior = BehaviorSubject(value: 100)
    
    // 초기값을 여러 개(bufferSize에 작성된 이벤트 갯수만큼 이벤트를 가지고 있다가, subscribe 직후 한 번에 이벤트를 전달) (ex. 최근 검색어)
    private let replay = ReplaySubject<Int>.create(bufferSize: 3)
    
    private let async = AsyncSubject<Int>()
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // publishSubject()
        // behaviorSubject()
        // replaySubject()
        asyncSubject()
    }
    
    /// 값을 보낼수도 있고, 구독에 대한 처리도 가능
    /// 초기값이 없는 빈 상태,
    /// subscribe전/error/completed notification 이벤트는 무시
    /// subscribe후 이벤트는 모두 처리
    func publishSubject() {
        
        publish.onNext(1)   // new stream
        publish.onNext(2)   // new stream
        
        publish
            .subscribe { value in
                print("publish - \(value)")
            } onError: { error in
                print("publish - \(error)")
            } onCompleted: {
                print("publish - completed")
            } onDisposed: {
                print("publish - disposed")
            }
            .disposed(by: disposeBag)
        
        // 구독 이후의 방출 값만 확인 가능
        publish.onNext(3)
        publish.onNext(4)
        publish.on(.next(5))
        
        publish.onCompleted()
        
        publish.onNext(6)
    }
    
    func behaviorSubject() {
        // 구독전에 가장 최근 값을 같이 emit
        // 바로 이전의 값만 중요
        // BufferSize는 메모리가 가지고 있음
        // Array, 데이터 타입이 메모리 차지가 큰 이미지 같은 경우는 부하를 줄 수 있음
        
        behavior.onNext(1)     // new stream
        behavior.onNext(200)   // new stream
        
        behavior
            .subscribe { value in
                print("behavior - \(value)")
            } onError: { error in
                print("behavior - \(error)")
            } onCompleted: {
                print("behavior - completed")
            } onDisposed: {
                print("behavior - disposed")
            }
            .disposed(by: disposeBag)
        
        behavior.onNext(3)
        behavior.onNext(4)
        behavior.on(.next(5))
        
        behavior.onCompleted()
        
        behavior.onNext(6)
        behavior.onNext(7)
    }
    
    func replaySubject() {
        // 버퍼 사이즈만큼의 가장 최근 값만 방출
        
        replay.onNext(1)   // new stream
        replay.onNext(200)   // new stream
        //--------------------------------
        // replay.onNext(33)   // new stream
        // replay.onNext(50)   // new stream
        // replay.onNext(60)   // new stream
        
        replay
            .subscribe { value in
                print("replay - \(value)")
            } onError: { error in
                print("replay - \(error)")
            } onCompleted: {
                print("replay - completed")
            } onDisposed: {
                print("replay - disposed")
            }
            .disposed(by: disposeBag)
        
        replay.onNext(3)
        replay.onNext(4)
        replay.on(.next(5))
        
        replay.onCompleted()
        
        replay.onNext(6)
        replay.onNext(6)
    }
    
    func asyncSubject() {
        // 버퍼 사이즈만큼의 가장 최근 값만 방출
        
        async.onNext(1)   // new stream
        async.onNext(200)   // new stream

        async
            .subscribe { value in
                print("async - \(value)")
            } onError: { error in
                print("async - \(error)")
            } onCompleted: {
                print("async - completed")
            } onDisposed: {
                print("async - disposed")
            }
            .disposed(by: disposeBag)
        
        async.onNext(3)
        async.onNext(4)
        async.on(.next(5))
        
        // Complete 이벤트가 전달되어야만 실행
        // Complete 전 가장 마지막 이벤트만 방출
        async.onCompleted()
        
        async.onNext(6)
        async.onNext(6)
    }
}

extension SubjectViewController {
    
}
