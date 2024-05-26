//
//  LoadingView.swift
//  WBPO-UIKit
//
//  Created by Tim Matlak on 26/05/2024.
//

import UIKit

class LoadingViewController: UIViewController {
    
    private let activityIndicatorView: UIActivityIndicatorView = {
        let activityIndicatorView = UIActivityIndicatorView(style: .large)
        activityIndicatorView.color = .systemBlue
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicatorView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        activityIndicatorView.startAnimating()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(activityIndicatorView)
        
        NSLayoutConstraint.activate([
            activityIndicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

