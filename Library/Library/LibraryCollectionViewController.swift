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
}
