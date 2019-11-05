//
//  StoreStuffModel.swift
//  StoreUser
//
//  Created by Mark Cornelisse on 04/11/2019.
//  Copyright © 2019 Mark Cornelisse. All rights reserved.
//

import UIKit

public class StoreStuffModel: NSObject {
    private static let kUser: String = "kUser"
    @objc public dynamic var user: User?
    var nameTextFieldDelegate: TextFieldDelegate!
    var ageTextFieldDelegate: TextFieldDelegate!
    
    var userDefaults: UserDefaults {
        return UserDefaults.standard
    }
    
    func prepareForUse(with nameTextFieldDelegate: TextFieldDelegate, and ageTextFieldDelegate: TextFieldDelegate) {
        self.nameTextFieldDelegate = nameTextFieldDelegate
        self.ageTextFieldDelegate = ageTextFieldDelegate
    }
    
    func load() {
        if let data = userDefaults.object(forKey: StoreStuffModel.kUser) as? Data {
            let user = try! NSKeyedUnarchiver.unarchivedObject(ofClass: User.self, from: data)
            debugPrint("Data found: \(user!.debugDescription)")
            self.user = user
        } else {
            // In case of No data load initial Data Object
            debugPrint("No data found!!!")
            self.user = User()
        }
    }
    
    enum SaveError: Error {
        case noUserData
        case saveFailed
    }
    
    func save() throws {
        guard let user = user else {
            throw SaveError.noUserData
        }
        debugPrint("Saving user: \(user.debugDescription)")
        let data = try? NSKeyedArchiver.archivedData(withRootObject: user, requiringSecureCoding: true)
        userDefaults.set(data, forKey: StoreStuffModel.kUser)
    }
    
    // MARK: NSObject
    
    override init() {
        user = User()
        super.init()
    }
}
