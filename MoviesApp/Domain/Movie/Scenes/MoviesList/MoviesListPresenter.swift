//
//  MoviesListPresenter.swift
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

protocol MoviesListPresentationLogic {
    func presentFirstData(response: MoviesList.InitialFetch.Response) -> Void
    func presentMoreData(response: MoviesList.FetchMoreData.Response) -> Void
    func presentSecondScreen(withMovie movie: MovieModel) -> Void
    func presentLoadingMore() -> Void
}

class MoviesListPresenter: MoviesListPresentationLogic {
    weak var viewController: MoviesListDisplayLogic?
    
    func presentFirstData(response: MoviesList.InitialFetch.Response) {
        let movies = response.data.results.map { MovieModel.from($0) }
        let viewModel = MoviesList.InitialFetch.ViewModel(movies: movies)
        viewController?.displayFirstData(viewModel: viewModel)
    }
    
    func presentMoreData(response: MoviesList.FetchMoreData.Response) {
        let hasNextPage = response.data.total_pages > response.data.page
        let movies = response.data.results.map { MovieModel.from($0) }
        let viewModel = MoviesList.FetchMoreData.ViewModel(movies: movies, currentPage: response.data.page, hasNextPage: hasNextPage)
        viewController?.displayMoreData(viewModel: viewModel)
    }
    
    func presentSecondScreen(withMovie movie: MovieModel) {
        viewController?.displaySecondScreen(withMovie: movie)
    }
    
    func presentLoadingMore() {
        viewController?.displayLoadingMore()
    }
}
