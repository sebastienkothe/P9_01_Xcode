import UIKit

final class CurrencyViewController: UIViewController {
    
    // MARK: - Properties
    
    // MARK: - Outlets
    @IBOutlet weak var currencyTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK: - Exchange rate
extension CurrencyViewController {
    
}

// MARK: - Keyboard
extension CurrencyViewController: UITextFieldDelegate {
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        currencyTextField.resignFirstResponder()
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == currencyTextField {
           //any task to perform
            
           // Used to dismiss your keyboard
           textField.resignFirstResponder()
        }
        return true
    }
}


