//
//  MoviesListInteractor.swift
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

protocol MoviesListBusinessLogic {
    func doFetchInitialData() async -> Void
    func doFetchMoreData(request: MoviesList.FetchMoreData.Request) async -> Void
    func onCellTapped(withMovie movie: MovieModel) -> Void
}

protocol MoviesListDataStore {}

class MoviesListInteractor: MoviesListBusinessLogic, MoviesListDataStore {
    var presenter: MoviesListPresentationLogic?
    var worker: MoviesListWorker?
    
    func doFetchInitialData() async -> Void {
        await worker?.fetchInitialData { data, error in
            guard let data = data, error == nil else {
                // TODO: handle error
                if let error {
                    print(error.localizedDescription)
                }
                return
            }
            
            let response = MoviesList.InitialFetch.Response(data: data)
            self.presenter?.presentFirstData(response: response)
        }
    }
    
    func doFetchMoreData(request: MoviesList.FetchMoreData.Request) async -> Void {
        presenter?.presentLoadingMore()
        
        await worker?.fetchMoreData(request: request) { data, error in
            guard let data = data, error == nil else {
                // TODO: handle error
                if let error {
                    print("Erro: \(error.localizedDescription)")
                }
                return
            }
            
            let response = MoviesList.FetchMoreData.Response(data: data)
            self.presenter?.presentMoreData(response: response)
        }
    }
    
    func onCellTapped(withMovie movie: MovieModel) {
        presenter?.presentSecondScreen(withMovie: movie)
    }
}
