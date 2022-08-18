import UIKit

func configureBorderLabel(_ view: UILabel) {
    view.backgroundColor = .clear
    view.clipsToBounds = true
    view.layer.cornerRadius = 8
    view.layer.borderColor = UIColor.black.cgColor
    view.layer.borderWidth = 1
}

func configureBorderTextField(_ view: UITextField) {
    view.backgroundColor = .clear
    view.clipsToBounds = true
    view.layer.cornerRadius = 8
    view.layer.borderColor = UIColor.black.cgColor
    view.layer.borderWidth = 1
}

/*
 Generic
 - 타입에 유연하게 대응
 - Type Parameter: 플레이스 홀더 같은 역할, 어떤 타입인지 타입의 종류는 알려주지 않음. 특정한 타입 하나라는 것은 알 수 있음. 제네릭으로 이루어진 함수 사용 시 T에 들어갈 타입은 모두 같아야 한다.
 - UpperCased. ex. T(Type) U(Upper) K(Key)
 - Type Constraints: 클래스/프로토콜 제약
 */

// ex1.
func configureBorder<T: UIView>(_ view: T) {
    view.backgroundColor = .clear
    view.clipsToBounds = true
    view.layer.cornerRadius = 8
    view.layer.borderColor = UIColor.black.cgColor
    view.layer.borderWidth = 1
}

let img = UIImageView()
let lbl = UILabel()

configureBorder(img)
configureBorder(lbl)

// ex2.
struct DummyData<T, U> {
    var mainContents: T
    var subContents: U
}

let cast = DummyData(mainContents: "현빈", subContents: 1234)
let phoneNumber = DummyData(mainContents: "고래밥", subContents: 4567)

// ex3.
func total(a: [Int]) -> Int {
    return a.reduce(0, +)
}

func total(a: [Float]) -> Float {
    return a.reduce(0, +)
}

func total(a: [Double]) -> Double {
    return a.reduce(0, +)
}

total(a: [1, 2, 3, 4, 5, 6, 7, 8, 9])

func total<T: Numeric>(a: [T]) -> T {
    return a.reduce(.zero, +)
}

// ex4.
class SampleViewController: UIViewController {
    
    func transitionViewController<T: UIViewController>(sb: String, vc: T) {
        
        let sb = UIStoryboard(name: sb, bundle: nil)
        let vc = sb.instantiateViewController(identifier: String(describing: vc)) as! T
        
        self.present(vc, animated: true)
    }
}

class Animal: Equatable {
    
    static func == (lhs: Animal, rhs: Animal) -> Bool {
        return lhs.name == rhs.name && lhs.age == rhs.age
    }
    
    var name: String
    var age: Int
    
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
}

let one = Animal(name: "고양이", age: 10)
let two = Animal(name: "고양이", age: 7)

one == two


var fruit1 = "사과"
var fruit2 = "바나나"

swap(&fruit1, &fruit2)  // inout parameter
print(fruit1, fruit2)

// 주소값을 복사
func swapTwoInts<T>(a: inout T, b: inout T) {
    let tempA = a
    a = b
    b = tempA
}

swapTwoInts(a: &fruit1, b: &fruit2)
print(fruit1, fruit2)
