//
//  CallbackQueue.swift
//  ZZWebImage
//
//  Created by zw on 2020/4/13.
//  Copyright © 2020 hexoman. All rights reserved.
//

import Foundation
import CommonCrypto

public enum CallbackQueue {
    /// 主线程执行
    case asyncMain
    
    /// 是主线程和主队列时, 直接派发任务。 否则异步到主线程执行
    case currentMainOrAsync
    
    /// 当前队列不做改变
    case unchange
 
    func execute(_ block: @escaping () -> Void) {
        switch self {
        case .asyncMain:
            DispatchQueue.main.async { block() }
        case .currentMainOrAsync:
            DispatchQueue.main.safeAsync { block() }
        case .unchange:
            block()
        }
    }
}

extension DispatchQueue {
    func safeAsync(_ block: @escaping ()->()) {
        if self === DispatchQueue.main && Thread.isMainThread {
            block()
        } else {
            async { block() }
        }
    }
}

extension String {
    func md5() -> String {
         let str = self.cString(using: String.Encoding.utf8)
         let strLen = CUnsignedInt(self.lengthOfBytes(using: String.Encoding.utf8))
         let digestLen = Int(CC_MD5_DIGEST_LENGTH)
         let result = UnsafeMutablePointer<UInt8>.allocate(capacity: 16)
         CC_MD5(str!, strLen, result)
         let hash = NSMutableString()
         for i in 0 ..< digestLen {
             hash.appendFormat("%02x", result[i])
         }
         free(result)
         return String(format: hash as String)
    }
}
