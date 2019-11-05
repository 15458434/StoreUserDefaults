//
//  TextFieldDelegate.swift
//  StoreUser
//
//  Created by Mark Cornelisse on 04/11/2019.
//  Copyright © 2019 Mark Cornelisse. All rights reserved.
//

import UIKit

class TextFieldDelegate: NSObject, UITextFieldDelegate {
    enum Config {
        case name
        case age
    }
    
    private let user: User
    private let config: Config
    private lazy var numberFormatter: NumberFormatter = {
        let new = NumberFormatter()
        new.numberStyle = .decimal
        return new
    }()
    
    init(with user: User, for configuarion: Config) {
        self.user = user
        self.config = configuarion
        super.init()
    }
    
    // MARK: UITextFieldDelegate
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        switch config {
        case .name:
            ()
        case .age:
            let originalString = textField.text ?? ""
            let newString = originalString.replacingCharacters(in: Range(range, in: originalString)!, with: string)
            if let number = numberFormatter.number(from: newString), number.int64Value >= 0 && number.int64Value <= 255 {
                if #available(iOS 13.0, *) {
                    textField.textColor = .label
                } else {
                    textField.textColor = .darkText
                }
            } else {
                textField.textColor = .red
            }
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        guard reason == .committed else {
            return
        }
        
        switch config {
        case .name:
            user.name = textField.text
        case .age:
            if let text = textField.text {
                let number = numberFormatter.number(from: text)!
                user.age = number.uint8Value
            } else {
                user.age = nil
            }
        }
    }
    
    // MARK: NSObject
}
