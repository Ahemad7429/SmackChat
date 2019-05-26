//
//  RectBoundTextField.swift
//  SmackChatApp
//
//  Created by AhemadAbbas Vagh on 26/05/19.
//  Copyright © 2019 AhemadAbbas Vagh. All rights reserved.
//

import UIKit

class RectBoundTextField: UITextField {

    let padding = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 40)
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
}
