//
//  User.swift
//  StoreUser
//
//  Created by Mark Cornelisse on 04/11/2019.
//  Copyright © 2019 Mark Cornelisse. All rights reserved.
//

import UIKit

public class User: NSObject, NSSecureCoding {
    static let kName: String = "kName"
    static let kAge: String = "kAge"
    
    public var name: String?
    public var age: UInt8?
    
    // MARK: NSSecureCoding
    
    public static var supportsSecureCoding: Bool {
        return true
    }
    
    // MARK: NSCoding
    
    required public init?(coder: NSCoder) {
        self.name = coder.decodeObject(of: NSString.self, forKey: User.kName) as String?
        self.age = (coder.decodeObject(of: NSNumber.self, forKey: User.kAge) as NSNumber?)?.uint8Value
        self.age = (coder.decodeObject(forKey: User.kAge) as? NSNumber)?.uint8Value
        super.init()
    }
    
    public func encode(with coder: NSCoder) {
        if let name = name {
            coder.encode(name as NSString, forKey: User.kName)
        }
        if let age = age {
            let number = NSNumber(value: age)
            coder.encode(number, forKey: User.kAge)
        }
    }
    
    // MARK: NSObject
    
    override init() {
        super.init()
    }
    
    // MARK: CustomDebugStringConvertible
    
    public override var debugDescription: String {
        let baseString = super.debugDescription
        return baseString + ", nane: \(String(describing: self.name)), age: \(String(describing: self.age))"
    }
}
