//
//  SearchTableViewController.swift
//  TrendMedia
//
//  Created by taekki on 2022/07/19.
//

import UIKit

final class SearchTableViewController: UITableViewController {
    var dataSource: [Movie] = [
        Movie(posterTitle: "마녀", posterReleaseDate: "22.08.10", posterDescription: "재밌어요재밌어요재밌어요재밌어요재밌어요재밌어요"),
        Movie(posterTitle: "마녀", posterReleaseDate: "22.08.10", posterDescription: "재밌어요재밌어요재밌어요재밌어요재밌어요재밌어요"),
        Movie(posterTitle: "마녀", posterReleaseDate: "22.08.10", posterDescription: "재밌어요재밌어요재밌어요재밌어요재밌어요재밌어요"),
        Movie(posterTitle: "마녀", posterReleaseDate: "22.08.10", posterDescription: "재밌어요재밌어요재밌어요재밌어요재밌어요재밌어요"),
        Movie(posterTitle: "마녀", posterReleaseDate: "22.08.10", posterDescription: "재밌어요재밌어요재밌어요재밌어요재밌어요재밌어요"),
        Movie(posterTitle: "마녀", posterReleaseDate: "22.08.10", posterDescription: "재밌어요재밌어요재밌어요재밌어요재밌어요재밌어요"),
        Movie(posterTitle: "마녀", posterReleaseDate: "22.08.10", posterDescription: "재밌어요재밌어요재밌어요재밌어요재밌어요재밌어요"),
        Movie(posterTitle: "마녀", posterReleaseDate: "22.08.10", posterDescription: "재밌어요재밌어요재밌어요재밌어요재밌어요재밌어요"),
        Movie(posterTitle: "마녀", posterReleaseDate: "22.08.10", posterDescription: "재밌어요재밌어요재밌어요재밌어요재밌어요재밌어요"),
        Movie(posterTitle: "마녀", posterReleaseDate: "22.08.10", posterDescription: "재밌어요재밌어요재밌어요재밌어요재밌어요재밌어요")
    ]
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell") as! MovieCell
        let url = URL(string: "https://www.dccomics.com/sites/default/files/styles/comics320x485/public/movie-covers/2022/05/Movies-Thumb_ConstantineHOM_6270a29abe6878.78823858.jpg?itok=R-DtukJo")
        let data = try! Data(contentsOf: url!)
        cell.posterImageView.image = UIImage(data: data)
        cell.contentMode = .scaleToFill
        cell.movieTitleLabel.text = dataSource[indexPath.row].posterTitle
        cell.movieReleaseLabel.text = dataSource[indexPath.row].posterReleaseDate
        cell.movieDescriptionLabel.text = dataSource[indexPath.row].posterDescription
        return cell
    }
}
