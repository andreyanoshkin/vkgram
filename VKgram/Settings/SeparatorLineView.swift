//
//  SeparatorLineView.swift
//  VKgram
//
//  Created by Andrey on 31/01/2021.
//  Copyright © 2021 Andrey. All rights reserved.
//

import UIKit

class SeparatorLineView: UIView {
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let path = UIBezierPath()
        
        path.move(to: CGPoint(x: frame.height, y: frame.width))
        path.addLine(to: CGPoint(x: 0, y: frame.width))
        path.close()
        
        UIColor.gray.withAlphaComponent(0.2).set()
        
        path.stroke()
    }
}
