//
//  RxCocoaDemoViewController.swift
//  SeSACWeek1617
//
//  Created by taekki on 2022/10/24.
//

import UIKit

import RxCocoa
import RxSwift

final class RxCocoaDemoViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var simpleLabel: UILabel!
    @IBOutlet weak var simpleSwitch: UISwitch!
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    
    // MARK: - Properties
    private let disposeBag = DisposeBag()
    
    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTableView()
        setPickerView()
        setSwitch()
        setSign()
    }
    
    // MARK: - Private Functions
    /// Rx 내에서 TableView 관련된 프로토콜을 모두 채택하고 구현하고 있음
    /// - 그렇기에 디버그가 어려움
    private func setTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        // 이벤트를 보낼거야
        let items = Observable.just([
            "First Item",
            "Second Item",
            "Third Item"
        ])
        
        /// items라는 시퀀스를 tableview의 items가 구독할거야
        /// UI 요소라서 bind를 해줬구나!
        items
            .bind(to: tableView.rx.items) { (tableView, row, element) in
                let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
                cell.textLabel?.text = "\(element) @ row \(row)"
                return cell
            }
            .disposed(by: disposeBag)
        
        // itemSelected : 인덱스
        // modelSeleted : 모델
        // 둘 다 가져올 방법은 없다.
        // tableView.rx.itemSelected
        //     .bind { index in
        //         print(index)
        //     }
        //     .disposed(by: disposeBag)
        
        let observable = tableView.rx.modelSelected(String.self)
        
        // UI 이벤트는 절대 실패하거나 끝날 일이 없다.
        observable
            .subscribe { elem in
                print(elem)
            } onError: { error in
                print(error)
            } onCompleted: {
                print("completed")
            } onDisposed: {
                print("disposed")
            }
            .disposed(by: disposeBag)
        
        observable
            .map { "\($0)를 클릭했습니다." }
            .bind(to: simpleLabel.rx.text)
            .disposed(by: disposeBag)
    }
    
    private func setPickerView() {
        let items = Observable.just([
            "영화",
            "애니메이션",
            "드라마",
            "기타"
        ])
        
        items
            .bind(to: pickerView.rx.itemTitles) { (row, element) in
                return element
            }
            .disposed(by: disposeBag)
        
        pickerView.rx.modelSelected(String.self)
            .map { $0.first }
            .bind(to: simpleLabel.rx.text)
            .disposed(by: disposeBag)
    }
    
    func setSwitch() {
        Observable.of(false)
            .bind(to: simpleSwitch.rx.isOn)
            .disposed(by: disposeBag)
    }
    
    func setSign() {
        Observable.combineLatest(
            nameTextField.rx.text.orEmpty,
            emailTextField.rx.text.orEmpty
        ) { value1, value2 in
            return "이름은 \(value1)이고, 이메일은 \(value2)입니다."
        }
        .bind(to: simpleLabel.rx.text)
        .disposed(by: disposeBag)
        
        nameTextField.rx.text.orEmpty   // 데이터의 흐름: Stream
            .map { $0.count < 4 }
            .bind(to: emailTextField.rx.isHidden)
            .disposed(by: disposeBag)
        
        emailTextField.rx.text.orEmpty
            .map { $0.count > 4 }
            .bind(to: signUpButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        // tap의 경우 반환값이 Void임.
        // bind 해줄 객체가 없다는 것임.
        // - bind가 불가능한 것은 아님.
        // - 데이터 형식을 새롭게 만들어내서 맞춰준다거나 하는 식으로 해도 됨.
        // - 그러나 단순히 이벤트가 발생한 것에 대해서는 subscribe가 더 적절해보임.
        signUpButton.rx.tap
            .subscribe { _ in
                let alert = UIAlertController(title: "Good", message: nil, preferredStyle: .alert)
                let ok = UIAlertAction(title: "Ok", style: .cancel)
                alert.addAction(ok)
                self.present(alert, animated: true)
            }
        .disposed(by: disposeBag)
    }
}

// MARK: - Extension
extension RxCocoaDemoViewController {
    
}
