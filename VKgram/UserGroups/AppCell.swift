//
//  AppCell.swift
//  VKgram
//
//  Created by Andrey on 12/01/2021.
//  Copyright © 2021 Andrey. All rights reserved.
//

import UIKit

class AppCell: UICollectionViewCell {
    static var reuseId: String = "AppCell"
    
    let mainImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
//        view.backgroundColor = .systemOrange
        view.layer.cornerRadius = 10
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.font =  Constants.Fonts.semiBoldOfSize14
        label.numberOfLines = 1
        label.lineBreakMode = .byWordWrapping
//        label.backgroundColor = .systemYellow
        label.sizeToFit()
        label.textAlignment = .center
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        self.backgroundColor = .red
        addSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubviews() {
        contentView.addSubview(mainImageView)
        contentView.addSubview(titleLabel)
    }
    
    func configure(for item: App) {
        PhotoService.shared.photo(url: item.icon278) { image in
            self.mainImageView.image = image
        }
        titleLabel.text = item.title
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            mainImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            mainImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            mainImageView.heightAnchor.constraint(equalToConstant: 100),
            mainImageView.widthAnchor.constraint(equalTo: mainImageView.heightAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: mainImageView.bottomAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
            
        ])
    }
}

