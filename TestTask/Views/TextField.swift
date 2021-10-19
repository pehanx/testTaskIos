//
//  TextField.swift
//  TestTask
//
//  Created by Nikita Spekhin on 20.10.2021.
//

import Foundation
import UIKit

class TextField:UITextField {
    
    private let padding = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 32)
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        setupField()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder:coder)
        setupField()
    }
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func clearButtonRect(forBounds bounds: CGRect) -> CGRect {
        let originalRect = super.clearButtonRect(forBounds: bounds)
        return originalRect.offsetBy(dx: -8, dy: 0)
    }
    
    private func setupField(){
        autocapitalizationType  = .none
        tintColor               = .black
        textColor               = .black
        backgroundColor         = .white
        autocorrectionType      = .no
        layer.cornerRadius      = 8
        layer.borderWidth       = 1
        layer.borderColor       = UIColor.systemGray.cgColor
        clipsToBounds           = true
        clearButtonMode         = .whileEditing
        heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
}
