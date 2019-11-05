//
//  StoreStuffViewController.swift
//  StoreUser
//
//  Created by Mark Cornelisse on 04/11/2019.
//  Copyright © 2019 Mark Cornelisse. All rights reserved.
//

import UIKit

public class StoreStuffViewController: UIViewController {
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var ageField: UITextField!
    @IBOutlet public dynamic var model: StoreStuffModel!

    var userObserver: NSKeyValueObservation!
    
    lazy var numberFormatter: NumberFormatter = {
        let new = NumberFormatter()
        new.numberStyle = .decimal
        return new
    }()
    
    @IBAction func loadPressed(_ sender: UIButton) {
        self.view.endEditing(true)
        model.load()
    }
    
    @IBAction func savePressed(_ sender: UIButton) {
        self.view.endEditing(true)
        do {
            try model.save()
        } catch {
            let alertController = UIAlertController(title: "Uh oh", message: "Unable to save", preferredStyle: .alert)
            let dismissAction = UIAlertAction(title: "Dismiss", style: .cancel, handler: nil)
            alertController.addAction(dismissAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    @IBAction func backgroundTapped(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    // MARK: UIViewController
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        let nameTextFieldDelegate = TextFieldDelegate(with: model.user!, for: .name)
        nameField.delegate = nameTextFieldDelegate
        let ageTextFieldDelegate = TextFieldDelegate(with: model.user!, for: .age)
        ageField.delegate = ageTextFieldDelegate
        model.prepareForUse(with: nameTextFieldDelegate, and: ageTextFieldDelegate)
        
        userObserver = self.observe(\.model.user, options: [.new]) { (mySelf, change) in
            if let newValue = change.newValue {
                mySelf.nameField.text = newValue?.name
                if let age = newValue?.age {
                    mySelf.ageField.text = mySelf.numberFormatter.string(from: NSNumber(value: age))
                }
            }
        }
    }
    
    // MARK: UIResponder
    
    // MARK: NSObject
}

