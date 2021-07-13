////
////  KeyChain.swift
////  appUIKit
////
////  Created by sysadmin on 13/07/21.
////
//
//import Foundation
//class KeyChain{
//    class func save(key: String, data: NSData) {
//            let query = [
//                kSecClass as String       : kSecClassGenericPassword as String,
//                kSecAttrAccount as String : key,
//                kSecValueData as String   : data ] as [String : Any]
//
//        SecItemDelete(query as CFDictionary)
//
//        let status: OSStatus = SecItemAdd(query as CFDictionary, nil)
//
//        }
//
//        class func load(key: String) -> NSData? {
//            let query = [
//                kSecClass as String       : kSecClassGenericPassword,
//                kSecAttrAccount as String : key,
//                kSecReturnData as String  : kCFBooleanTrue,
//                kSecMatchLimit as String  : kSecMatchLimitOne ] as [String : Any]
//
//            var dataTypeRef :Unmanaged<AnyObject>?
//
//            let status: OSStatus = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)
//
//            if status == noErr {
//                return (dataTypeRef!.takeRetainedValue() as! NSData)
//            } else {
//                return nil
//            }
//
//
//        }
//
//        class func stringToNSDATA(string : String)->NSData
//        {
//            let _Data = (string as NSString).dataUsingEncoding(NSUTF8StringEncoding.rawValue)
//            return _Data!
//
//        }
//
//
//        class func NSDATAtoString(data: NSData)->String
//        {
//            var returned_string : String = NSString(data: data, encoding: NSUTF8StringEncoding)! as String
//            return returned_string
//        }
//
//        class func intToNSDATA(r_Integer : Int)->NSData
//        {
//
//                var SavedInt: Int = r_Integer
//                let _Data = NSData(bytes: &SavedInt, length: sizeof(Int))
//            return _Data
//
//        }
//        class func NSDATAtoInteger(_Data : NSData) -> Int
//        {
//                var RecievedValue : Int = 0
//                _Data.getBytes(&RecievedValue, length: sizeof(Int))
//                return RecievedValue
//
//        }
//        class func CreateUniqueID() -> String
//        {
//            var uuid: CFUUIDRef = CFUUIDCreate(nil)
//            var cfStr:CFString = CFUUIDCreateString(nil, uuid)
//
//            var nsTypeString = cfStr as NSString
//            var swiftString:String = nsTypeString as String
//            return swiftString
//        }
//
//        //EXAMPLES
//    //
//    //    //Save And Parse Int
//
//
//    //    var Int_Data = KeyChain.intToNSDATA(555)
//    //    KeyChain.save("MAMA", data: Int_Data)
//    //    var RecievedDataAfterSave = KeyChain.load("MAMA")
//    //    var NSDataTooInt = KeyChain.NSDATAtoInteger(RecievedDataAfterSave!)
//    //    println(NSDataTooInt)
//    //
//    //
//    //    //Save And Parse String
//
//
//    //    var string_Data = KeyChain.stringToNSDATA("MANIAK")
//    //    KeyChain.save("ZAHAL", data: string_Data)
//    //    var RecievedDataStringAfterSave = KeyChain.load("ZAHAL")
//    //    var NSDATAtoString = KeyChain.NSDATAtoString(RecievedDataStringAfterSave!)
//    //    println(NSDATAtoString)
//
//}
