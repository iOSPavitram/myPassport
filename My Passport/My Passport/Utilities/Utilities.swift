//
//  Utilities.swift
//  My Passport
//
//  Created by Pavi on 10/12/18.
//  Copyright © 2018 Student. All rights reserved.
//

import UIKit

class Utilities: NSObject {
    
    static func convertDateFormater(_ date: String) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss z"
        let date = dateFormatter.date(from: date)
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return  dateFormatter.string(from: date!)
        
    }
    
    static func convertDate(_ date: Date) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-YYYY HH:mm:ss"
        return dateFormatter.string(from: date)
    }

    static func JSONStringify(value: AnyObject, prettyPrinted: Bool = false) -> String {
        let options = prettyPrinted ? JSONSerialization.WritingOptions.prettyPrinted : JSONSerialization.WritingOptions.init(rawValue:0)
        
        if JSONSerialization.isValidJSONObject(value) {
            if let data = try? JSONSerialization.data(withJSONObject: value, options:options) {
                
                if let string = String(data: data, encoding: String.Encoding.utf8) {
                    return string as String
                }
            }
        }
        return ""
    }

}

extension String {
    func stringByAddingPercentEncodingForRFC3986() -> String {
        let unreserved = "-._~/?"
        let allowed = NSMutableCharacterSet.alphanumeric()
        allowed.addCharacters(in: unreserved)
        return addingPercentEncoding(withAllowedCharacters:allowed as CharacterSet)!
    }
}
