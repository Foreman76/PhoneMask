//
//  PhoneFormatter.swift
//  PhoneMask
//
//  Created by admin on 30.11.2022.
//

import Foundation

class PhoneFormatter: Formatter {
    
    override func string(for obj: Any?) -> String? {
        if let string = obj as? String {
            let str = formattedPhone(phone: string)
            return str
        }
        return nil
    }
    
    override func getObjectValue(_ obj: AutoreleasingUnsafeMutablePointer<AnyObject?>?, for string: String, errorDescription error: AutoreleasingUnsafeMutablePointer<NSString?>?) -> Bool {
        obj?.pointee = string as AnyObject?
        return true
    }
    
    /// mask example: `+X (XXX) XXX-XXXX`
    func formattedPhone(phone: String) -> String {
        let numbers = phone.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        let mask = "+7 (XXX) XXX-XXXX"
        var result = ""
        var index = numbers.startIndex // numbers iterator

        // iterate over the mask characters until the iterator of numbers ends
        for ch in mask where index < numbers.endIndex {
            if ch == "X" {
                // mask requires a number in this place, so take the next one
                result.append(numbers[index])

                // move numbers iterator to the next index
                index = numbers.index(after: index)

            } else {
                result.append(ch) // just append a mask character
            }
        }
        return result
    }
}

