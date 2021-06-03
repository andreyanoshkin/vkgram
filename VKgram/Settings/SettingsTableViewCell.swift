//
//  SettingsTableViewCell.swift
//  VKgram
//
//  Created by Andrey on 31/01/2021.
//  Copyright © 2021 Andrey. All rights reserved.
//

import UIKit

class SettingsTableViewCell: UITableViewCell { // TODO: to add search bar
    
    private(set) var settingTitle: UILabel = {
        let label = UILabel()
        label.font = Constants.Fonts.semiBoldOfSize14
        label.textColor = UIColor.black.withAlphaComponent(0.9)
        label.textAlignment = .left
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private(set) var arrowImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "leftArrow") // TODO: to resolve the issue of image low resolution
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private(set) var settingSwitch: VkSwitch = {
        let toggle = VkSwitch()
        toggle.addTarget(self, action: #selector(switchToggle), for: .valueChanged)
        
        toggle.translatesAutoresizingMaskIntoConstraints = false
        return toggle
    }()
    
    private (set) var separator: SeparatorLineView = {
        let view = SeparatorLineView()
        view.alpha = 0.2 // TODO: to find out why it is not configurable in the class
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(arrowImage)
        addSubview(settingTitle)
        addSubview(settingSwitch)
        addSubview(separator)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func configure(rowTitle: String, switchIsShown: Bool, row: Int) {
        settingTitle.text = rowTitle
        switch switchIsShown {
        case false:
            settingSwitch.isHidden = true
            arrowImage.isHidden = false
        case true:
            settingSwitch.isHidden = false
            arrowImage.isHidden = true
        }
        
        switch row {
        case 0:
            self.separator.isHidden = true
        default:
            self.separator.isHidden = false
        }
    }
    
    @objc func switchToggle() { // TODO: needs further development
        if settingSwitch.isOn() {
            debugPrint ("Toggle is on")
        } else {
            debugPrint ("Toggle is off")
        }
    }
    
    func setupConstraints() {
        
        NSLayoutConstraint.activate([
            
            settingTitle.centerYAnchor.constraint(equalTo: centerYAnchor),
            settingTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            settingTitle.widthAnchor.constraint(equalTo: widthAnchor, multiplier: frame.width * 0.6), // TODO: to put in constants
            settingTitle.heightAnchor.constraint(equalToConstant: 20), // TODO: to put in constants
            
            arrowImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            arrowImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            arrowImage.widthAnchor.constraint(equalToConstant: 7.93),
            arrowImage.heightAnchor.constraint(equalToConstant: 13),
            
            settingSwitch.centerYAnchor.constraint(equalTo: centerYAnchor),
            settingSwitch.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            settingSwitch.widthAnchor.constraint(equalToConstant: 52),
            settingSwitch.heightAnchor.constraint(equalToConstant: 32),
            
            separator.topAnchor.constraint(equalTo: topAnchor),
            separator.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            separator.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            separator.heightAnchor.constraint(equalToConstant: 1),
        ])
        
    }
    
    
    
}


