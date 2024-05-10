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

protocol MoviesListDisplayLogic: AnyObject {
    func displayFirstData(viewModel: MoviesList.InitialFetch.ViewModel) -> Void
    func displayMoreData(viewModel: MoviesList.FetchMoreData.ViewModel) -> Void
    func displaySecondScreen(withMovie movie: MovieModel) -> Void
    func displayLoadingMore() -> Void
}

class MoviesListViewController: UIViewController {
    var viewModel: MoviesList.ViewModel = MoviesList.ViewModel(
        currentPage: 1,
        hasNextPage: true,
        isLoadingMore: false,
        movies: [])
    
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
    
    func doFetchMoreData() {
        if viewModel.isLoadingMore || !viewModel.hasNextPage {
            return
        }
        
        Task {
            let request = MoviesList.FetchMoreData.Request(page: viewModel.currentPage + 1)
            await interactor?.doFetchMoreData(request: request)
        }
    }
}

extension MoviesListViewController: MoviesListDisplayLogic {
    func displayFirstData(viewModel: MoviesList.InitialFetch.ViewModel) {
        self.viewModel.movies = viewModel.movies
        reloadCollectionViewData()
    }
    
    func displayMoreData(viewModel: MoviesList.FetchMoreData.ViewModel) {
        self.viewModel.currentPage = viewModel.currentPage
        self.viewModel.hasNextPage = viewModel.hasNextPage
        self.viewModel.movies.append(contentsOf: viewModel.movies)
        self.viewModel.isLoadingMore = false
        
        reloadCollectionViewData()
    }
    
    func displayLoadingMore() {
        viewModel.isLoadingMore = true
        reloadCollectionViewData()
    }
    
    func displaySecondScreen(withMovie movie: MovieModel) {
        router?.routeToSecondScreen(withMovie: movie)
    }
    
    private func reloadCollectionViewData() {
        DispatchQueue.main.async {
            self.collectionView?.reloadData()
        }
    }
}

// Handle logic for the collectionView
extension MoviesListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    // Number of items in the collection view
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.movies.count
    }
    
    // Manage the cell at index
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MoviesListItemCVC.identifier, for: indexPath) as? MoviesListItemCVC else {
            fatalError("Failed to dequeue a MovieCell.")
        }
        
        cell.configureCell(withMovie: viewModel.movies[indexPath.item])
        cell.delegate = self
        
        return cell
    }
    
    // Execute code when the cell is on the screen
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.item == viewModel.movies.count - 1 {
            self.doFetchMoreData()
        }
    }
}

extension MoviesListViewController: MoviesListItemCVCDelegate {
    func onCellTapped(movie: MovieModel) {
        interactor?.onCellTapped(withMovie: movie)
    }
}
