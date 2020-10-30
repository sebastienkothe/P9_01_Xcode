import UIKit

final class CurrencyViewController: RootController {
    
    // MARK: - IBOutlets
    @IBOutlet weak private var currencyTextField: UITextField!
    @IBOutlet weak private var sourceCurrencyPickerView: UIPickerView!
    @IBOutlet weak private var targetCurrencyPickerView: UIPickerView!
    @IBOutlet weak private var conversionResultLabel: UILabel!
    @IBOutlet weak var searchActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var searchButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchActivityIndicator.isHidden = true
        searchButton.layer.cornerRadius = 30
        currencyTextField.addFinishButtonToKeyboard()
    }
}

// MARK: - Exchange rate
extension CurrencyViewController {
    @IBAction private func didTapOnSearchButton() {
        
        let currencyNetworkManager = CurrencyNetworkManager()
        
        guard let amount =
                currencyTextField.text?.trimmingCharacters(in: .whitespaces) else { return }
        
        // Used to handle the case where the text field is empty
        guard amount != "" else {
            handleError(error: .emptyTextField)
            return
        }
        
        guard let convertedAmount = Double(amount) else { return }
        
        // To show the activity indicator and hide the button
        toggleActivityIndicator(shown: true, activityIndicator: searchActivityIndicator, button: searchButton)
        
        currencyNetworkManager.fetchCurrencyInformation(completion: {(result) in
            DispatchQueue.main.async {
                self.toggleActivityIndicator(shown: false, activityIndicator: self.searchActivityIndicator, button: self.searchButton)
                
                switch result {
                case .failure(let error):
                    self.handleError(error: error)
                    
                case .success(let response):
                    
                    let sourceCurrency = self.getTheSelectedCurrency(serverResponse: response, pickerView: self.sourceCurrencyPickerView)
                    
                    let targetCurrency = self.getTheSelectedCurrency(serverResponse: response, pickerView: self.targetCurrencyPickerView)
                    
                    guard let sourceCurrencyAsDouble = sourceCurrency as? Double else {return}
                    guard let targetCurrencyAsDouble = targetCurrency as? Double else {return}
                    
                    let result = self.convertCurrencies(sourceCurrency: sourceCurrencyAsDouble, targetCurrency: targetCurrencyAsDouble, amount: convertedAmount)
                    
                    self.conversionResultLabel.text = self.convertAndFormat(temp: result)
                }
            }
        })
    }
    
    /// Used to get the selected currency
    private func getTheSelectedCurrency(serverResponse: CurrencyResponse, pickerView: UIPickerView) -> Any? {
        let selectedCurrency = serverResponse.rates[currencies[pickerView.selectedRow(inComponent: 0)].code]
        return selectedCurrency
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


