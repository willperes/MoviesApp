//
//  ViewController.swift
//  MoviesApp
//
//  Created by Willian Peres on 09/05/24.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    private var collectionView: UICollectionView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Colors"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        self.setupCollectionView()
    }
    
    func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        guard let collectionView = self.collectionView else {
            return
        }
        
        let numberOfColumns = 3.0
        let cellSpacing = 8.0
        
        let totalSpacing = cellSpacing * (numberOfColumns - 1)
        let cellWidth = ((view.frame.size.width - totalSpacing) / 3) - 0.1
        
        layout.itemSize = CGSize(width: cellWidth, height: cellWidth)
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = cellSpacing
        layout.minimumInteritemSpacing = cellSpacing
        
        collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: CustomCollectionViewCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.frame = view.bounds
        
        view.addSubview(collectionView)
    }
    
    // Number of items in the collection view
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
    
    // Manage the cell at index
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCell.identifier, for: indexPath)
        
        return cell
    }
}
