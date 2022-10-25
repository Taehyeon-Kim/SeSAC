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
    
    @IBOutlet weak var nicknameLabel: UILabel!
    
    // MARK: - Properties
    private var disposeBag = DisposeBag()
    private var nickname = Observable.just("Taekki")
    
    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nickname
            .bind(to: nicknameLabel.rx.text)
            .disposed(by: disposeBag)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            /// Observable의 한계 (약간 let 느낌이 아닌가)
            /// 1) Observable은 전달만 가능 / 절대 할당을 못함
            /// 2) Type이 다름
            /// self.nickname = "HELLO"
        }
        
        setTableView()
        setPickerView()
        setSwitch()
        setSign()
        setOperator()
    }
    
    // ViewController deinit 되면, 알아서 disposed도 동작한다.
    deinit {
        print(#file, "deinit")
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
        // let items = Observable.just([
        //     "영화",
        //     "애니메이션",
        //     "드라마",
        //     "기타"
        // ])
        //
        // items
        //     .bind(to: pickerView.rx.itemTitles) { (row, element) in
        //         return element
        //     }
        //     .disposed(by: disposeBag)
        //
        // pickerView.rx.modelSelected(String.self)
        //     .map { $0.first }
        //     .bind(to: simpleLabel.rx.text)
        //     .disposed(by: disposeBag)
        let items = Observable.just([
            "First Item",
            "Second Item",
            "Third Item"
        ])
        
        items
            .bind(to: pickerView.rx.itemAttributedTitles) { (row, element) in
                print(element)
                return NSAttributedString(string: element)
            }
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
            .withUnretained(self)
            .subscribe { vc, _ in
                let alert = UIAlertController(title: "Good", message: nil, preferredStyle: .alert)
                let ok = UIAlertAction(title: "Ok", style: .cancel)
                alert.addAction(ok)
                vc.present(alert, animated: true)
            }
        .disposed(by: disposeBag)
    }
}

// MARK: - Extension
extension RxCocoaDemoViewController {

    func setOperator() {
        let itemA = [5.3, 1.2, 4.0, 3.0, 2.2, 3.3]
        let itemB = [2.3, 2.0, 1.1]
        
        // 한 개의 요소만 받을 수 있음
        Observable.just(itemA)
            .subscribe { value in
                print("just - \(value)")
            } onError: { error in
                print("just - \(error)")
            } onCompleted: {
                print("just - completed")
            } onDisposed: {
                print("just - disposed")
            }
            .disposed(by: disposeBag)
        
        // 두 개 이상의 요소를 받을 수 있음
        // 가변 매개변수로 이루어 짐
        Observable.of([itemA, itemB], itemA)
            .subscribe { value in
                print("of - \(value)")
            } onError: { error in
                print("of - \(error)")
            } onCompleted: {
                print("of - completed")
            } onDisposed: {
                print("of - disposed")
            }
            .disposed(by: disposeBag)
        
        Observable.from(itemA)
            .subscribe { value in
                print("from - \(value)")
            } onError: { error in
                print("from - \(error)")
            } onCompleted: {
                print("from - completed")
            } onDisposed: {
                print("from - disposed")
            }
            .disposed(by: disposeBag)
        
        // 반복
        // 5번만 반복하겠다.
        // 네트워크 요청 횟수 제한.
        Observable.repeatElement("Taekki")  // 다음 오퍼레이터는 무한한 상태 : Infinite Observable Sequence
            .take(5)                        // Finite Observable Sequence
            .subscribe { value in
                print("repeatElement - \(value)")
            } onError: { error in
                print("repeatElement - \(error)")
            } onCompleted: {
                print("repeatElement - completed")
            } onDisposed: {                 // deinit에 print 넣는 느낌
                print("repeatElement - disposed")
            }
            .disposed(by: disposeBag)       // 리소스 정리 객체
        
        // 무한한 시퀀스
        // 화면 전환되더라도 시퀀스는 살아있음.
        // error or completed되면 시퀀스 종료
        // 수동으로 dispose 시킬 필요가 있음.
        Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance)
            .subscribe { value in
                print("interval - \(value)")
            } onError: { error in
                print("interval - \(error)")
            } onCompleted: {
                print("interval - completed")
            } onDisposed: {
                print("interval - disposed")
            }
            .disposed(by: disposeBag)
        
        // DisposeBag: 리소스 해제 관리
        // - 1. 시퀀스 끝날 때 / but bind
        // - 2. class deinit이 된다면, 자동으로 해제 됨(bind 객체의 경우)
        // - 3. dispose 직접 호출
        // --- 구독하는 요소가 많다면 번거로움
        // - 4. DisposeBag을 새롭게 할당하거나, nil 전달
        // ☀️ dispose() 구독하는 것마다 별도로 관리가 필요하다.
        
        // /// 리소스 정리
        // DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
        //     /// 리소스 정리를 수동으로 하는 것임
        //     /// RootView 같은 경우는 리소스가 해제가 되지 않을 수 있다.
        //     /// 그러므로 수동으로 처리를 해줘야 하는데
        //     /// 이 때 DisposeBag을 교체해줌으로써 해결할 수 있다.
        //     self.disposeBag = DisposeBag()  // 한 번에 리소스 정리
        // }
    }
}
