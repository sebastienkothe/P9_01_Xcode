//
//  CurrencyViewController.swift
//  P9_01_Xcode
//
//  Created by Sébastien Kothé on 13/07/2020.
//  Copyright © 2020 Sébastien Kothé. All rights reserved.
//

import UIKit

class CurrencyViewController: UIViewController {

    @IBOutlet weak var currencyTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK: - Keyboard
extension CurrencyViewController: UITextFieldDelegate {
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        currencyTextField.resignFirstResponder()
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == currencyTextField {
           //any task to perform
           textField.resignFirstResponder() //if you want to dismiss your keyboard
        }
        return true
    }
}


