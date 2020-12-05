import UIKit

final class CurrencyViewController: BaseViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak private var currencyTextField: UITextField!
    @IBOutlet weak private var conversionResultTextView: UITextView!
    @IBOutlet weak var searchActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var sourceCurrencyTextField: UITextField!
    @IBOutlet weak var targetCurrencyTextField: UITextField!
    
    private let sourceCurrencyPickerView = UIPickerView()
    private let targetCurrencyPickerView = UIPickerView()
    
    private let currencyConverter = CurrencyConverter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchActivityIndicator.isHidden = true
        searchButton.layer.cornerRadius = 30
        currencyTextField.addFinishButtonToKeyboard()
        
        
        setupCurrencyPicker(picker: sourceCurrencyPickerView, textField: sourceCurrencyTextField)
        setupCurrencyPicker(picker: targetCurrencyPickerView, textField: targetCurrencyTextField)
        
        self.navigationItem.title = "navigation_item_title_currency".localized
        
        sourceCurrencyTextField.attributedPlaceholder = NSAttributedString(string: "placeholder_sourceCurrencyTextField".localized, attributes: [NSAttributedString.Key.foregroundColor : UIColor.gray])
        targetCurrencyTextField.attributedPlaceholder = NSAttributedString(string: "placeholder_targetCurrencyTextField".localized, attributes: [NSAttributedString.Key.foregroundColor : UIColor.gray])
    }
    
    private func setupCurrencyPicker(picker: UIPickerView, textField: UITextField) {
        picker.delegate = self
        picker.dataSource = self
        
        textField.inputView = picker
        
        let toolBar = UIToolbar()
        
        let emptyBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .flexibleSpace,
            target: self,
            action: nil
        )
        let doneBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self,
            action: #selector(closeKeyboard)
        )
        
        toolBar.items = [emptyBarButtonItem, doneBarButtonItem]
        
        toolBar.sizeToFit()
        
        textField.inputAccessoryView = toolBar
    }
    
    @objc private func closeKeyboard() {
        view.endEditing(true)
    }
    
    var selectedSourceCurrency: Currency = .Euro {
        didSet {
            sourceCurrencyTextField.text = selectedSourceCurrency.displayName
        }
    }
    
    var selectedTargetCurrency: Currency = .Euro {
        didSet {
            targetCurrencyTextField.text = selectedTargetCurrency.displayName
        }
    }
    
}

// MARK: - Exchange rate
extension CurrencyViewController {
    @IBAction private func didTapOnSearchButton() {
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
        handleTheExchangeRateRequest(convertedAmount: convertedAmount)
    }
    
    private func handleTheExchangeRateRequest(convertedAmount: Double) {
        let currencyNetworkManager = CurrencyNetworkManager()
        
        currencyNetworkManager.fetchCurrencyInformation(completion: { [weak self] (result) in
            guard let self = self else {return}
            
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
                    
                    let result = self.currencyConverter.getTheConversionResult(sourceCurrency: sourceCurrencyAsDouble, targetCurrency: targetCurrencyAsDouble, amount: convertedAmount)
                    guard let resultUnwrapped = result else { return }
                    
                    let currencyTargetSymbol = self.selectedTargetCurrency.symbol
                    let currencySourceSymbol = self.selectedSourceCurrency.symbol
                    
                    self.conversionResultTextView.text =
                        "\(convertedAmount)\(currencySourceSymbol) = \(resultUnwrapped)\(currencyTargetSymbol)"
                }
            }
        })
    }
    
    /// Used to get the selected currency
    private func getTheSelectedCurrency(serverResponse: CurrencyResponse, pickerView: UIPickerView) -> Any? {
        let selectedCurrency = serverResponse.rates[Currency.allCases[pickerView.selectedRow(inComponent: 0)].code]
        return selectedCurrency
    }
}

// MARK: - PickerView
extension CurrencyViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        Currency.allCases.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Currency.allCases[row].displayName
    }
}

extension CurrencyViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == sourceCurrencyPickerView {
            selectedSourceCurrency = Currency.allCases[row]
        } else {
            selectedTargetCurrency = Currency.allCases[row]
        }
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


