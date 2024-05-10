//
//  SecondScreen.swift
//  MoviesApp
//
//  Created by Willian Peres on 09/05/24.
//

import UIKit

class SecondScreen: UIViewController {
    var movie: MovieModel?
    
    private var contentView: UIView = {
        let cv = UIView()
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    private var descriptionTextView: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = .systemFont(ofSize: 14)
        l.numberOfLines = 0
        return l
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func configureScreen(withMovie movie: MovieModel) {
        view.backgroundColor = .systemBackground
        self.movie = movie
        setupUI()
    }
    
    func setupUI() {
        guard let movie = movie else {
            return
        }
        
        title = movie.title
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "")
        
        view.addSubview(contentView)
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            contentView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
        ])
        
        view.addSubview(descriptionTextView)
        descriptionTextView.text = movie.description
        descriptionTextView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            descriptionTextView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
            descriptionTextView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            descriptionTextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
}
