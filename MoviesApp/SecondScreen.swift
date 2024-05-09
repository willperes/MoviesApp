//
//  SecondScreen.swift
//  MoviesApp
//
//  Created by Willian Peres on 09/05/24.
//

import UIKit

class SecondScreen: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
    }
    
    func configureScreen(color: UIColor) {
        view.backgroundColor = color
    }
}
