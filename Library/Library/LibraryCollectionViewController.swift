//
//  LibraryCollectionViewController.swift
//  Library
//
//  Created by taekki on 2022/07/21.
//

import UIKit

class LibraryCollectionViewController: UICollectionViewController {
    
    private let booklist: [Book] = Book.sampleData

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureCollectionView()
        self.configureNavigationBar()
    }
    
    private func configureCollectionView() {
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 8
        let width = UIScreen.main.bounds.width - (spacing * 3)
        layout.itemSize = CGSize(width: width / 2, height: width / 2)
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
        
        cell.backgroundColor = .orange
        cell.bookImageView.backgroundColor = .gray
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
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: self, action: #selector(presentToSearchScreen))
    }
    
    @objc func presentToSearchScreen() {
        guard let searchViewController = UIStoryboard(name: "Search", bundle: nil).instantiateViewController(withIdentifier: "SearchViewController") as? SearchViewController else { return }
        
        let searchNavigationController = UINavigationController(rootViewController: searchViewController)
        searchNavigationController.modalPresentationStyle = .fullScreen
        
        self.present(searchNavigationController, animated: true)
    }
}
