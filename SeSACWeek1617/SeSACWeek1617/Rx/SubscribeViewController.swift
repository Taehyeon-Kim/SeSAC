//
//  SubscribeViewController.swift
//  SeSACWeek1617
//
//  Created by taekki on 2022/10/26.
//

import UIKit

import RxAlamofire
import RxDataSources
import RxCocoa
import RxSwift

final class SubscribeViewController: UIViewController {
    
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    let disposeBag = DisposeBag()
    
    // lazy var - 필요한 시점에 초기화
    lazy var dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, Int>>(configureCell: { dataSource, tableView, indexPath, item in
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
        cell.textLabel?.text = "\(item)"
        return cell
    })
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // rxAlamofire()
        rxDataSource()
    }
    
    private func rx() {
        Observable.of(1, 2, 3, 4, 5, 6, 7, 8, 9 , 10)
            .skip(3)
            .filter { $0 % 2 == 0 }
            .map { $0 * 2 }
        // .debug()
            .subscribe {
                print("값 : \($0)")
            } onCompleted: {
                print("Completed")
            } onDisposed: {
                print("Disposed")
            }
            .disposed(by: disposeBag)
        
        
        // mine
        // button.rx.tap
        //     .map { "안녕 반가워" }
        //     .bind(to: label.rx.text)
        //     .disposed(by: disposeBag)
        
        // case 1.
        button.rx.tap
            .subscribe { [weak self] _ in
                self?.label.text = "안녕 반가워 "
            }
            .disposed(by: disposeBag)
        
        // case 2.
        button.rx.tap
            .withUnretained(self)
            .subscribe { vc, _ in
                vc.label.text = "안녕 반가워 "
            }
            .disposed(by: disposeBag)
        
        // case 3. 메인 쓰레드 동작(UI 업데이트)
        // 네트워크 통신이나 파일 다운로드 등의 백그라운드 작업도 같이 진행될 수 있음
        button.rx.tap
            .map {}
            .map {}
            .map {}
            .observe(on: MainScheduler.instance) // 메인 쓰레드로 동작하게 변경
            .map {}
            .map {}
            .map {}
            .withUnretained(self)
            .subscribe { vc, _ in
                vc.label.text = "안녕 반가워 "
            }
            .disposed(by: disposeBag)
        
        // case 4. bind
        // subscribe, mainScheduler, error X
        // UI 동작의 경우 사용이 적합
        button.rx.tap
            .withUnretained(self)
            .bind { vc, _ in
                vc.label.text = "안녕 반가워 "
            }
            .disposed(by: disposeBag)
        
        // // case 5.
        // button.rx.tap
        //     .map { "안녕 반가워" }
        //     .bind(to: label.rx.text, label2.rx.text)
        //     .disposed(by: disposeBag)
        //
        // // case 6.
        // // driver traits: bind + stream 공유(리소스 낭비 방지, share()_)
        // // driver 객체가 share를 포함하고 있음.
        // button.rx.tap
        //     .map { "안녕 반가워" }
        //     .asDriver(onErrorJustReturn: "")
        //     .drive(label.rx.text, label2.rx.text)
        //     .disposed(by: disposeBag)
    }
}

extension SubscribeViewController {
    
    private func rxAlamofire() {
        let url = APIKey.searchURL + "apple"
        request(.get, url, headers: ["Authorizatio": APIKey.authorization])
            .debug("DEBUG")
            .data()
            .decode(type: SearchPhoto.self, decoder: JSONDecoder())
            .subscribe { data in
                print("rxAlamofire + \(data)")
            } onError: { [weak self] error in
                self?.alert(with: error.localizedDescription)
            }.disposed(by: disposeBag)
    }
    
    private func alert(with message: String) {
        let alertController = UIAlertController(title: "에러 발생", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .cancel)
        alertController.addAction(okAction)
        present(alertController, animated: true)
    }
    
    private func rxDataSource() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        // dataSource 설정
        dataSource.titleForHeaderInSection = { dataSource, index in
            return dataSource.sectionModels[index].model
        }
        
        // 최종적으로 dataSource 바인드
        Observable.just([
            SectionModel(model: "title1", items: [1, 2, 3]),
            SectionModel(model: "title2", items: [1, 2, 3]),
            SectionModel(model: "title3", items: [1, 2, 3])
        ])
        .bind(to: tableView.rx.items(dataSource: dataSource))
        .disposed(by: disposeBag)
    }
}
