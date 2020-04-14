//
//  ImageManager.swift
//  ZZWebImage
//
//  Created by zw on 2020/4/12.
//  Copyright © 2020 hexoman. All rights reserved.
//

import Foundation
import UIKit

/// 对外提供存取接口
public class ImageManager {
    
    static let shared = ImageManager()
    
    let downloader = ImageLoader()
    
    let storage = Storage()
    
    /// 设置图片链接
    public func setImage(_ url: String, callbackQueue: CallbackQueue = .currentMainOrAsync, completion: ImageCompletion? = nil) {
        
        // url为空不合法
        guard !url.isEmpty else {
            return
        }
        
        // 先从缓存获取图片
        storage.value(forKey: url) { [weak self] image in
            if let image = image, let completion = completion {
                callbackQueue.execute { completion(image)}
            } else {
                self?.download(url) { result in
                    switch result {
                    case .success(let image):
                        callbackQueue.execute { completion?(image)}
                    case .failure(_):
                        callbackQueue.execute { completion?(nil)}
                    }
                }
            }
        }
    }
    
    /// 启动下载流程
    func download(_ url: String, completion: ((ImageResult) -> Void)? = nil) {
        downloader.download(url) { result in
            // 下载成功之后进行缓存
            switch result {
            case .success(let image):
                self.storage.store(image, forKey: url)
                completion?(result)
            case .failure(let error):
                completion?(.failure(error))
            }
        }
    }
    
}
