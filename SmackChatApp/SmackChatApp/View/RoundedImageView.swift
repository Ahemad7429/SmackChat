//
//  RoundedImageView.swift
//  SmackChatApp
//
//  Created by AhemadAbbas Vagh on 24/05/19.
//  Copyright © 2019 AhemadAbbas Vagh. All rights reserved.
//

import UIKit

class RoundedImageView: UIImageView {

        override func awakeFromNib() {
            super.awakeFromNib()
            setUpView()
        }
        
        override func prepareForInterfaceBuilder() {
            super.prepareForInterfaceBuilder()
            setUpView()
        }
        
        func setUpView() {
            layer.cornerRadius = self.frame.width / 2.0
            clipsToBounds = true
        }
        
}


