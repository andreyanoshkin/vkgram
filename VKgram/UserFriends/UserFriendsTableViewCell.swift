//
//  UserFriendsTableViewCell.swift
//  VKgram
//
//  Created by Andrey on 17/09/2020.
//  Copyright © 2020 Andrey. All rights reserved.
//

import UIKit

class UserFriendsTableViewCell: UITableViewCell {
    
    var friendImage: RoundCornersImageView = {
        let view = RoundCornersImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var friendFirstName: UILabel = {
        let label = UILabel()
        label.font = Constants.Fonts.regularOfSize16
        label.sizeToFit()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var friendLastName: UILabel = {
        let label = UILabel()
        label.font = Constants.Fonts.semiBoldOfSize16
        label.sizeToFit()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var selectedFriend: User?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(friendImage)
        addSubview(friendFirstName)
        addSubview(friendLastName)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(for friend: User) {
        friendFirstName.text = "\(friend.firstName)"
        friendLastName.text = "\(friend.lastName)"
        PhotoService.shared.photo(url: friend.photo200) { image in
            self.friendImage.image = image
        }
        
        selectedFriend = friend
    }
    
    func setupConstraints() {
        
        NSLayoutConstraint.activate([
            
            friendImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            friendImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            
            friendImage.widthAnchor.constraint(equalTo: friendImage.heightAnchor),
            friendImage.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.8),
            
            friendFirstName.centerYAnchor.constraint(equalTo: centerYAnchor),
            friendFirstName.leadingAnchor.constraint(equalTo: friendImage.trailingAnchor, constant: 8),
            
            friendLastName.centerYAnchor.constraint(equalTo: centerYAnchor),
            friendLastName.leadingAnchor.constraint(equalTo: friendFirstName.trailingAnchor, constant: 6),
            
        ])
        
    }
    
    
    
}
