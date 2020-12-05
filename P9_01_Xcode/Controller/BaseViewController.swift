//
//  BaseViewController.swift
//  P9_01_Xcode
//
//  Created by Fanny BANTREIL on 29/10/2020.
//  Copyright © 2020 Sébastien Kothé. All rights reserved.
//

import Foundation
import UIKit

class BaseViewController: UIViewController {
    
    /// Used to handle errors from the viewcontrollers
    func handleError(error: NetworkError) {
        let alert = UIAlertController(title: "error_message".localized, message: error.title, preferredStyle: .alert)
        let action = UIAlertAction(title: "validation_message".localized, style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    /// Used to hide items
    func toggleActivityIndicator(shown: Bool, activityIndicator: UIActivityIndicatorView, button: UIButton) {
        activityIndicator.isHidden = !shown
        button.isHidden = shown
    }
}
