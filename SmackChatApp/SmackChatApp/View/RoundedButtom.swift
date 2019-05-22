//
//  RoundedButtom.swift
//  SmackChatApp
//
//  Created by AhemadAbbas Vagh on 22/05/19.
//  Copyright © 2019 AhemadAbbas Vagh. All rights reserved.
//

import UIKit

@IBDesignable
class RoundedButtom: UIButton {

    @IBInspectable var cornerRadius: CGFloat = 3.0 {
        didSet {
            layer.cornerRadius = self.cornerRadius
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        setUpView()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setUpView()
    }
    
    func setUpView() {
         layer.cornerRadius = self.cornerRadius
    }

}
