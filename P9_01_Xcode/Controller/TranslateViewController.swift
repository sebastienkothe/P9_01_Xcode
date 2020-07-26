import UIKit

final class TranslateViewController: UIViewController {
    
    // MARK: - Properties
    private let translateNetworkManager = TranslateNetworkManager()
    
    // MARK: - Outlets
    @IBOutlet weak private var translationTextField: UITextField!
    @IBOutlet weak private var translationResultLabel: UILabel!
    @IBOutlet weak private var selectionLanguagePickerView: UIPickerView!
}

// MARK: - Translation
extension TranslateViewController {
    @IBAction private func didTapOnTranslateButton() {
        
        guard let expression = translationTextField.text else { return }
        let selectedLanguageIndex = selectionLanguagePickerView.selectedRow(inComponent: 0)
        let selectedLanguageCode = languages[selectedLanguageIndex].code
        
        translateNetworkManager.fetchTranslationInformationFor(expression: expression, languageCode: selectedLanguageCode, completion: {(result) in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    self.handleError(error: error)
                case .success(let response):
                    guard let translatedText = response.data.translations.first?.translatedText else { return }
                    guard let detectedSourceLanguage = response.data.translations.first?.detectedSourceLanguage else { return }
                    self.translationResultLabel.text =
                        
                    """
                    Detected source language : \(detectedSourceLanguage)\n
                    Translated text : \(translatedText)
                    """
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
}

// MARK: - PickerView
extension TranslateViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    internal func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    internal func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return languages.count
    }
    
    internal func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return languages[row].name
    }
}

// MARK: - Keyboard
extension TranslateViewController: UITextFieldDelegate {
    @IBAction private func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        translationTextField.resignFirstResponder()
    }
    
    internal func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == translationTextField {
            //any task to perform
            
            // Used to dismiss your keyboard
            textField.resignFirstResponder()
        }
        return true
    }
}
