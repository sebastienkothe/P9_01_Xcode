//
//  WeatherViewController.swift
//  P9_01_Xcode
//
//  Created by Sébastien Kothé on 13/07/2020.
//  Copyright © 2020 Sébastien Kothé. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {
    @IBOutlet weak var weatherSearchTextField: UITextField!
    @IBOutlet weak var weatherSearchButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK: - Keyboard
extension WeatherViewController: UITextFieldDelegate {
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        weatherSearchTextField.resignFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == weatherSearchTextField {
            //any task to perform
            textField.resignFirstResponder() //if you want to dismiss your keyboard
        }
        return true
    }
}
