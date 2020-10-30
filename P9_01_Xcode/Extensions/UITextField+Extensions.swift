//
//  UITextField+Extensions.swift
//  P9_01_Xcode
//
//  Created by Fanny BANTREIL on 29/10/2020.
//  Copyright © 2020 Sébastien Kothé. All rights reserved.
//

import Foundation
import UIKit

extension UITextField {
    
    /// Used to add a "finish" button to the keyboard
    func addFinishButtonToKeyboard() {
        
        // ToolBar config
        let toolBar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 40))
        toolBar.tintColor = .systemYellow
        toolBar.barStyle = .blackTranslucent
        
        // Finish button
        let finishButton = UIBarButtonItem(title: "close_keyboard_button_title".localized, style: .done, target: self, action: #selector(self.closeTheKeyboard))
        toolBar.setItems([finishButton], animated: true)
        toolBar.sizeToFit()
        
        self.inputAccessoryView = toolBar
    }
    
    @objc func closeTheKeyboard()
    {
        self.resignFirstResponder()
    }
}
