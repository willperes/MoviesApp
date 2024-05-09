//
//  ListMoviesPresenter.swift
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

protocol ListMoviesPresentationLogic {
    // func presentSomething(response: ListMovies.Something.Response)
    func presentSecondScreen(withColor color: UIColor) -> Void
}

class ListMoviesPresenter: ListMoviesPresentationLogic {
    weak var viewController: ListMoviesDisplayLogic?
    
    // MARK: Do something
    
    //  func presentSomething(response: ListMovies.Something.Response) {
    //    let viewModel = ListMovies.Something.ViewModel()
    //    viewController?.displaySomething(viewModel: viewModel)
    //  }
    
    func presentSecondScreen(withColor color: UIColor) {
        viewController?.displaySecondScreen(withColor: color)
    }
}
