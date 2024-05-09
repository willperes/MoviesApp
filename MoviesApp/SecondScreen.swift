//
//  SecondScreen.swift
//  MoviesApp
//
//  Created by Willian Peres on 09/05/24.
//

import UIKit

class SecondScreen: UIViewController {
    var color: UIColor?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func configureScreen(withColor color: UIColor) {
        view.backgroundColor = color
        self.color = color
        self.setupUI()
    }
    
    func setupUI() {
        guard let color = color else {
            return
        }
        
        title = color.accessibilityName.capitalized
        navigationItem.largeTitleDisplayMode = .never
    }
}
