//
//  CollectionViewCell.swift
//  ZZWebImage
//
//  Created by zw on 2020/4/15.
//  Copyright © 2020 hexoman. All rights reserved.
//

import Foundation
import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    let imageView: UIImageView
    
    convenience required init(coder : NSCoder){
        self.init(frame:CGRect(x: 0, y: 0, width: 80, height: 80))
    }
    
    override init(frame: CGRect) {
        self.imageView = UIImageView.init(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
        super.init(frame: frame)
        self.addSubview(imageView)
    }
    
    func setData(_ url: String) {
        self.imageView.setImage(url)
    }
}
