import UIKit

final class CurrencyViewController: UIViewController {
    
    // MARK: - Properties
    private let currencyNetworkManager = CurrencyNetworkManager()
    
    // MARK: - Outlets
    @IBOutlet weak private var currencyTextField: UITextField!
    @IBOutlet weak private var sourceCurrencyPickerView: UIPickerView!
    @IBOutlet weak private var targetCurrencyPickerView: UIPickerView!
    @IBOutlet weak private var conversionResultLabel: UILabel!
    
}

// MARK: - Exchange rate
extension CurrencyViewController {
    @IBAction private func didTapOnSearchButton() {
        
        guard let amount = currencyTextField.text else { return }
        guard let convertedAmount = Double(amount) else { return }
        
        currencyNetworkManager.fetchCurrencyInformation(completion: {(result) in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    self.handleError(error: error)
                case .success(let response):
                    
                    let sourceCurrency = response.rates[currencies[self.sourceCurrencyPickerView.selectedRow(inComponent: 0)].code]
                    let targetCurrency = response.rates[currencies[self.targetCurrencyPickerView.selectedRow(inComponent: 0)].code]
                    let result = self.convertCurrencies(sourceCurrency: sourceCurrency as! Double, targetCurrency: targetCurrency as! Double, amount: convertedAmount)
                    
                    self.conversionResultLabel.text = self.convertAndFormat(temp: result)
                }
            }
        })
    }
    
    /// Used to display alert messages
    private func handleError(error: NetworkError) {
        let alert = UIAlertController(title: "error_message".localized, message: error.title, preferredStyle: .alert)
        let action = UIAlertAction(title: "validation_message".localized, style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    /// Used to convert the currencies
    private func convertCurrencies(sourceCurrency: Double, targetCurrency: Double, amount: Double) -> Double {
        return amount / sourceCurrency * targetCurrency
    }
    
    /// To convert the result from Double to String in the particular format
    private func convertAndFormat(temp: Double) -> String {
        let tempVar = String(format: "%g", temp)
        return tempVar
    }
}

// MARK: - PickerView
extension CurrencyViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    internal func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    internal func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        currencies.count
    }
    
    internal func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return currencies[row].name
    }
}

// MARK: - Keyboard
extension CurrencyViewController: UITextFieldDelegate {
    
    @IBAction private func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        currencyTextField.resignFirstResponder()
    }
    
    internal func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == currencyTextField {
            //any task to perform
            
            // Used to dismiss your keyboard
            textField.resignFirstResponder()
        }
        return true
    }
}


