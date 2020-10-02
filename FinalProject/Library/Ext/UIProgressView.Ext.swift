//
//  UIProgressView.Ext.swift
//  FinalProject
//
//  Created by PCI0007 on 10/2/20.
//  Copyright © 2020 MBA0176. All rights reserved.
//

import UIKit

extension UIProgressView {
    
    open override func layoutSubviews() {
        super.layoutSubviews()

        let maskLayerPath = UIBezierPath(roundedRect: bounds, cornerRadius: 2.5)
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.path = maskLayerPath.cgPath
        layer.mask = maskLayer
    }
}
