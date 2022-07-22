//
//  TrendTableViewController.swift
//  SeSACWeek3
//
//  Created by taekki on 2022/07/21.
//

import UIKit

class TrendTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func movieButtonTapped(_ sender: UIButton) {
        
        // 화면 전환 Step.
        // 1. 스토리보드 파일, 2. 스토리보드 내에 있는 뷰 컨트롤러, 3. 화면 전환
        
        // 영화 버튼 클릭 > BucketlistTableViewController Present
        // 1.
        let storyboard = UIStoryboard(name: "Trend", bundle: nil)
        
        // 2.
        let viewController = storyboard.instantiateViewController(withIdentifier: BucketlistTableViewController.identifier) as! BucketlistTableViewController
        
        switch sender.tag {
        case 0:
            viewController.placeholder = "검색할 영화를 입력해주세요."
        case 1:
            viewController.placeholder = "검색할 드라마를 입력해주세요."
        case 2:
            viewController.placeholder = "검색할 도서를 입력해주세요."
        default:
            fatalError()
        }
        
        let navigationController = UINavigationController(rootViewController: viewController)
        
        navigationController.modalPresentationStyle = .fullScreen
        
        // 3.
        self.present(navigationController, animated: true)
    }
    
    
}
