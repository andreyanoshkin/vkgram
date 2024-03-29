//
//  LikeBarView.swift
//  LoginForm
//
//  Created by Andrey on 01/09/2020.
//  Copyright © 2020 Andrey. All rights reserved.
//

import UIKit

class LikeBarView: UIView {
    
    var likeButton: LikeButton = {
        let button = LikeButton()
        button.strokeColor = .black
        button.tintColor = .systemPink
//        button.backgroundColor = .green
        button.addTarget(self, action: #selector(likeButtonPressed), for: .touchUpInside)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    var likeCounterLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.Fonts.semiBoldOfSize16
        label.numberOfLines = 1
//        label.backgroundColor = .lightGray
        label.sizeToFit()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var viewsCounterLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.Fonts.semiBoldOfSize14
        label.numberOfLines = 1
//        label.backgroundColor = .white
        label.sizeToFit()
        label.alpha = 0.2
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var likeTextLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.Fonts.semiBoldOfSize16
        label.text = "likes"
        label.textAlignment = .left
//        label.backgroundColor = .magenta
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var commentButton: UIButton = {
        let button = UIButton()
        let image = UIImage(named: "comment")
        button.setImage(image, for: .normal)
//        button.backgroundColor = .white
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var shareButton: UIButton = {
        let button = UIButton()
        let image = UIImage(named: "plane")
        button.setImage(image, for: .normal)
//        button.backgroundColor = .white
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var viewsView: UIImageView = {
        let view = UIImageView()
        let image = UIImage(named: "views")
        view.image = image
        view.alpha = 0.2
//        view.backgroundColor = .white
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var animationStartDate = Date()
    var startValue = Double()
    var endValue = Double()
    var animationDuration = 1.1
    
    var theme: Theme = .black
    
    enum Theme {
           case black
           case white
       }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(likeButton)
        addSubview(likeCounterLabel)
        addSubview(likeTextLabel)
        addSubview(commentButton)
        addSubview(shareButton)
        addSubview(viewsView)
        addSubview(viewsCounterLabel)
        setupConstraints()

    }
    
    convenience init(theme: Theme) {
        self.init()
        self.theme = theme
        setupTheme()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupTheme()
    }
    
    func setupConstraints() {
        
        NSLayoutConstraint.activate([
            
            likeButton.topAnchor.constraint(equalTo: topAnchor),
            likeButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            likeButton.widthAnchor.constraint(equalTo: likeButton.heightAnchor),
            likeButton.heightAnchor.constraint(equalToConstant: 25),
            
            commentButton.topAnchor.constraint(equalTo: topAnchor),
            commentButton.leadingAnchor.constraint(equalTo: likeButton.trailingAnchor, constant: 20),
            commentButton.widthAnchor.constraint(equalTo: commentButton.heightAnchor),
            commentButton.heightAnchor.constraint(equalToConstant: 25),
            
            shareButton.topAnchor.constraint(equalTo: topAnchor),
            shareButton.leadingAnchor.constraint(equalTo: commentButton.trailingAnchor, constant: 20),
            shareButton.widthAnchor.constraint(equalTo: shareButton.heightAnchor),
            shareButton.heightAnchor.constraint(equalToConstant: 25),
            
            viewsView.centerYAnchor.constraint(equalTo: likeButton.centerYAnchor),
            viewsView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            viewsView.widthAnchor.constraint(equalTo: viewsView.heightAnchor, multiplier: 2),
            viewsView.heightAnchor.constraint(equalToConstant: 15),
            
            viewsCounterLabel.centerYAnchor.constraint(equalTo: likeButton.centerYAnchor),
            viewsCounterLabel.trailingAnchor.constraint(equalTo: viewsView.leadingAnchor, constant: -20),
            viewsCounterLabel.heightAnchor.constraint(equalToConstant: 15),
            
            likeCounterLabel.topAnchor.constraint(equalTo: likeButton.bottomAnchor, constant: 20),
            likeCounterLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            likeCounterLabel.heightAnchor.constraint(equalToConstant: 20),
            likeCounterLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            likeTextLabel.centerYAnchor.constraint(equalTo: likeCounterLabel.centerYAnchor),
            likeTextLabel.leadingAnchor.constraint(equalTo: likeCounterLabel.trailingAnchor, constant: 8),
            likeTextLabel.heightAnchor.constraint(equalToConstant: 20),
            
        ])
        
    }
    
    func setupTheme() {
        switch theme {
            
        case .black:
            likeButton.strokeColor = .black
            likeCounterLabel.textColor = .black
            viewsCounterLabel.textColor = .black
            likeTextLabel.textColor = .black
            let commentButtonBlackImage = UIImage(named: "comment")
            commentButton.setImage(commentButtonBlackImage, for: .normal)
            let shareButtonBlackImage = UIImage(named: "plane")
            shareButton.setImage(shareButtonBlackImage, for: .normal)
            let viewsViewBlackImage = UIImage(named: "views")
            viewsView.image = viewsViewBlackImage
            
        case .white:
            likeButton.strokeColor = .white
            likeCounterLabel.textColor = .white
            viewsCounterLabel.textColor = .white
            likeTextLabel.textColor = .white
            let commentButtonWhiteImage = UIImage(named: "commentWhite")
            commentButton.setImage(commentButtonWhiteImage, for: .normal)
            let shareButtonWhiteImage = UIImage(named: "planeWhite")
            shareButton.setImage(shareButtonWhiteImage, for: .normal)
            let viewsViewWhiteImage = UIImage(named: "viewsWhite")
            viewsView.image = viewsViewWhiteImage
        }
    }
    
    @objc func likeButtonPressed(_ sender: Any) {
        
        animationStartDate = Date()
        startValue = Double()
        endValue = Double()
        
        let count = Int(likeCounterLabel.text!)
        startValue = Double(count! / 2)
        
        if likeButton.filled {
            endValue = Double(count! + 1)
        } else {
            let count = Int(likeCounterLabel.text!)
            endValue = Double(count! - 1)
        }
        
        let displayLink = CADisplayLink(target: self, selector: #selector(handleUpdate))
        displayLink.add(to: .main, forMode: .default)
        
    }
    
    @objc func handleUpdate(){
        
        likeButton.isUserInteractionEnabled = false
        likeButton.superview?.superview?.superview?.isUserInteractionEnabled = false
        
        let now = Date()
        let elapsedTime = now.timeIntervalSince(animationStartDate)
        
        if elapsedTime > animationDuration {
            self.likeCounterLabel.text = "\(Int((endValue)))"
            likeButton.isUserInteractionEnabled = true
            likeButton.superview?.superview?.superview?.isUserInteractionEnabled = true
        } else {
            let percentage = elapsedTime / animationDuration
            let value = startValue + percentage * (endValue - startValue)
            self.likeCounterLabel.text = "\(Int((value)))"
        }
    }
}

