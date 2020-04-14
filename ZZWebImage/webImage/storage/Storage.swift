//
//  Storage.swift
//  ZZWebImage
//
//  Created by zw on 2020/4/12.
//  Copyright © 2020 hexoman. All rights reserved.
//

import Foundation
import UIKit

public typealias ImageCompletion = (UIImage?) -> Void

public class Storage {
    
    public static let `default` = Storage()

    public var memoryStorage: MemoryStorage
    
    public var diskStorage: DiskStorage
 
    private let ioQueue: DispatchQueue
    
    public convenience init() {
        let memoryStorage = MemoryStorage()
        let diskStorage = try! DiskStorage()
        self.init(memoryCache: memoryStorage, diskCache: diskStorage)
    }
    
    public init(memoryCache: MemoryStorage, diskCache: DiskStorage) {
        self.memoryStorage = memoryCache
        self.diskStorage = diskCache
        ioQueue = DispatchQueue(label: "com.zz.ioQueue")
        
        /// 建立观察者，在内存警告的时候清除内存缓存，在应用终止的时候清除磁盘过期图片
        let notifications: [(Notification.Name, Selector)] =  [
            (UIApplication.didReceiveMemoryWarningNotification, #selector(clearMemoryCache)),
            (UIApplication.willTerminateNotification, #selector(clearExpriedDiskCache))]
        notifications.forEach {
            NotificationCenter.default.addObserver(self, selector: $0.1, name: $0.0, object: nil)
        }
    }
    
    /// 缓存图片
    func store(_ image: UIImage, forKey key: String) {
        /// 开启子线程去存储到磁盘，同时存储一份到内存
        memoryStorage.storeImage(image, forKey: key)
        ioQueue.async { [weak self] in
            self?.diskStorage.storeImage(image, forKey: key)
        }
     }

    /// 获取缓存图片
    func value(forKey key: String,  completion: ImageCompletion? = nil) {
        // 判断图片是否在内存缓存中，在则直接从内存缓存取，否则从磁盘中读取
        ioQueue.async { [weak self] in
            if let image = self?.memoryStorage.getImage(forKey: key), let completion = completion {
                completion(image)
                return
            }
            
            if let image = self?.diskStorage.getImage(forKey: key){
                completion?(image)
            } else {
                completion?(nil)
            }
        }
    }
    
    
    /// 清除内存缓存
    @objc func clearMemoryCache() {
        memoryStorage.removeAllImages()
    }
    
    /// 清除磁盘过期的缓存
    @objc func clearExpriedDiskCache() {
        ioQueue.async { [weak self] in
            self?.diskStorage.clearExpriedImages()
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}


