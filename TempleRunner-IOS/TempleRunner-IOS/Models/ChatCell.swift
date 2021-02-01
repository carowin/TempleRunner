//
//  ChatCell.swift
//  TempleRunner-IOS
//
//  Created by m2sar on 25/01/2021.
//  Copyright © 2021 UPMC. All rights reserved.
//

import UIKit

class ChatCell: UITableViewCell, UITextViewDelegate {
    var stackView = UIStackView()
    var message = UITextView()
    var name = UILabel()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        message.isScrollEnabled = false
        message.isSelectable = false
        message.textContainer.lineBreakMode = .byWordWrapping
        message.translatesAutoresizingMaskIntoConstraints = false
        message.layer.cornerRadius = 5
        message.layer.masksToBounds = true
        message.layer.borderWidth = 0.5
        //message.numberOfLines = 0
        NSLayoutConstraint.activate([message.widthAnchor.constraint(lessThanOrEqualToConstant: UIScreen.main.bounds.width * 0.70)])
        //message.sizeToFit()
        
        name.frame.size.height = 20
        name.textColor = .darkGray
        name.font = .italicSystemFont(ofSize: 13)
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .leading
        stackView.spacing = 3.0
        
        print(message.frame.height)
        //message.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50)
        //message.frame.size.width =  UIScreen.main.bounds.width
        //stackView.frame.size.width = UIScreen.main.bounds.width
        stackView.frame.size =  CGSize(width: UIScreen.main.bounds.width, height: 0)
        //stackView.layoutMargins = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        stackView.addArrangedSubview(name)
        stackView.addArrangedSubview(message)
        message.delegate = self
        self.contentView.addSubview(stackView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func reSize() -> CGFloat{
        //message.frame.size.height = CGFloat.greatestFiniteMagnitude
        //NSLayoutConstraint.activate([message.widthAnchor.constraint(lessThanOrEqualToConstant: UIScreen.main.bounds.width * 0.70)])
        //message.sizeToFit()
        textViewDidChange(message)
        //let fixedWidth = message.frame.size.width
        //let newSize = message.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
        //message.frame.size = CGSize(width: (newSize.width > fixedWidth ? newSize.width : fixedWidth            ), height: newSize.height)
        print(message.text , message.frame.height)
        stackView.frame.size.height =  message.frame.height + name.frame.height
        return stackView.frame.height
    }
    
    func textViewDidChange(_ textView: UITextView) {
        let size = CGSize(width: textView.frame.width, height: .infinity)
        let estimatedSize = textView.sizeThatFits(size)
        textView.frame.size.height = estimatedSize.height + 5
        print("estimated",estimatedSize.height )
        print("name size",name.frame.height )
        stackView.frame.size.height =  estimatedSize.height  + name.frame.height
    }
}

