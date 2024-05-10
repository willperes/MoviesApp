//
//  MoviesListWorker.swift
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

protocol MoviesListWorkerProtocol {
    typealias Completion<D> = (_ result: D?, _ error: Error?) -> Void
    
    func fetchInitialData(_ completion: @escaping Completion<MoviesListResponseDTO>) async -> Void
}

class MoviesListWorker: MoviesListWorkerProtocol {
    func fetchInitialData(_ completion: @escaping Completion<MoviesListResponseDTO>) async -> Void {
        let data = Bundle.main.decode(MoviesListResponseDTO.self, from: "movies.json")
        completion(data, nil)
    }
}