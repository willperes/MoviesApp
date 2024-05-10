//
//  MoviesListViewController.swift
//  MoviesApp
//
//  Created by Willian Peres on 09/05/24.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

class MoviesListView: UIView {
    
}

protocol MoviesListDisplayLogic: AnyObject {
    func displayFirstData(viewModel: MoviesList.InitialFetch.ViewModel) -> Void
    func displaySecondScreen(withMovie movie: MovieModel) -> Void
}

class MoviesListViewController: UIViewController {
    var movies: [MovieModel] = []
    
    var interactor: MoviesListBusinessLogic?
    var router: (NSObjectProtocol & MoviesListRoutingLogic & MoviesListDataPassing)?
    
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    
    private func setup() {
        let viewController = self
        let interactor = MoviesListInteractor()
        let presenter = MoviesListPresenter()
        let router = MoviesListRouter()
        let worker = MoviesListWorker()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        interactor.worker = worker
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "UIKit Movies"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.backButtonTitle = "Back to movies list"
        
        self.setupUI()
        self.doFetchInitialData()
    }
    
    // MARK: Do something
    
    private var collectionView: UICollectionView?
    
    private func setupUI() {
        self.setupCollectionView()
    }
    
    func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        guard let collectionView = self.collectionView else {
            return
        }
        
        let numberOfColumns = 3.0
        let cellSpacing = 6.0
        
        let totalSpacing = cellSpacing * (numberOfColumns - 1)
        let cellWidth = ((view.frame.size.width - totalSpacing) / numberOfColumns) - 0.1
        let cellHeight = cellWidth * 1.4
        
        layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = cellSpacing
        layout.minimumInteritemSpacing = cellSpacing
        
        collectionView.register(MoviesListItemCVC.self, forCellWithReuseIdentifier: MoviesListItemCVC.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.frame = view.bounds
        
        view.addSubview(collectionView)
    }
    
    func doFetchInitialData() {
        Task {
            await interactor?.doFetchInitialData()
        }
    }
}

extension MoviesListViewController: MoviesListDisplayLogic {
    func displayFirstData(viewModel: MoviesList.InitialFetch.ViewModel) {
        self.movies = viewModel.movies
        
        DispatchQueue.main.async {
            self.collectionView?.reloadData()
        }
    }
    
    func displaySecondScreen(withMovie movie: MovieModel) {
        router?.routeToSecondScreen(withMovie: movie)
    }
}

// Handle logic for the collectionView
extension MoviesListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    // Number of items in the collection view
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.movies.count
    }
    
    // Manage the cell at index
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MoviesListItemCVC.identifier, for: indexPath) as? MoviesListItemCVC else {
            fatalError("Failed to dequeue a MovieCell.")
        }
        
        cell.configureCell(withMovie: self.movies[indexPath.item])
        cell.delegate = self
        
        return cell
    }
}

extension MoviesListViewController: MoviesListItemCVCDelegate {
    func onCellTapped(movie: MovieModel) {
        interactor?.onCellTapped(withMovie: movie)
    }
}
