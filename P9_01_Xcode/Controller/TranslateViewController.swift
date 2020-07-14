//
//  TranslateViewController.swift
//  P9_01_Xcode
//
//  Created by Sébastien Kothé on 13/07/2020.
//  Copyright © 2020 Sébastien Kothé. All rights reserved.
//

import UIKit

class TranslateViewController: UIViewController {
    @IBOutlet weak var translationTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK: - Keyboard
extension TranslateViewController: UITextFieldDelegate {
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        translationTextField.resignFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == translationTextField {
           //any task to perform
           textField.resignFirstResponder() //if you want to dismiss your keyboard
        }
        return true
    }
}
