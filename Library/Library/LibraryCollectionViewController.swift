//
//  LibraryCollectionViewController.swift
//  Library
//
//  Created by taekki on 2022/07/21.
//

import UIKit

class LibraryCollectionViewController: UICollectionViewController {
    
    private let booklist: [Book] = Book.sampleData
    private let colorlist = [
        UIColor(hex: "#B22727FF"),
        UIColor(hex: "#EE5007FF"),
        UIColor(hex: "#F8CB2EFF"),
        UIColor(hex: "#006E7FFF"),
        UIColor(hex: "#764AF1FF"),
        UIColor(hex: "#FFD9C0ff"),
        UIColor(hex: "#68A7ADff"),
        UIColor(hex: "#FF8AAEff"),
        UIColor(hex: "#7C99ACff")
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureCollectionView()
        self.configureNavigationBar()
    }
    
    private func configureCollectionView() {
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 20
        let width = UIScreen.main.bounds.width - (spacing * 3)
        layout.itemSize = CGSize(width: width / 2, height: width / 2 * 1.1)
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        self.collectionView.collectionViewLayout = layout
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.booklist.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LibraryCollectionViewCell", for: indexPath) as! LibraryCollectionViewCell
        
        cell.backgroundColor = self.colorlist[indexPath.row % self.booklist.count]
        cell.layer.cornerRadius = 8
        cell.bookImageView.image = UIImage(named: "bookCover3")
        cell.configureCell(book: self.booklist[indexPath.row])
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let detailViewController = UIStoryboard(name: "Detail", bundle: nil).instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController else { return }
        
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
}

extension LibraryCollectionViewController {
    private func configureNavigationBar() {
        self.title = "도서 목록"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: self, action: #selector(presentToSearchScreen))
    }
    
    @objc func presentToSearchScreen() {
        guard let searchViewController = UIStoryboard(name: "Search", bundle: nil).instantiateViewController(withIdentifier: "SearchViewController") as? SearchViewController else { return }
        
        let searchNavigationController = UINavigationController(rootViewController: searchViewController)
        searchNavigationController.modalPresentationStyle = .fullScreen
        
        self.present(searchNavigationController, animated: true)
    }
}
