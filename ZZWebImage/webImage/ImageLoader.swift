//
//  ImageLoader.swift
//  ZZWebImage
//
//  Created by zw on 2020/4/12.
//  Copyright © 2020 hexoman. All rights reserved.
//

import Foundation
import UIKit

public typealias ImageResult = Result<UIImage, WebImageError>

public class ImageLoader {
    
    private var session: URLSession = URLSession(configuration: .default)
    
    private var sessionTasks: [String : URLSessionDataTask]  = [:]
    
    private let lock = NSLock()
    
    /// 增加一个task到任务列表
    private func appendTask(_ url: String, task: URLSessionDataTask) {
        lock.lock()
        defer { lock.unlock() }
        sessionTasks[url] = task
    }
    
    /// 任务取消或者完成后删除任务列表对应的task
    private func removeTask(_ url: String) {
        guard sessionTasks.keys.contains(url) else {
            return
        }
        lock.lock()
        defer {lock.unlock()}
        sessionTasks[url] = nil
    }
    
    /// 取消任务列表中所有请求
    private func cancelAll() {
        lock.lock()
        let taskValues = sessionTasks.values
        lock.unlock()
        for task in taskValues {
            task.cancel()
        }
    }
    
    /// 对外执行下载的接口
    public func download(_ url: String, completion: @escaping(ImageResult) -> Void) {
        //判断当前url对应的dask是否已经存在
        if let _ = sessionTasks[url] {
            return
        } else {
            if let URL = URL(string: url) {
                let sessionDataTask = session.dataTask(with: URL) { [weak self]
                    (data, response, error) in
                    if let data = data, let img = UIImage.init(data: data) {
                        completion(.success(img))
                    } else if let res = response {
                        completion(.failure(WebImageError.requestError(reason: WebImageError.RequestError.requestFailure(request: res))))
                    }
                    self?.removeTask(url)
                }
                sessionDataTask.resume()
                appendTask(url, task: sessionDataTask)
            }           
        }
    }

}
