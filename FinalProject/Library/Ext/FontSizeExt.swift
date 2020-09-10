//
//  FontSizeExt.swift
//  FinalProject
//
//  Created by MBA0176 on 4/28/20.
//  Copyright © 2020 MBA0176. All rights reserved.
//

import UIKit

extension CGFloat {
    var scaling: CGFloat {
        return self * ratio
    }
}

extension UILabel {
    @IBInspectable var fontSize: CGFloat {
        get { return self.fontSize }
        set {
            font = font.withSize(newValue.scaling)
        }
    }
}

extension UITextField {
    @IBInspectable var fontSize: CGFloat {
        get { return self.fontSize }
        set {
            font = font?.withSize(newValue.scaling)
        }
    }
}

extension UITextView {
    @IBInspectable var fontSize: CGFloat {
        get { return self.fontSize }
        set {
            font = font?.withSize(newValue.scaling)
        }
    }
}

extension UIButton {
    @IBInspectable var fontSize: CGFloat {
        get { return self.fontSize }
        set {
            titleLabel?.font = titleLabel?.font?.withSize(newValue.scaling)
        }
    }
}
