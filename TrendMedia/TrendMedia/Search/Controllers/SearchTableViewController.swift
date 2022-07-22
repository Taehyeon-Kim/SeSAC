//
//  SearchTableViewController.swift
//  TrendMedia
//
//  Created by taekki on 2022/07/19.
//

import UIKit

final class SearchTableViewController: UITableViewController {
    private var movieInfo: MovieInfo = MovieInfo()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "처음으로", style: .plain, target: self, action: #selector(resetButtonClicked))
    }
    
    @objc func resetButtonClicked() {
        // 시작 화면 초기화
        // iOS 13.0+ SceneDelegate 쓸 때 동작하는 코드
        // 기존에 쌓여있던 화면들은 메모리에서 전부 내려가게 된다.
        // 앱의 상태를 바꿀 때 window를 사용하는 편이다.
        
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let sceneDelegate = windowScene?.delegate as? SceneDelegate
        
        let sb = UIStoryboard(name: "Trend", bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: "ViewController") as? ViewController else { return }

        sceneDelegate?.window?.rootViewController = vc
        sceneDelegate?.window?.makeKeyAndVisible()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieInfo.movie.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell") as! MovieCell
        cell.configureCell(data: movieInfo.movie[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height / 6
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Trend", bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier: RecommendCollectionViewController.identifier) as! RecommendCollectionViewController
        
        // 2. 값 전달 - vc가 가지고 있는 프로퍼티에 데이터 추가
//        viewController.movieTitle = self.movieInfo.movie[indexPath.row].title
        viewController.movieData = self.movieInfo.movie[indexPath.row]
        
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
