//
//  Extension.swift
//  Marvel Characters
//
//  Created by Softbuilder Hibrido on 24/08/21.
//

import Foundation
import CommonCrypto

extension Date {
    var currentTimeStamp: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy_MM_dd_hh_mm_ss"
        return (formatter.string(from: Date()) as NSString) as String
    }
}

extension String {
    var md5: String {
        let data = Data(utf8) as NSData
        var hash = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
        CC_MD5(data.bytes, CC_LONG(data.length), &hash)
        return hash.map { String(format: "%02hhx", $0) }.joined()
    }
}
