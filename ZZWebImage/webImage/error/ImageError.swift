//
//  ImageError.swift
//  ZZWebImage
//
//  Created by zw on 2020/4/12.
//  Copyright © 2020 hexoman. All rights reserved.
//

import Foundation

public enum WebImageError: Error {
    
    public enum RequestError {
        /// 无效的URL
        case invalidURL(request: URLRequest)
        
        /// 请求失败
        case requestFailure(request: URLResponse)
    }
    
    public enum FileError {
        /// 从本地文件读取失败
        case readDataFromFileError(fileURL: URL, key: String, data: Data, error: Error)
        
        /// 写入本地文件失败
        case writeToFileError(fileURL: URL, key: String, data: Data, error: Error)
        
        /// 获取文件属性失败
        case getFileAttrsError(fileURL: URL, error: Error)
        
        /// 创建文件夹失败
        case createFloderError(fileURL: URL, error: Error)
        
        /// 删除文件失败
        case deleteFileError(fileURL: URL, error: Error)
        
        case generalError(error: Error)

    }
    
    case requestError(reason: RequestError)
    
    case cacheError(reason: FileError)
}

extension WebImageError.FileError {
    var errorDescription: String? {
        switch self {
        case .readDataFromFileError(let fileURL, let key, let data, let error):
            return "从本地文件读取失败 url: \(fileURL), key: \(key), data length: \(data.count). " +
            " error: \(error)."
        case .writeToFileError(let fileURL, let key, let data, let error):
            return "写入本地文件失败 url: \(fileURL), key: \(key), data length: \(data.count). " +
            " error: \(error)."
        case .getFileAttrsError(let fileURL, let error):
            return "获取文件属性失败 url: \(fileURL). " + " error: \(error)."
        case .createFloderError(let fileURL, let error):
            return "创建文件夹失败 url: \(fileURL). " + " error: \(error)."
        case .deleteFileError(let fileURL, let error):
            return "删除文件失败 url: \(fileURL). " + " error: \(error)."
        case .generalError(let error):
            return  "error: \(error)."
        }
    }
}
