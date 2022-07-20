//
//  SearchTableViewController.swift
//  TrendMedia
//
//  Created by taekki on 2022/07/19.
//

import UIKit

final class SearchTableViewController: UITableViewController {
    private var movieList: [Movie] = Movie.sampleData
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell") as! MovieCell
        cell.configureCell(data: movieList[indexPath.row])
        return cell
    }
}
