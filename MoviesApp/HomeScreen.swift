//
//  HomeScreen.swift
//  MoviesApp
//
//  Created by Willian Peres on 09/05/24.
//

import UIKit

class HomeScreen: UIViewController {
    private var collectionView: UICollectionView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configure the navigationController title
        title = "Movies"
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
        let cellWidth = ((view.frame.size.width - totalSpacing) / numberOfColumns) - 0.1
        let cellHeight = cellWidth * 1.35
        
        layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = cellSpacing
        layout.minimumInteritemSpacing = cellSpacing
        
        collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: CustomCollectionViewCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.frame = view.bounds
        
        view.addSubview(collectionView)
    }
}

// Handle logic for the collectionView
extension HomeScreen: UICollectionViewDelegate, UICollectionViewDataSource {
    // Number of items in the collection view
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
    
    // Manage the cell at index
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCell.identifier, for: indexPath) as? CustomCollectionViewCell else {
            fatalError("Failed to dequeue a MovieCell.")
        }
        
        cell.configureCell(color: .random())
        cell.delegate = self
        
        return cell
    }
}

extension HomeScreen: CustomCollectionViewCellDelegate {
    func onCellTapped(color: UIColor) {
        let secondScreen = SecondScreen()
        secondScreen.configureScreen(color: color)
        
        navigationController?.pushViewController(secondScreen, animated: true)
    }
}
