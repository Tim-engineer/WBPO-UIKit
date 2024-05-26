//
//  ListCell.swift
//  WBPO-UIKit
//
//  Created by Tim Matlak on 26/05/2024.
//

import UIKit

class ListCell: UITableViewCell {
    
    var isFollowed = false
    
    var user: User? {
        didSet {
            configure()
        }
    }
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 50
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let emailLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var followButton: UIButton = {
        let button = UIButton(type: .system)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let spacerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(profileImageView)
        addSubview(nameLabel)
        addSubview(emailLabel)
        addSubview(followButton)
        addSubview(spacerView)
        
        NSLayoutConstraint.activate([
            profileImageView.widthAnchor.constraint(equalToConstant: 100),
            profileImageView.heightAnchor.constraint(equalToConstant: 100),
            profileImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            profileImageView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            profileImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            
            nameLabel.topAnchor.constraint(equalTo: profileImageView.topAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: spacerView.leadingAnchor, constant: -8),
            
            spacerView.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            spacerView.trailingAnchor.constraint(equalTo: followButton.leadingAnchor),
            spacerView.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor),
            
            followButton.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor),
            followButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            emailLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            emailLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            emailLabel.trailingAnchor.constraint(equalTo: followButton.leadingAnchor, constant: -8),
            emailLabel.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -8)
        ])
    }
    
    private func configure() {
        guard let user = user else { return }
        nameLabel.text = "\(user.firstName) \(user.lastName)"
        emailLabel.text = "Email Address:\n\(user.email)"
        followButton.setTitle("Follow", for: .normal)
        followButton.setTitleColor(.systemGreen, for: .normal)
        followButton.addTarget(self, action: #selector(followButtonTapped), for: .touchUpInside)
        
        // Load image asynchronously from URL
        if let imageUrl = URL(string: user.avatar) {
            DispatchQueue.global().async { [weak self] in
                if let imageData = try? Data(contentsOf: imageUrl), let image = UIImage(data: imageData) {
                    DispatchQueue.main.async {
                        self?.profileImageView.image = image
                    }
                }
            }
        }
    }
    
    @objc private func followButtonTapped() {
        // Toggle the follow status and update button title and color accordingly
        guard user != nil else { return }
        isFollowed.toggle()
        if isFollowed {
            followButton.setTitle("Unfollow", for: .normal)
            followButton.setTitleColor(.systemRed, for: .normal)
        } else {
            followButton.setTitle("Follow", for: .normal)
            followButton.setTitleColor(.systemGreen, for: .normal)
        }
    }
}

