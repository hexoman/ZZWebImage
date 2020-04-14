//
//  WebImageView.swift
//  ZZWebImage
//
//  Created by zw on 2020/4/13.
//  Copyright © 2020 hexoman. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    
    public func setImage(_ url: String) {
        setImage(url) { [weak self] image in
            guard let image = image else {
                return
            }
            self?.image = image
        }
    }
    
    public func setImage(_ url: String, placeholder image: UIImage?) {
        self.image = image
        setImage(url)
    }
    
    public func setImage(_ url: String, completion: ImageCompletion? = nil) {
        ImageManager.shared.setImage(url) { image in
            if let completion = completion {
                completion(image)
            }
        }
    }
}
