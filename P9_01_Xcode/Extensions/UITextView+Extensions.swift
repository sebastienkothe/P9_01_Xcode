//
//  UITextView+Extensions.swift
//  P9_01_Xcode
//
//  Created by Mosma on 03/12/2020.
//  Copyright © 2020 Sébastien Kothé. All rights reserved.
//

import Foundation
import UIKit

extension UITextView {
    
    /// Used to add a "Done" button to the keyboard
    func addDoneButtonToKeyboard() {
        
        // ToolBar config
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 35))
        
        
        let emptyBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .flexibleSpace,
            target: self,
            action: nil
        )
        
        // Done button
        let doneBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self,
            action: #selector(closeKeyboard)
        )
        
        doneBarButtonItem.tintColor = .systemYellow
        
        toolbar.items = [emptyBarButtonItem, doneBarButtonItem]
        toolbar.sizeToFit()
        
        self.inputAccessoryView = toolbar
    }
    
    /// Used to close the keyboard
    @objc func closeKeyboard()
    {
        self.resignFirstResponder()
    }
}
