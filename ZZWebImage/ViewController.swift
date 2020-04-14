//
//  ViewController.swift
//  ZZWebImage
//
//  Created by zw on 2020/4/12.
//  Copyright © 2020 hexoman. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let imageView = UIImageView.init(frame: CGRect(x: 100, y: 100, width: 200, height: 200))
        imageView.setImage("https://webresource.c-ctrip.com/ResH5HotelOnline/R1/HotelUserCouponFooter@2x.png")
        self.view.addSubview(imageView)
    }
}

