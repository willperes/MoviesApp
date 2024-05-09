//
//  ViewController.swift
//  MoviesApp
//
//  Created by Willian Peres on 09/05/24.
//

import UIKit

class ViewController: UIViewController {
    private let scrollView: UIScrollView = {
        let sv = UIScrollView()
        // sv.backgroundColor = .systemRed
        return sv
    }()
    private let contentView: UIView = {
        let v = UIView()
        // v.backgroundColor = .systemPurple
        return v
    }()
    private let colorViews: [UIView] = {
        var colorViews: [UIView] = []
        for x in 1...10  {
            let cv = UIView()
            cv.backgroundColor = .random()
            colorViews.append(cv)
        }
        return colorViews
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
    
    private func setupUI() {
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Colors"
        
        self.view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        self.scrollView.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            
            contentView.topAnchor.constraint(equalTo: self.scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor),
            
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        
        setupScrollItems()
    }
    
    private func setupScrollItems() {
        for (index, item) in colorViews.enumerated() {
            self.contentView.addSubview(item)
            
            item.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                item.topAnchor.constraint(equalTo: index == 0 ? self.contentView.topAnchor : self.colorViews[index - 1].bottomAnchor, constant: index == 0 ? 0 : 10),
                item.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
                item.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
                item.widthAnchor.constraint(equalTo: self.contentView.widthAnchor),
                item.heightAnchor.constraint(equalToConstant: 200),
            ])
            
            if index == colorViews.count - 1 {
                item.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
            }
        }
    }
}

extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}

extension UIColor {
    static func random() -> UIColor {
        return UIColor(
           red:   .random(),
           green: .random(),
           blue:  .random(),
           alpha: 1.0
        )
    }
}
