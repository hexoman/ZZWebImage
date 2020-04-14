//
//  MemoryStorage.swift
//  ZZWebImage
//
//  Created by zw on 2020/4/12.
//  Copyright © 2020 hexoman. All rights reserved.
//

import Foundation
import UIKit

public struct MemoryStorage {
    
    let memoryCache = NSCache<NSString, UIImage>()
    
    private let lock = NSLock()
    
    init() {
        self.memoryCache.countLimit = 500
    }
    
    /// 存储图片到内存缓存
    func storeImage(_ image: UIImage, forKey key: String) {
        lock.lock()
        defer { lock.unlock() }
        self.memoryCache.setObject(image, forKey: key as NSString)
    }
    
    /// 获取内存缓存中的图片
    func getImage(forKey key: String) -> UIImage? {
        lock.lock()
        defer { lock.unlock() }
        return self.memoryCache.object(forKey: key as NSString)
    }
    
    /// 删除图片
    func removeImage(forKey key: String) {
        self.memoryCache.removeObject(forKey: key as NSString)
    }

    /// 删除所有内存中的图片
    func removeAllImages() {
        self.memoryCache.removeAllObjects()
    }
}
