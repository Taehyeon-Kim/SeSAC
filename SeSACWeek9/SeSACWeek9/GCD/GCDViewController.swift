//
//  GCDViewController.swift
//  SeSACWeek9
//
//  Created by taekki on 2022/09/02.
//

import UIKit

import UIKit

final class GCDViewController: UIViewController {
    
    let url1 = URL(string: "https://apod.nasa.gov/apod/image/2201/OrionStarFree3_Harbison_5000.jpg")!
    let url2 = URL(string: "https://apod.nasa.gov/apod/image/2112/M3Leonard_Bartlett_3843.jpg")!
    let url3 = URL(string: "https://apod.nasa.gov/apod/image/2112/LeonardMeteor_Poole_2250.jpg")!
    
    @IBOutlet weak var imageView1: UIImageView!
    @IBOutlet weak var imageView2: UIImageView!
    @IBOutlet weak var imageView3: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func serialSync(_ sender: UIButton) {
        print("START", terminator: " ")
        
        for i in 1...100 {
            print(i, terminator: " ")
        }
        
        // 무한 대기 상태에 빠짐
        // - Deadlock(교착 상태)라고 부름
        // - 일반적으로 main sync는 사용하지 않음
        DispatchQueue.main.sync {
            for i in 101...200 {
                print(i, terminator: " ")
            }
        }
        
        print("END")
    }
    
    @IBAction func serialAsync(_ sender: UIButton) {
        print("START", terminator: " ")

        DispatchQueue.main.async {
            for i in 1...100 {
                print(i, terminator: " ")
            }
        }

        // 순서대로 동작
//        for i in 1...100 {
//            DispatchQueue.main.async {
//                print(i, terminator: " ")
//            }
//        }

        for i in 101...200 {
            print(i, terminator: " ")
        }
        
        print("END")
    }
    
    // 메인스레드와 동작이 유사하다.
    // Task만 다른 스레드로 보내는 것 뿐.
    // 쓸 일 없음.
    @IBAction func globalSync(_ sender: UIButton) {
        print("START", terminator: " ")
        
        DispatchQueue.global().sync {
            for i in 1...100 {
                print(i, terminator: " ")
            }
        }
        
        for i in 101...200 {
            print(i, terminator: " ")
        }
        
        print("END")
    }
    
    // \(Thread.isMainThread) - 닭벼슬 ㅋㅋ
    @IBAction func globalAsync(_ sender: UIButton) {
        print("START \(Thread.isMainThread)", terminator: " ")
//        
//        DispatchQueue.global().async {
//            for i in 1...100 {
//                print(i, terminator: " ")
//            }
//        }
        
        for i in 1...100 {
            DispatchQueue.global().async {
                print(i, terminator: " ")
            }
        }
        
        for i in 101...200 {
            print(i, terminator: " ")
        }
        
        print("END \(Thread.isMainThread)")
    }
    
    @IBAction func qos(_ sender: UIButton) {
//        DispatchQueue.global(qos: .background).async {
//            for i in 1...100 {
//                print(i, terminator: " ")
//            }
//        }
//
//        DispatchQueue.global(qos: .userInteractive).async {
//            for i in 101...200 {
//                print(i, terminator: " ")
//            }
//        }
//
//        DispatchQueue.global(qos: .utility).async {
//            for i in 201...300 {
//                print(i, terminator: " ")
//            }
//        }
        
        let customQueue = DispatchQueue(label: "concurrentSeSAC", qos: .userInteractive, attributes: .concurrent)
        
        customQueue.async {
            print("START")
        }
        
        for i in 1...100 {
            DispatchQueue.global(qos: .background).async {
                print(i, terminator: " ")
            }
        }
        
        for i in 101...200 {
            DispatchQueue.global(qos: .userInteractive).async {
                print(i, terminator: " ")
            }
        }
        
        for i in 201...300 {
            DispatchQueue.global(qos: .utility).async {
                print(i, terminator: " ")
            }
        }
    }
    
