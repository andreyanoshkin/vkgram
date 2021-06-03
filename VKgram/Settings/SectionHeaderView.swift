//
//  SectionHeaderView.swift
//  VKgram
//
//  Created by Andrey on 31/01/2021.
//  Copyright © 2021 Andrey. All rights reserved.
//

import UIKit

class SectionHeaderView: UITableViewHeaderFooterView {
    
    private (set) var customBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private (set) var sectionNameLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.Fonts.semiBoldOfSize16
        label.textAlignment = .left
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(sectionNameLabel)
        self.backgroundView = customBackgroundView
        updateConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        
        NSLayoutConstraint.activate([
            sectionNameLabel.topAnchor.constraint(equalTo: topAnchor),
            sectionNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            sectionNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            sectionNameLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}

