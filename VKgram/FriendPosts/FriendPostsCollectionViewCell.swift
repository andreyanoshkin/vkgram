//
//  FriendPhotosCollectionViewCell.swift
//  LoginForm
//
//  Created by Andrey on 06/08/2020.
//  Copyright © 2020 Andrey. All rights reserved.
//

import UIKit

class FriendPostsCollectionViewCell: UICollectionViewCell {
    
    var friendPhotoImage: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var likeButton: LikeButton = {
        let button = LikeButton()
        button.strokeColor = .white
        button.tintColor = .systemPink
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var multiplePicSign: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "square.fill.on.square.fill")
        view.tintColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

//    var selectedPost = Post()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addViews() {
        addSubview(friendPhotoImage)
        addSubview(multiplePicSign)
        addSubview(likeButton)
    }
    
    func setupConstraints() {
        
        friendPhotoImage.pin(to: self)
        
        NSLayoutConstraint.activate([
            multiplePicSign.topAnchor.constraint(equalTo: topAnchor, constant: 4),
            multiplePicSign.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -4),
            multiplePicSign.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 1/5),
            multiplePicSign.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1/5),
            
            likeButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4),
            likeButton.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 1/5),
            likeButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1/5),
            likeButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4)
            
        ])
    }
    
    
    func configure(for model: Photo) {
        
        PhotoService.shared.photo(url: model.mediumPhoto) { image in
            self.friendPhotoImage.image = image
        }
    }
}
