//
//  SearchTableViewController.swift
//  TrendMedia
//
//  Created by taekki on 2022/07/19.
//

import UIKit

final class SearchTableViewController: UITableViewController {
    private var movieInfo: MovieInfo = MovieInfo()
    
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
