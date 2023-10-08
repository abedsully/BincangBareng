//
//  Extension.swift
//  BincangBareng
//
//  Created by Stefanus Albert Wilson on 10/8/23.
//

import UIKit

extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get { return self.cornerRadius}
        set {
            self.layer.cornerRadius = newValue
        }
    }
}
