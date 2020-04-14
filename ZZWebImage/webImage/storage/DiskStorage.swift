//
//  DiskStorage.swift
//  ZZWebImage
//
//  Created by zw on 2020/4/12.
//  Copyright © 2020 hexoman. All rights reserved.
//

import Foundation
import UIKit

public struct DiskStorage {
    
    public let directoryURL: URL
    
    private let fileManager = FileManager.default
        
    public init() throws {
        let url = try fileManager.url( for: .cachesDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        directoryURL = url.appendingPathComponent(imageFile, isDirectory: true)
        
        try directoryPath()
    }
    
    
    /// 存储图片到磁盘
    func storeImage(_ image: UIImage, forKey key: String) {
        let fileURL = cacheFileURL(forKey: key)
        if let imagedata = image.pngData() {
            do {
                try imagedata.write(to: fileURL)
            } catch {}
        }
    }
    
    /// 获取磁盘中的图片
    func getImage(forKey key: String) -> UIImage? {
        let fileURL = cacheFileURL(forKey: key)
        
        guard fileManager.fileExists(atPath: fileURL.path) else {
            return nil
        }
        
        if isExpried(key) {
            do { try removeImage(forKey: key) } catch {}
            return nil
        }
        
        let image = UIImage(contentsOfFile: fileURL.path)
        if let img = image {
            return img
        }
        return nil
    }
    
    /// 删除图片
    func removeImage(forKey key: String) throws {
        let fileURL = cacheFileURL(forKey: key)
        do {
            try fileManager.removeItem(atPath: fileURL.path)
        } catch {
            throw WebImageError.cacheError(reason: WebImageError.FileError.deleteFileError(fileURL: fileURL, error: error))
        }
    }
    
    /// 清除所有过期图片
    @discardableResult
    func clearExpriedImages() -> [URL]? {
        let propertyKeys: [URLResourceKey] = [.isDirectoryKey, .contentModificationDateKey]
        let urls = allImageURLs(for: propertyKeys)
        
        // 筛选出所有过期的文件
        let expiredImages = urls?.filter { fileURL in
            return isExpried(fileURL.absoluteString)
        }
        // 删除过期文件
        expiredImages?.forEach { url in
            do {try removeImage(forKey: url.absoluteString)} catch {}
        }
        return expiredImages
    }

}

extension DiskStorage {
    
    /// 获取本地存储路径，没有则创建
    private func directoryPath() throws {
        let path = directoryURL.path
    
        guard !fileManager.fileExists(atPath: path) else {
            return
        }
        
        do {
            try fileManager.createDirectory(
                atPath: path,
                withIntermediateDirectories: true,
                attributes: nil)
        } catch {
            throw WebImageError.cacheError(reason: WebImageError.FileError.createFloderError(fileURL: directoryURL, error: error))
        }
    }
    
    /// 将URL作为图片名存储（
    private func cacheFileURL(forKey key: String) -> URL {
        var fileName = key.md5()
        fileName = fileName + ".png"
        return directoryURL.appendingPathComponent(fileName)
    }
        
    /// 是否过期
    private func isExpried(_ url: String) -> Bool {
        let fileURL = cacheFileURL(forKey: url)
        let expirationDate = Date(timeIntervalSinceNow: TimeInterval(-cacheExpriedTime))
        do {
            let attrs = try fileManager.attributesOfItem(atPath: fileURL.path)
            if let modifyDate: Date = attrs[FileAttributeKey.modificationDate] as? Date {
                return modifyDate < expirationDate
            }
            return true
        } catch {
            return true
        }
    }
    
    // 获取对应的文件夹下面的所有文件路径集合
    private func allImageURLs(for propertyKeys: [URLResourceKey]) -> [URL]? {

        guard let directoryFiles = fileManager.enumerator(
            at: directoryURL, includingPropertiesForKeys: propertyKeys, options: .skipsHiddenFiles) else {
            return nil
        }

        guard let urls = directoryFiles.allObjects as? [URL] else {
            return nil
        }
        return urls
    }
    
}
