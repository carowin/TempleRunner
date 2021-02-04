//
//  CellInfos.swift
//  TempleRunner-IOS
//
//  Created by m2sar on 25/01/2021.
//  Copyright © 2021 UPMC. All rights reserved.
//

import UIKit

class CellInfos: NSObject {
    var name = ""
    var message = ""
    var size : CGFloat = 0.0
    init(name : String, message : String) {
        self.name = name
        self.message = message
        /* let messageLabel = UILabel()
         messageLabel.numberOfLines = 0
         messageLabel.text = message
         NSLayoutConstraint.activate([messageLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 200)])
         messageLabel.sizeToFit()
         print("info %f", messageLabel.frame.size.width)
         size = messageLabel.frame.size.width*/
    }
}
