import UIKit

/*
 클로저, 클래스 등의 참조 타입일 때 weak를 사용하자
 */

// 프로토콜을 클래스에서만 사용할 수 있도록 제한해주어야 한다.
// 구조체에서는 사용하지 않고, 클래스에서만 사용할 수 있도록 제약을 걸어주어야 한다.
protocol MyDelegate: AnyObject {
    func sendData(_ data: String)
}

class Main: MyDelegate {
    
    lazy var detail: Detail = {
        let view = Detail()
        view.delegate = self
        return view
    }()
    
    func sendData(_ data: String) {
        print("\(data)를 전달받았다.")
    }
    
    init() {
        print("Main init")
    }
    
    deinit {
        print("Main Deinit")
    }
}

class Detail {
    
    weak var delegate: MyDelegate?   // 타입으로서의 프로토콜: 프로토콜이 타입으로서 기능을 하고 있음. 클래스의 인스턴스가 들어올 수 있다. (RC를 증가시키지 않기 위해 weak를 붙여주어야 함)
    
    func dismiss() {
        delegate?.sendData("안녕")
    }
    
    init() {
        print("Detail init")
    }
    
    deinit {
        print("Detail Deinit")
    }
}

var main: Main? = Main()        // RC 1
main?.detail                    // RC 2 ... lazy var 이기 때문에 이 때 메모리에 올라간다.
main = nil                      // RC 1

// weak 키워드를 사용하지 않으면 뷰 컨트롤러가 해제되지 않는 문제가 발생한다.
// 생명주기에도 영향을 미칠 수 있다.