    @IBAction func dispatchGroup(_ sender: UIButton) {
        
        // 하나의 화면에서 2개의 네트워크 통신을 하고 화면을 갱신하려고 할 때
        // 여러 개의 통신 후에
        // - 통신을 모두 마치는대로 화면에 뿌려주고 싶은 상황!
        
        let group = DispatchGroup()
        
        DispatchQueue.global().async(group: group) {
            for i in 1...100 {
                print(i, terminator: " ")
            }
        }
        
        DispatchQueue.global().async(group: group) {
            for i in 101...200 {
                print(i, terminator: " ")
            }
        }
        
        DispatchQueue.global().async(group: group) {
            for i in 201...300 {
                print(i, terminator: " ")
            }
        }
        
        group.notify(queue: .main) {
            print("끝")  // tableView.reload
        }
    }
    
    @IBAction func dispatchGroupNASA(_ sender: UIButton) {
        
//        request(url: url1) { image in
//            print("1")
//            self.request(url: self.url2) { image in
//                print("2")
//                self.request(url: self.url3) { image in
//                    print("3")
//                    print("끝, 갱신!")
//                }
//            }
//        }
        
        
        let group = DispatchGroup()
        
        DispatchQueue.global().async(group: group) {
            for i in 1...100 {
                print(i, terminator: " ")
            }
            
            self.request(url: self.url1) { image in // 그룹에 등록되지 않은 다른 스레드
                print("1")
            }
        }
        
        DispatchQueue.global().async(group: group) {
            self.request(url: self.url2) { image in // 그룹에 등록되지 않은 다른 스레드
                print("2")
            }
        }
        
        DispatchQueue.global().async(group: group) {
            self.request(url: self.url3) { image in // 그룹에 등록되지 않은 다른 스레드
                print("3")
            }
        }

        group.notify(queue: .main) {
            print("끝 완료~")
        }
    }
    
    func request(url: URL, completionHandler: @escaping (UIImage?) -> Void) {
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                completionHandler(UIImage(systemName: "star"))
                return
            }
            
            let image = UIImage(data: data)
            completionHandler(image)
            
        }.resume()
    }
    
    @IBAction func enterLeave(_ sender: UIButton) {
        let group = DispatchGroup()

        var imageList: [UIImage] = []
        
        // Enter와 Leave를 통해서 시작과 끝나는 시점을 파악할 수 있다.
        // 항상 짝을 맞추는 것이 필요하다. +1, -1 개념
        group.enter()   // RC(Reference Count) + 1
        request(url: url1) { image in
            imageList.append(image!)
            group.leave()   // RC - 1
        }
        
        group.enter()
        request(url: url2) { image in
            imageList.append(image!)
            group.leave()
        }
        
        group.enter()
        request(url: url3) { image in
            imageList.append(image!)
            group.leave()
        }
        
        group.notify(queue: .main) {
            self.imageView1.image = imageList[0]
            self.imageView2.image = imageList[1]
            self.imageView3.image = imageList[2]
        }
    }
    
    // 알바생 1명
    func a() {
        let group = DispatchGroup()
        
        DispatchQueue.global().async(group: group) {
            for i in 1...100 {
                print(i, terminator: " ")
            }
            
            for i in 101...200 {
                print(i, terminator: " ")
            }
            
            for i in 201...300 {
                print(i, terminator: " ")
            }
        }
    }
    
    // 알바생 3명
    func b() {
        let group = DispatchGroup()
        
        DispatchQueue.global().async(group: group) {
            for i in 1...100 {
                print(i, terminator: " ")
            }
        }
        
        DispatchQueue.global().async(group: group) {
            for i in 101...200 {
                print(i, terminator: " ")
            }
        }
        
        DispatchQueue.global().async(group: group) {
            for i in 201...300 {
                print(i, terminator: " ")
            }
        }
    }
    
    
    // 비동기를 처리하다보면 같은 변수(공유 자원)에 접근하는 경우가 생김 -> deadlock 발생 가능
    @IBAction func raceCondition(_ sender: UIButton) {
        
        let group = DispatchGroup()
        
        var nickname = "SeSAC"
        
        DispatchQueue.global(qos: .userInteractive).async(group: group) {
            nickname = "고래밥"
            print("first: \(nickname)")
        }
        
        DispatchQueue.global(qos: .userInteractive).async(group: group) {
            nickname = "칙촉"
            print("second: \(nickname)")
        }
        
        DispatchQueue.global(qos: .userInteractive).async(group: group) {
            nickname = "올라프"
            print("third: \(nickname)")
        }
        
        group.notify(queue: .main) {
            print("result: \(nickname)")    // 무엇이 찍힐지 알 수 없음
        }
    }
}
