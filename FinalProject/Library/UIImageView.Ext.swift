//
//  UIImageView.Ext.swift
//  FinalProject
//
//  Created by PCI0007 on 9/22/20.
//  Copyright © 2020 MBA0176. All rights reserved.
//

import UIKit

// MARK: - Add Blur Effect

extension UIImageView {
    
    func addBlurEffect() {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(blurEffectView)
    }
}

// MARK: - Add Gradient --> OK
extension UIView {
    
   // For insert layer in Foreground
    func addBlackGradientLayerInForeground(frame: CGRect, colors: [UIColor]) {
        let gradient = CAGradientLayer()
        gradient.frame = self.frame
        gradient.colors = colors.map { $0.cgColor }
        self.layer.addSublayer(gradient)
    }
   // For insert layer in background
    func addBlackGradientLayerInBackground(frame: CGRect, colors: [UIColor]) {
        let gradient = CAGradientLayer()
        gradient.frame = self.frame
        gradient.colors = colors.map { $0.cgColor }
        self.layer.insertSublayer(gradient, at: 0)
    }
}

// MARK: - Add gradient

extension UIView {

    func addGradient(frame: CGRect) {
        let gradientView = UIView(frame: self.frame)
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = frame
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradientLayer.locations = [0.5, 1.0]
        gradientView.layer.insertSublayer(gradientLayer, at: 0)
        addSubview(gradientView)
    }
}
