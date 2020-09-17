import UIKit
import CommonCrypto

func testCrypt(data:Data, keyData:Data, ivData:Data, operation:Int) -> Data {
    let cryptLength  = size_t(data.count + kCCBlockSizeAES128)
    var cryptData = Data(count:cryptLength)

    let keyLength             = size_t(kCCKeySizeAES128)
    let options   = CCOptions(kCCOptionPKCS7Padding)


    var numBytesEncrypted :size_t = 0

    let cryptStatus = cryptData.withUnsafeMutableBytes {cryptBytes in
        data.withUnsafeBytes {dataBytes in
            ivData.withUnsafeBytes {ivBytes in
                keyData.withUnsafeBytes {keyBytes in
                    CCCrypt(CCOperation(operation),
                              CCAlgorithm(kCCAlgorithmAES),
                              options,
                              keyBytes, keyLength,
                              ivBytes,
                              dataBytes, data.count,
                              cryptBytes, cryptLength,
                              &numBytesEncrypted)
                }
            }
        }
    }

    if UInt32(cryptStatus) == UInt32(kCCSuccess) {
        cryptData.removeSubrange(numBytesEncrypted..<cryptData.count)

    } else {
        print("Error: \(cryptStatus)")
    }

    return cryptData;
}
